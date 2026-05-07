import 'package:condosocio/src/controllers/tutoriais_controller.dart';
import 'package:condosocio/src/pages/alvo_tv_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget listaVideosTutoriais(BuildContext context) {
  final TutoriaisController tutoriais = Get.put(TutoriaisController());

  return Container(
    padding: const EdgeInsets.all(8),
    child: SmartRefresher(
      controller: tutoriais.refreshController,
      onRefresh: tutoriais.onRefresh,
      onLoading: tutoriais.onLoading,
      child: Obx(() {
        final videos = tutoriais.videos;

        if (tutoriais.isLoading.value && videos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (videos.isEmpty) {
          return Center(
            child: Text(
              'Nenhum tutorial disponível.',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
          );
        }

        final featuredVideo = videos.first;
        final remainingVideos = videos.skip(1).toList();

        return ListView(
          children: [
            _TutorialFeaturedCard(
              video: featuredVideo,
              onTap: (videoId) {
                Get.to(
                  () => AlvoTvPlayerPage(
                    videoId: videoId,
                    title: featuredVideo.titulo,
                    description: _sanitizeDescription(featuredVideo.descricao),
                    isPortraitVideo: true,
                    showHelpCta: true,
                  ),
                );
              },
            ),
            if (remainingVideos.isNotEmpty) ...[
              const SizedBox(height: 18),
              GridView.builder(
                itemCount: remainingVideos.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  return _TutorialVideoCard(
                    video: remainingVideos[index],
                    onTap: (videoId) {
                      Get.to(
                        () => AlvoTvPlayerPage(
                          videoId: videoId,
                          title: remainingVideos[index].titulo,
                          description: _sanitizeDescription(
                            remainingVideos[index].descricao,
                          ),
                          isPortraitVideo: true,
                          showHelpCta: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ],
        );
      }),
    ),
  );
}

class _TutorialFeaturedCard extends StatelessWidget {
  final dynamic video;
  final ValueChanged<String> onTap;

  const _TutorialFeaturedCard({
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final videoId = _extractYoutubeId(video.html);
    final theme = Theme.of(context);
    final description = _sanitizeDescription(video.descricao);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onTap(videoId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      'https://i.ytimg.com/vi/$videoId/hqdefault.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black.withOpacity(0.18),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.ondemand_video_outlined,
                            size: 52,
                            color: Colors.white70,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 76,
                      color: Color(0xFFFF3D3D),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (video.publi != "<h1></h1>") ...[
                    _PubliBadge(publi: video.publi),
                    const SizedBox(height: 10),
                  ],
                  Text(
                    video.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: theme.textSelectionTheme.selectionColor!,
                    ),
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        height: 1.35,
                        color: theme.textSelectionTheme.selectionColor!
                            .withOpacity(0.82),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialVideoCard extends StatelessWidget {
  final dynamic video;
  final ValueChanged<String> onTap;

  const _TutorialVideoCard({
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final videoId = _extractYoutubeId(video.html);
    final theme = Theme.of(context);
    final description = _sanitizeDescription(video.descricao);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withOpacity(0.18),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => onTap(videoId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      'https://i.ytimg.com/vi/$videoId/hqdefault.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black.withOpacity(0.18),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.ondemand_video_outlined,
                            size: 34,
                            color: Colors.white70,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 42,
                      color: Color(0xFFFF3D3D),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (video.publi != "<h1></h1>") ...[
                      _PubliBadge(publi: video.publi, compact: true),
                      const SizedBox(height: 8),
                    ],
                    Text(
                      video.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: theme.textSelectionTheme.selectionColor!,
                      ),
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          height: 1.3,
                          color: theme.textSelectionTheme.selectionColor!
                              .withOpacity(0.78),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PubliBadge extends StatelessWidget {
  final String publi;
  final bool compact;

  const _PubliBadge({
    required this.publi,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 2 : 3,
      ),
      child: Html(
        data: publi,
        style: {
          "h1": Style(
            fontFamily: 'Montserrat',
            fontSize: FontSize(compact ? 8 : 9),
            letterSpacing: compact ? 3 : 5,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
          "body": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
        },
      ),
    );
  }
}

String _sanitizeDescription(String description) {
  final cutDescription = description.split('<a');
  return cutDescription.first.trim();
}

String _extractYoutubeId(String html) {
  final uri = Uri.tryParse(html.trim());

  if (uri != null) {
    if (uri.host.contains('youtu.be')) {
      final segments = uri.pathSegments.where((segment) => segment.isNotEmpty);
      if (segments.isNotEmpty) {
        return segments.first;
      }
    }

    final queryId = uri.queryParameters['v'];
    if (queryId != null && queryId.isNotEmpty) {
      return queryId;
    }

    final segments = uri.pathSegments.where((segment) => segment.isNotEmpty);
    final segmentList = segments.toList();
    final embedIndex = segmentList.indexOf('embed');
    if (embedIndex != -1 && embedIndex + 1 < segmentList.length) {
      return segmentList[embedIndex + 1];
    }

    if (segmentList.isNotEmpty) {
      return segmentList.last.split('?').first;
    }
  }

  final regex = RegExp(r'([A-Za-z0-9_-]{11})');
  final match = regex.firstMatch(html);
  if (match != null) {
    return match.group(1)!;
  }

  return html;
}
