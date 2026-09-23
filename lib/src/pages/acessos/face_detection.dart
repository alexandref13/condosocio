import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:condosocio/main.dart';
import 'package:condosocio/src/controllers/facial_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/pages/acessos/face_detection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import '../../components/utils/edge_alert_widget.dart';
import '../../components/utils/edge_alert_error_widget.dart';

/// Every state the on-screen guide can be in. Only [aligned] and [counting]
/// are "good" (green); everything else means the countdown cannot run.
enum _GuideState {
  noFace,
  multipleFaces,
  moveLeft,
  moveRight,
  moveUp,
  moveDown,
  tooFar,
  tooClose,
  offAngle,
  aligned,
  counting,
}

class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  // ---------------------------------------------------------------------
  // Calibration constants. Nothing below this block should ever hardcode a
  // fresh magic number — new tuning should extend this section instead.
  // ---------------------------------------------------------------------

  /// Oval size as a fraction of the screen. Must match what `_overlay` draws,
  /// since the guide the user sees and the guide the math checks against
  /// have to be the exact same ellipse.
  static const double _kOvalWidthFactor = 0.75;
  static const double _kOvalHeightFactor = 0.48;

  /// Points sampled around the detected face's ellipse outline to test how
  /// much of it is contained by the guide oval (see `_maxBoundaryT`).
  static const int _kEllipseSamples = 20;

  /// Exponential-moving-average weight applied to every noisy per-frame
  /// signal (center offset, size ratio, containment, head pose). Higher =
  /// reacts faster but jitters more; lower = smoother but laggier.
  static const double _kEmaAlpha = 0.35;

  /// Center-offset tolerance, normalized to the oval's own radius on each
  /// axis (0 = dead center, 1 = at the oval's edge). Two tiers: the tighter
  /// one gates entry into "aligned", the looser one is used once already
  /// aligned so the border doesn't flicker on tiny wobble (hysteresis).
  static const double _kCenterOffsetEnter = 0.16;
  static const double _kCenterOffsetExit = 0.24;

  /// Ideal face width, as a fraction of the oval's width. Also two tiers for
  /// the same hysteresis reason.
  ///
  /// Calibrated from on-device debug readings (2026-09-18): ML Kit's
  /// boundingBox is noticeably more generous than the visible face — a
  /// visually well-framed shot measured sizeRatio≈0.96, a visibly-too-far
  /// shot (clear empty margin top/bottom) measured≈0.61, and a visibly-too-
  /// close shot (forehead cropped) measured≈1.21. The band below sits
  /// between those.
  static const double _kSizeRatioMinEnter = 0.75;
  static const double _kSizeRatioMaxEnter = 1.05;
  static const double _kSizeRatioMinExit = 0.68;
  static const double _kSizeRatioMaxExit = 1.12;

  /// Safety net on top of the center+size checks: the worst-case (max)
  /// normalized distance from the oval's center among points sampled around
  /// the face's own ellipse. 1.0 means that point sits exactly on the guide
  /// oval's edge; above 1.0 means part of the face has crossed outside it.
  /// Raised alongside the size-ratio band above, for the same reason.
  static const double _kBoundaryEnter = 1.15;
  static const double _kBoundaryExit = 1.25;

  /// Head pose limits (degrees). Faces turned/tilted more than this are
  /// rejected even if otherwise perfectly framed.
  static const double _kMaxYawDegrees = 15;
  static const double _kMaxRollDegrees = 12;

  /// Two detections are treated as the same face (rather than
  /// "multiple faces") when their boxes overlap by at least this much
  /// (Intersection-over-Union). Guards against ML Kit occasionally emitting
  /// a duplicate/ghost box for a single real face.
  static const double _kDuplicateIoUThreshold = 0.5;

  /// How long the face must stay continuously aligned before the 3-2-1
  /// countdown itself starts.
  static const Duration _kStabilizeDuration = Duration(milliseconds: 500);

  /// How long a single bad frame is tolerated before the countdown/alignment
  /// is actually cancelled. This exists purely to absorb ML Kit frame-to-
  /// frame jitter — it must stay short, or "any small movement resets the
  /// counter" turns into "you can wander off for a full second".
  static const Duration _kJitterTolerance = Duration(milliseconds: 140);

  static const Duration _kCountdownTick = Duration(seconds: 1);
  static const int _kCountdownStart = 3;

  /// ML Kit detector tuning.
  static const double _kMlkitMinFaceSize = 0.15;

  /// TEMP calibration aid: shows the raw/smoothed numbers behind every
  /// decision (dx/dy, size ratio, boundary containment, yaw/roll) so the
  /// thresholds above can be tuned against real devices instead of guesses.
  /// Flip to false (or delete the panel + this flag) once calibrated.
  static const bool _kDebugOverlay = false;

  // ---------------------------------------------------------------------

  final _overlayKey = GlobalKey<FaceDetectionOverlayState>();

  _GuideState _state = _GuideState.noFace;
  int _countdown = _kCountdownStart;

  Timer? _stabilizeTimer;
  Timer? _countdownTimer;
  Timer? _jitterTimer;
  _GuideState? _pendingBadState;
  DateTime? _lastAlignedAt;

  /// Last detected face's box as a fraction (0..1 on each axis) of the
  /// camera's full field of view. Used to center the final crop on where the
  /// face actually is, instead of blindly on the raw photo's geometric
  /// center — `takePicture()` returns the full, uncropped sensor frame,
  /// which usually shows more above/below than the on-screen preview (that
  /// crops to fill the portrait screen), so a geometric-center crop can clip
  /// the top of the head even when the face looked perfectly framed live.
  Rect? _lastFaceFraction;

  bool _capturing = false;

  // Smoothed (EMA) signals from the last few frames.
  double? _emaDx;
  double? _emaDy;
  double? _emaSizeRatio;
  double? _emaBoundaryT;
  double? _emaYaw;
  double? _emaRoll;

  // Mirrors of the values above, kept even when EMA is reset, purely for the
  // debug panel — see `_kDebugOverlay`.
  int _dbgFaceCount = 0;
  double? _dbgDx;
  double? _dbgDy;
  double? _dbgSizeRatio;
  double? _dbgBoundaryT;
  double? _dbgYaw;
  double? _dbgRoll;

  LoginController loginController = Get.put(LoginController());
  FacialController facialController = Get.put(FacialController());
  File? _selectedFile;

  final uri = Uri.parse(
      "https://www.condosocio.com.br/flutter/upload_imagem_facial.php");

  Color get _stateColor {
    switch (_state) {
      case _GuideState.aligned:
      case _GuideState.counting:
        return Colors.green.shade700;
      case _GuideState.tooFar:
      case _GuideState.tooClose:
      case _GuideState.offAngle:
        return Colors.orange;
      case _GuideState.noFace:
      case _GuideState.multipleFaces:
      case _GuideState.moveLeft:
      case _GuideState.moveRight:
      case _GuideState.moveUp:
      case _GuideState.moveDown:
        return Colors.red.shade700;
    }
  }

  String get _stateMessage {
    switch (_state) {
      case _GuideState.noFace:
        return 'Nenhum rosto detectado\nPosicione seu rosto no oval';
      case _GuideState.multipleFaces:
        return 'Mantenha apenas um rosto na câmera';
      case _GuideState.moveLeft:
        return 'Mova um pouco para a esquerda';
      case _GuideState.moveRight:
        return 'Mova um pouco para a direita';
      case _GuideState.moveUp:
        return 'Levante um pouco o rosto';
      case _GuideState.moveDown:
        return 'Abaixe um pouco o rosto';
      case _GuideState.tooFar:
        return 'Aproxime um pouco o rosto';
      case _GuideState.tooClose:
        return 'Afaste um pouco o rosto';
      case _GuideState.offAngle:
        return 'Olhe de frente para a câmera';
      case _GuideState.aligned:
        return 'Perfeito! Fique parado';
      case _GuideState.counting:
        return 'Capturando em $_countdown...';
    }
  }

  Widget _overlay() {
    final size = MediaQuery.of(context).size;
    final ovalWidth = size.width * _kOvalWidthFactor;
    final ovalHeight = size.height * _kOvalHeightFactor;
    return Stack(
      children: [
        // Dark overlay with oval cutout
        CustomPaint(
          painter: _OvalOverlayPainter(
            ovalWidth: ovalWidth,
            ovalHeight: ovalHeight,
          ),
          child: const SizedBox.expand(),
        ),
        // Colored oval border
        Center(
          child: SizedBox(
            width: ovalWidth,
            height: ovalHeight,
            child: CustomPaint(
              painter: _OvalBorderPainter(color: _stateColor),
            ),
          ),
        ),
        // Countdown number over the oval
        if (_state == _GuideState.counting)
          Center(
            child: Text(
              '$_countdown',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 120,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(color: Colors.black54, blurRadius: 12),
                ],
              ),
            ),
          ),
        // Status banner
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Container(
              width: size.width * 0.88,
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: _stateColor,
              ),
              child: Text(
                _stateMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        if (_kDebugOverlay) _debugPanel(),
      ],
    );
  }

  Widget _debugPanel() {
    String f(double? v, [int decimals = 2]) =>
        v == null ? '--' : v.toStringAsFixed(decimals);

    final wasEngaged =
        _state == _GuideState.aligned || _state == _GuideState.counting;
    final centerLimit = wasEngaged ? _kCenterOffsetExit : _kCenterOffsetEnter;
    final sizeMin = wasEngaged ? _kSizeRatioMinExit : _kSizeRatioMinEnter;
    final sizeMax = wasEngaged ? _kSizeRatioMaxExit : _kSizeRatioMaxEnter;
    final boundaryLimit = wasEngaged ? _kBoundaryExit : _kBoundaryEnter;

    return Positioned(
      left: 12,
      right: 12,
      bottom: 90,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
        ),
        child: Text(
          'DEBUG  state=${_state.name}  faces=$_dbgFaceCount\n'
          'dx=${f(_dbgDx)}  dy=${f(_dbgDy)}   limite centro=±${f(centerLimit)}\n'
          'sizeRatio=${f(_dbgSizeRatio)}   ideal=${f(sizeMin)}..${f(sizeMax)}\n'
          'boundaryT=${f(_dbgBoundaryT)}   limite=${f(boundaryLimit)}\n'
          'yaw=${f(_dbgYaw, 1)}°  roll=${f(_dbgRoll, 1)}°   limite=±${_kMaxYawDegrees.toStringAsFixed(0)}°/±${_kMaxRollDegrees.toStringAsFixed(0)}°',
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 12,
            fontFamily: 'monospace',
            height: 1.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FaceDetectionOverlay(
          key: _overlayKey,
          cameras: cameras,
          faceDetectorOptions: FaceDetectorOptions(
            enableClassification: false,
            enableContours: false,
            enableTracking: true,
            // headEulerAngleY (yaw) is only guaranteed in accurate mode; we
            // need it for the head-pose check below, and this app already
            // throttles + single-flights frames, so the extra cost is fine.
            performanceMode: FaceDetectorMode.accurate,
            minFaceSize: _kMlkitMinFaceSize,
          ),
          overlay: _overlay(),
          resultCallback: _onFrame,
        ),
        Positioned(
          bottom: 30.0,
          left: 16.0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 34),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Frame classification
  // ---------------------------------------------------------------------

  void _onFrame(FaceFrameResult result) {
    if (_capturing || !mounted) return;
    final screenSize = MediaQuery.of(context).size;
    final classified = _classify(result, screenSize);
    _applyClassification(classified);
    // The debug panel must reflect every frame's numbers, even ones that
    // don't change `_state` (which is the only thing that normally triggers
    // a rebuild) — acceptable extra cost while calibrating.
    if (_kDebugOverlay && mounted) setState(() {});
  }

  /// Maps a box from [imageSize] pixels to screen pixels, replicating the
  /// exact BoxFit.cover crop `FaceDetectionOverlay` renders the preview
  /// with — so a face box lines up with the face the user actually sees.
  Rect _mapToScreen(Rect box, Size imageSize, Size screenSize) {
    final scale = math.max(
      screenSize.width / imageSize.width,
      screenSize.height / imageSize.height,
    );
    final offsetX = (screenSize.width - imageSize.width * scale) / 2;
    final offsetY = (screenSize.height - imageSize.height * scale) / 2;
    return Rect.fromLTWH(
      box.left * scale + offsetX,
      box.top * scale + offsetY,
      box.width * scale,
      box.height * scale,
    );
  }

  /// Treats the detected face as an ellipse inscribed in its bounding box,
  /// samples points around its outline, and returns the largest normalized
  /// distance (relative to the guide oval's own radii) among them. <=1 means
  /// that point is inside the guide oval; the max across all sampled points
  /// tells us whether *any part* of the face — not just its center — has
  /// crossed the guide, which a simple center-and-width check would miss
  /// (e.g. a face big enough that its chin or forehead pokes out).
  double _maxBoundaryT(
      Rect faceBox, Offset ovalCenter, double ovalRx, double ovalRy) {
    final faceCenter = faceBox.center;
    final faceRx = faceBox.width / 2;
    final faceRy = faceBox.height / 2;
    var maxT = 0.0;
    for (var i = 0; i < _kEllipseSamples; i++) {
      final angle = 2 * math.pi * i / _kEllipseSamples;
      final point = Offset(
        faceCenter.dx + faceRx * math.cos(angle),
        faceCenter.dy + faceRy * math.sin(angle),
      );
      final nx = (point.dx - ovalCenter.dx) / ovalRx;
      final ny = (point.dy - ovalCenter.dy) / ovalRy;
      final t = math.sqrt(nx * nx + ny * ny);
      if (t > maxT) maxT = t;
    }
    return maxT;
  }

  double _iou(Rect a, Rect b) {
    final inter = a.intersect(b);
    if (inter.width <= 0 || inter.height <= 0) return 0;
    final interArea = inter.width * inter.height;
    final unionArea = a.width * a.height + b.width * b.height - interArea;
    return unionArea <= 0 ? 0 : interArea / unionArea;
  }

  /// Collapses near-duplicate detections (overlapping boxes) into one,
  /// keeping the larger box. This is only about de-noising the detector —
  /// two people in frame will never overlap this much — so it does not
  /// weaken the "one face only" rule in item 12.
  List<Face> _dedupeFaces(List<Face> faces) {
    if (faces.length <= 1) return faces;
    final kept = <Face>[];
    for (final face in faces) {
      final dupIndex = kept.indexWhere((k) =>
          _iou(k.boundingBox, face.boundingBox) > _kDuplicateIoUThreshold);
      if (dupIndex == -1) {
        kept.add(face);
      } else if (face.boundingBox.width > kept[dupIndex].boundingBox.width) {
        kept[dupIndex] = face;
      }
    }
    return kept;
  }

  double _ema(double? previous, double raw) {
    if (previous == null) return raw;
    return previous + (raw - previous) * _kEmaAlpha;
  }

  void _resetEma() {
    _emaDx = null;
    _emaDy = null;
    _emaSizeRatio = null;
    _emaBoundaryT = null;
    _emaYaw = null;
    _emaRoll = null;
  }

  _GuideState _classify(FaceFrameResult result, Size screenSize) {
    final faces = _dedupeFaces(result.faces);
    _dbgFaceCount = faces.length;

    if (faces.isEmpty) {
      _resetEma();
      _dbgDx =
          _dbgDy = _dbgSizeRatio = _dbgBoundaryT = _dbgYaw = _dbgRoll = null;
      return _GuideState.noFace;
    }
    if (faces.length > 1) {
      _resetEma();
      _dbgDx =
          _dbgDy = _dbgSizeRatio = _dbgBoundaryT = _dbgYaw = _dbgRoll = null;
      return _GuideState.multipleFaces;
    }

    final face = faces.single;
    _lastFaceFraction = Rect.fromLTWH(
      face.boundingBox.left / result.imageSize.width,
      face.boundingBox.top / result.imageSize.height,
      face.boundingBox.width / result.imageSize.width,
      face.boundingBox.height / result.imageSize.height,
    );

    final screenBox =
        _mapToScreen(face.boundingBox, result.imageSize, screenSize);

    final ovalRx = screenSize.width * _kOvalWidthFactor / 2;
    final ovalRy = screenSize.height * _kOvalHeightFactor / 2;
    final ovalCenter = Offset(screenSize.width / 2, screenSize.height / 2);

    final rawDx = (screenBox.center.dx - ovalCenter.dx) / ovalRx;
    final rawDy = (screenBox.center.dy - ovalCenter.dy) / ovalRy;
    final rawSizeRatio =
        screenBox.width / (screenSize.width * _kOvalWidthFactor);
    final rawBoundaryT = _maxBoundaryT(screenBox, ovalCenter, ovalRx, ovalRy);

    _emaDx = _ema(_emaDx, rawDx);
    _emaDy = _ema(_emaDy, rawDy);
    _emaSizeRatio = _ema(_emaSizeRatio, rawSizeRatio);
    _emaBoundaryT = _ema(_emaBoundaryT, rawBoundaryT);
    if (face.headEulerAngleY != null) {
      _emaYaw = _ema(_emaYaw, face.headEulerAngleY!);
    }
    if (face.headEulerAngleZ != null) {
      _emaRoll = _ema(_emaRoll, face.headEulerAngleZ!);
    }

    final dx = _emaDx!;
    final dy = _emaDy!;
    final sizeRatio = _emaSizeRatio!;
    final boundaryT = _emaBoundaryT!;

    _dbgDx = dx;
    _dbgDy = dy;
    _dbgSizeRatio = sizeRatio;
    _dbgBoundaryT = boundaryT;
    _dbgYaw = _emaYaw;
    _dbgRoll = _emaRoll;

    final wasEngaged =
        _state == _GuideState.aligned || _state == _GuideState.counting;

    final centerLimit = wasEngaged ? _kCenterOffsetExit : _kCenterOffsetEnter;
    final centerOk = dx.abs() <= centerLimit && dy.abs() <= centerLimit;

    final sizeMin = wasEngaged ? _kSizeRatioMinExit : _kSizeRatioMinEnter;
    final sizeMax = wasEngaged ? _kSizeRatioMaxExit : _kSizeRatioMaxEnter;
    final sizeOk = sizeRatio >= sizeMin && sizeRatio <= sizeMax;

    final boundaryOk =
        boundaryT <= (wasEngaged ? _kBoundaryExit : _kBoundaryEnter);

    final yawOk = _emaYaw == null || _emaYaw!.abs() <= _kMaxYawDegrees;
    final rollOk = _emaRoll == null || _emaRoll!.abs() <= _kMaxRollDegrees;

    // Position first: tell the user where to move before ever discussing
    // distance, per item 4.
    if (!centerOk) {
      if (dx.abs() >= dy.abs()) {
        return dx > 0 ? _GuideState.moveLeft : _GuideState.moveRight;
      }
      return dy > 0 ? _GuideState.moveUp : _GuideState.moveDown;
    }

    if (!sizeOk) {
      return sizeRatio < sizeMin ? _GuideState.tooFar : _GuideState.tooClose;
    }

    if (!boundaryOk) {
      // Centered and within the ideal size band, yet some part of the face
      // still reaches the oval's edge (e.g. an unusually tall/wide face) —
      // closest in spirit to "too close", so ask for the same correction.
      return _GuideState.tooClose;
    }

    if (!yawOk || !rollOk) {
      return _GuideState.offAngle;
    }

    return _GuideState.aligned;
  }

  // ---------------------------------------------------------------------
  // State machine: stabilization -> countdown -> capture
  // ---------------------------------------------------------------------

  void _applyClassification(_GuideState classified) {
    final isGoodNow = classified == _GuideState.aligned;

    if (isGoodNow) {
      _jitterTimer?.cancel();
      _jitterTimer = null;
      _pendingBadState = null;
      _lastAlignedAt = DateTime.now();

      if (_state == _GuideState.aligned || _state == _GuideState.counting) {
        // Already engaged: the running stabilize/countdown timer keeps
        // going untouched.
        return;
      }

      _setGuideState(_GuideState.aligned);
      _stabilizeTimer?.cancel();
      _stabilizeTimer = Timer(_kStabilizeDuration, () {
        if (!mounted || _state != _GuideState.aligned) return;
        _startCountdown();
      });
      return;
    }

    // Not aligned this frame.
    if (_state == _GuideState.aligned || _state == _GuideState.counting) {
      // Short hysteresis window so a single noisy frame doesn't nuke real
      // progress — but it is short enough that genuinely moving away still
      // cancels almost immediately (item 7 + item 10).
      _pendingBadState = classified;
      _jitterTimer ??= Timer(_kJitterTolerance, () {
        if (!mounted) return;
        final fallback = _pendingBadState ?? classified;
        _cancelCountdown();
        _setGuideState(fallback);
      });
    } else {
      _setGuideState(classified);
    }
  }

  void _setGuideState(_GuideState next) {
    if (!mounted) return;
    if (_state == next) return;
    setState(() => _state = next);
  }

  void _startCountdown() {
    setState(() {
      _state = _GuideState.counting;
      _countdown = _kCountdownStart;
    });
    _scheduleCountdownTick();
  }

  void _scheduleCountdownTick() {
    _countdownTimer = Timer(_kCountdownTick, () {
      if (!mounted || _state != _GuideState.counting) return;

      // Backstop for a stalled camera stream: if no aligned frame has been
      // seen recently, the jitter-cancel path above should already have
      // fired, but this guarantees we never coast on stale data either way.
      final stale = _lastAlignedAt == null ||
          DateTime.now().difference(_lastAlignedAt!) >
              _kCountdownTick + _kJitterTolerance;
      if (stale) {
        _cancelCountdown();
        _setGuideState(_GuideState.noFace);
        return;
      }

      final next = _countdown - 1;
      if (next <= 0) {
        _finishCountdown();
        return;
      }
      setState(() => _countdown = next);
      _scheduleCountdownTick();
    });
  }

  void _finishCountdown() {
    // Final gate immediately before the shutter (item 14): the timer
    // reaching zero is not, by itself, permission to capture.
    final freshlyAligned = mounted &&
        _state == _GuideState.counting &&
        _lastAlignedAt != null &&
        DateTime.now().difference(_lastAlignedAt!) <= _kJitterTolerance;

    if (!freshlyAligned) {
      _cancelCountdown();
      _setGuideState(_GuideState.noFace);
      return;
    }

    _cancelCountdown();
    _capture().catchError((e, st) {
      print('[upload_facial] EXCEPTION em _capture: $e\n$st');
    });
  }

  void _cancelCountdown() {
    _stabilizeTimer?.cancel();
    _stabilizeTimer = null;
    _countdownTimer?.cancel();
    _countdownTimer = null;
    _jitterTimer?.cancel();
    _jitterTimer = null;
    _pendingBadState = null;
    _countdown = _kCountdownStart;
  }

  // ---------------------------------------------------------------------
  // Capture, crop and upload
  // ---------------------------------------------------------------------

  Future<void> _capture() async {
    if (_capturing) return;
    setState(() => _capturing = true);

    final faceFraction = _lastFaceFraction;
    final image = await _overlayKey.currentState?.takePicture();
    if (image == null) {
      setState(() => _capturing = false);
      return;
    }

    await _processImage(image.path, faceFraction);
  }

  Future<void> _processImage(String imagePath, Rect? faceFraction) async {
    print('[upload_facial] _processImage iniciado: $imagePath');
    try {
      final img.Image? decodedImage =
          img.decodeImage(File(imagePath).readAsBytesSync());
      if (decodedImage == null) {
        print(
            '[upload_facial] ERRO: decodeImage retornou null para $imagePath');
        setState(() => _capturing = false);
        return;
      }
      // Android saves the still with its rotation in the EXIF orientation tag
      // (landscape pixels), and decodeImage doesn't apply it — without this
      // the crop below would be taken from a sideways image. A no-op when
      // there is no orientation tag (iOS).
      final img.Image originalImage = img.bakeOrientation(decodedImage);

      // Wider than before (was 0.57): centering on the face's eye/nose-level
      // box center leaves less room above it than below (hair extends
      // further past the box top than the chin does past the box bottom),
      // so a too-tight square can clip the top of the head even when
      // correctly centered. A bigger square keeps the same center but
      // leaves more margin on every side.
      final double desiredSizePercentage = 0.68;
      // Derived from the SMALLER dimension, never the width alone: a still
      // photo's aspect ratio isn't guaranteed to be tall-portrait like the
      // live preview, so basing it on width could make the square bigger
      // than the actual height, driving the offsetY clamp below negative
      // and throwing (which silently aborted the whole capture — the bug
      // behind "não salvou o rosto no dispositivo").
      final int squareSize =
          (math.min(originalImage.width, originalImage.height) *
                  desiredSizePercentage)
              .toInt();

      // `takePicture()` returns the full, uncropped sensor frame, which is
      // usually taller than what the on-screen preview shows (that crops to
      // fill the portrait screen) — so centering blindly on the raw photo's
      // geometry doesn't line up with where the face actually is, and can
      // clip the top of the head. Center on the last detected face instead,
      // falling back to the image's own center if none was captured.
      final int centerX = faceFraction != null
          ? (faceFraction.center.dx * originalImage.width).round()
          : originalImage.width ~/ 2;
      final int centerY = faceFraction != null
          ? (faceFraction.center.dy * originalImage.height).round()
          : originalImage.height ~/ 2;

      final int offsetX = (centerX - squareSize ~/ 2)
          .clamp(0, originalImage.width - squareSize);
      final int offsetY = (centerY - squareSize ~/ 2)
          .clamp(0, originalImage.height - squareSize);

      final img.Image croppedImage = img.copyCrop(
        originalImage,
        x: offsetX,
        y: offsetY,
        width: squareSize,
        height: squareSize,
      );

      final File croppedFile =
          File(imagePath.replaceAll('.jpg', '_cropped.jpg'));
      croppedFile.writeAsBytesSync(img.encodeJpg(croppedImage));
      _selectedFile = croppedFile;

      await uploadImage();
      Get.toNamed('/facial');
    } catch (e, st) {
      print('[upload_facial] EXCEPTION em _processImage: $e\n$st');
      if (mounted) {
        setState(() => _capturing = false);
        showToastError(
            context, 'Não foi possível processar a foto. Tente novamente.');
      }
    }
  }

  Future uploadImage() async {
    print(
        '[upload_facial] uploadImage iniciado, arquivo: ${_selectedFile?.path}');
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      print(
          '[upload_facial] enviando para $uri com idusu=${loginController.id.value}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['idusu'] = loginController.id.value;
      var pic = await http.MultipartFile.fromPath("image", _selectedFile!.path);
      request.files.add(pic);
      var streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print(
          '[upload_facial] status=${streamedResponse.statusCode} body=$responseBody');

      if (streamedResponse.statusCode == 200) {
        loginController.newLogin(loginController.id.value);
        Navigator.of(context).pop();
        showToast(context, 'Parabéns!', 'Imagem Facial Enviada com Sucesso!');
      } else if (streamedResponse.statusCode == 404) {
        loginController.imgfacial.value = '';
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        showToastError(
            context, 'Erro ${streamedResponse.statusCode}: $responseBody');
      }
    } catch (e, st) {
      print('[upload_facial] EXCEPTION em uploadImage: $e\n$st');
    } finally {
      _selectedFile = null;
    }
  }

  @override
  void dispose() {
    _cancelCountdown();
    super.dispose();
  }
}

class _OvalOverlayPainter extends CustomPainter {
  final double ovalWidth;
  final double ovalHeight;

  _OvalOverlayPainter({required this.ovalWidth, required this.ovalHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.55);

    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: ovalWidth,
      height: ovalHeight,
    );

    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final ovalPath = Path()..addOval(ovalRect);
    final combined = Path.combine(PathOperation.difference, fullPath, ovalPath);

    canvas.drawPath(combined, paint);
  }

  @override
  bool shouldRepaint(_OvalOverlayPainter old) =>
      ovalWidth != old.ovalWidth || ovalHeight != old.ovalHeight;
}

class _OvalBorderPainter extends CustomPainter {
  final Color color;

  _OvalBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5;

    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_OvalBorderPainter old) => color != old.color;
}
