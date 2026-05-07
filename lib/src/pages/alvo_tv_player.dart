import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AlvoTvPlayerPage extends StatefulWidget {
  final String videoId;
  final String title;
  final String description;
  final bool isPortraitVideo;
  final bool showHelpCta;

  const AlvoTvPlayerPage({
    super.key,
    required this.videoId,
    required this.title,
    required this.description,
    this.isPortraitVideo = false,
    this.showHelpCta = false,
  });

  @override
  State<AlvoTvPlayerPage> createState() => _AlvoTvPlayerPageState();
}

class _AlvoTvPlayerPageState extends State<AlvoTvPlayerPage> {
  static final Uri _subscribeUrl = Uri.parse(
    'https://www.youtube.com/channel/UCLPOsAW7jbawmz7nB3UeDvg?sub_confirmation=1',
  );
  static final Uri _helpCenterUrl = Uri.parse(
    'https://api.whatsapp.com/send?phone=5591981220670',
  );
  late final YoutubePlayerController _controller;
  final _shareKey = GlobalKey();

  void _shareVideo() {
    final box = _shareKey.currentContext?.findRenderObject() as RenderBox?;
    final origin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : const Rect.fromLTWH(0, 0, 1, 1);

    final url = 'https://www.youtube.com/watch?v=${widget.videoId}';
    SharePlus.instance.share(
      ShareParams(
        text: '${widget.title}\n$url',
        subject: widget.title,
        sharePositionOrigin: origin,
      ),
    );
  }

  Future<void> _openSubscribeLink() async {
    await launchUrl(_subscribeUrl, mode: LaunchMode.externalApplication);
  }

  Future<void> _openHelpCenterLink() async {
    await launchUrl(_helpCenterUrl, mode: LaunchMode.externalApplication);
  }

  Widget _buildSubscribeBanner(ThemeData theme) {
    return InkWell(
      onTap: _openSubscribeLink,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFC1121F), Color(0xFFE5383B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFFC1121F),
                size: 34,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONDOPLAY NO YOUTUBE',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: Colors.white.withOpacity(0.86),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Inscreva-se em nosso canal',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Acompanhe os próximos vídeos e conteúdos.',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.82),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.open_in_new_rounded,
              color: Colors.white.withOpacity(0.92),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCenterBanner(ThemeData theme) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _openHelpCenterLink,
        icon: const Icon(Icons.open_in_new_rounded, size: 18),
        label: Text(
          'Falar com a Central de Ajuda',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerAspectRatio = widget.isPortraitVideo ? 9 / 16 : 16 / 9;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: playerAspectRatio,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Theme.of(context).primaryColor,
        progressColors: ProgressBarColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColor,
        ),
        topActions: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      builder: (context, player) {
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                key: _shareKey,
                onPressed: _shareVideo,
                icon: const Icon(Icons.ios_share_rounded),
                tooltip: 'Compartilhar',
              ),
            ],
            title: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: widget.isPortraitVideo ? 420 : double.infinity,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.14),
                          blurRadius: 16,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: player,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.textSelectionTheme.selectionColor!,
                        height: 1.2,
                      ),
                    ),
                    if (widget.description.trim().isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        widget.description.trim(),
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.45,
                          color: theme.textSelectionTheme.selectionColor!
                              .withOpacity(0.82),
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    widget.showHelpCta
                        ? _buildHelpCenterBanner(theme)
                        : _buildSubscribeBanner(theme),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
