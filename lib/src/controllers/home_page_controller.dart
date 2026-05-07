import 'dart:convert';
import 'dart:io';

import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController {
  static const String _bannerCacheFolder = 'home_banners_cache';
  static const String _bannerMetadataFile = 'banners.json';
  static const List<String> _bannerEndpoints = [
    '/flutter/banners_home_buscar_novo.php',
  ];

  late Future<void> launched;
  LoginController loginController = Get.put(LoginController());

  Future<void> launchInBrowser(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInAppBrowser(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<List<Map<String, String>>> getBannersHome() async {
    final cachedBanners = await _loadCachedBanners();
    final cachedByUrl = <String, Map<String, String>>{
      for (final banner in cachedBanners)
        if ((banner['imgUrl'] ?? '').isNotEmpty) banner['imgUrl']!: banner,
    };

    try {
      LoginController loginController = Get.put(LoginController());
      final data = await _fetchBannerPayload(
        loginController.idcond.value,
      );

      final bannersHome = await Future.wait(data.map((obj) async {
        final imgUrl =
            "http://www.condosocio.com.br/acond/downloads/bannerTelaInicial/${obj['imgbanner'] as String}";
        final url = (obj['url'] ?? '').toString();
        final tipoLink = (obj['tipolink'] ?? '').toString();
        final cachedBanner = cachedByUrl[imgUrl];
        final localPath =
            await _cacheBannerImage(imgUrl) ?? cachedBanner?['localPath'];

        final banner = <String, String>{
          'imgUrl': imgUrl,
          'url': url,
          'tipolink': tipoLink,
        };

        if (localPath != null && localPath.isNotEmpty) {
          banner['localPath'] = localPath;
        }

        debugPrint('Banner da API mapeado: $banner');
        return banner;
      }));

      await _removeStaleCachedBannerFiles(bannersHome);
      await _saveCachedBanners(bannersHome);
      await _logBannerCacheStats(bannersHome);

      return bannersHome;
    } catch (e) {
      debugPrint('Falha ao buscar banners na API: $e');
      if (cachedBanners.isNotEmpty) {
        debugPrint(
          'Usando metadata em cache para banners: ${cachedBanners.length} item(ns)',
        );
        await _logBannerCacheStats(cachedBanners);
        return cachedBanners;
      }

      throw Exception('Falha no carregamento do banner: $e');
    }
  }

  static Future<List<dynamic>> _fetchBannerPayload(String idcond) async {
    Object? lastError;

    for (final endpoint in _bannerEndpoints) {
      try {
        debugPrint('Buscando banners em $endpoint');
        final response = await http.post(
          Uri.https('www.condosocio.com.br', endpoint),
          body: {
            'idcond': idcond,
          },
        );

        if (response.statusCode != 200) {
          throw Exception('HTTP ${response.statusCode}');
        }

        final data = jsonDecode(response.body) as List<dynamic>;
        debugPrint(
          'Endpoint $endpoint retornou ${data.length} banner(s)',
        );
        return data;
      } catch (e) {
        lastError = e;
        debugPrint('Falha ao buscar banners em $endpoint: $e');
      }
    }

    throw Exception(lastError ?? 'Nenhum endpoint de banner respondeu');
  }

  static Future<Directory> _getBannerCacheDirectory() async {
    final baseDirectory = await getApplicationSupportDirectory();
    final directory = Directory(
      '${baseDirectory.path}/$_bannerCacheFolder',
    );

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }

  static Future<File> _getBannerMetadataCacheFile() async {
    final directory = await _getBannerCacheDirectory();
    return File('${directory.path}/$_bannerMetadataFile');
  }

  static Future<void> _saveCachedBanners(
    List<Map<String, String>> banners,
  ) async {
    final file = await _getBannerMetadataCacheFile();
    await file.writeAsString(
      jsonEncode(banners),
      flush: true,
    );
  }

  static Future<List<Map<String, String>>> _loadCachedBanners() async {
    try {
      final file = await _getBannerMetadataCacheFile();
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      if (contents.trim().isEmpty) {
        return [];
      }

      final decoded = jsonDecode(contents) as List<dynamic>;
      return decoded.map((item) {
        final map = Map<String, dynamic>.from(item as Map);
        final normalized = map.map(
          (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
        );
        normalized.putIfAbsent('imgUrl', () => '');
        normalized.putIfAbsent('url', () => '');
        normalized.putIfAbsent('tipolink', () => '');
        normalized.putIfAbsent('localPath', () => '');
        return normalized;
      }).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<String?> _cacheBannerImage(String imgUrl) async {
    try {
      final directory = await _getBannerCacheDirectory();
      final file = File(
        '${directory.path}/${_bannerFileNameFromUrl(imgUrl)}',
      );

      final response = await http.get(Uri.parse(imgUrl));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        await file.writeAsBytes(response.bodyBytes, flush: true);
        return file.path;
      }

      if (await file.exists() && await file.length() > 0) {
        return file.path;
      }
    } catch (_) {
      final directory = await _getBannerCacheDirectory();
      final file = File(
        '${directory.path}/${_bannerFileNameFromUrl(imgUrl)}',
      );
      if (await file.exists() && await file.length() > 0) {
        return file.path;
      }
    }

    return null;
  }

  static Future<void> _removeStaleCachedBannerFiles(
    List<Map<String, String>> activeBanners,
  ) async {
    try {
      final directory = await _getBannerCacheDirectory();
      final activePaths = activeBanners
          .map((banner) => banner['localPath'])
          .whereType<String>()
          .where((path) => path.isNotEmpty)
          .toSet();

      await for (final entity in directory.list()) {
        if (entity is! File) {
          continue;
        }

        final fileName = entity.uri.pathSegments.isNotEmpty
            ? entity.uri.pathSegments.last
            : '';
        if (fileName == _bannerMetadataFile) {
          continue;
        }

        if (!activePaths.contains(entity.path)) {
          await entity.delete();
        }
      }
    } catch (_) {
      // Se a limpeza falhar, o app continua funcionando com o cache atual.
    }
  }

  static Future<void> _logBannerCacheStats(
    List<Map<String, String>> banners,
  ) async {
    try {
      int totalBytes = 0;

      for (final banner in banners) {
        final localPath = banner['localPath'];
        final imageUrl = banner['imgUrl'] ?? '(sem url)';

        if (localPath == null || localPath.isEmpty) {
          debugPrint('Banner $imageUrl sem arquivo local em cache');
          continue;
        }

        final file = File(localPath);
        if (!await file.exists()) {
          debugPrint('Banner $imageUrl com cache ausente em disco');
          continue;
        }

        final fileBytes = await file.length();
        totalBytes += fileBytes;
        final fileName = file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : localPath;

        debugPrint(
          'Cache banner $fileName: ${_formatBytes(fileBytes)}',
        );
      }

      debugPrint(
        'Cache total de banners: ${_formatBytes(totalBytes)}',
      );
    } catch (e) {
      debugPrint('Falha ao calcular tamanho do cache dos banners: $e');
    }
  }

  static String _formatBytes(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB'];
    double size = bytes.toDouble();
    int unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    final decimals = unitIndex == 0 ? 0 : 1;
    return '${size.toStringAsFixed(decimals)} ${units[unitIndex]}';
  }

  static String _bannerFileNameFromUrl(String imgUrl) {
    final uri = Uri.tryParse(imgUrl);
    final rawFileName = uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : imgUrl.split('/').last;

    return rawFileName.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
  }
}
