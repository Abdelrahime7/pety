import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

/// Shared network image for the whole app.
///
/// - Decodes at roughly the displayed size (small memory, stays in cache).
/// - No fade animations, so re-resolving never looks like a reload.
/// - Always shows a placeholder while loading and on error (never blank).
class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Use a value that stays the same for the photo (e.g. pet.id) if the URL
  /// contains a token that changes between loads.
  final String? cacheKey;

  /// Optional custom widget for loading/error. Defaults to a paw icon box.
  final WidgetBuilder? placeholderBuilder;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheKey,
    this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _placeholder(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final dpr = MediaQuery.devicePixelRatioOf(context);
        final logicalWidth =
            width ?? (constraints.maxWidth.isFinite ? constraints.maxWidth : null);

        return CachedNetworkImage(
          imageUrl: url,
          cacheKey: cacheKey,
          width: width,
          height: height,
          fit: fit,
          memCacheWidth: logicalWidth == null ? null : (logicalWidth * dpr).round(),
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
          placeholderFadeInDuration: Duration.zero,
          placeholder: (_, _) => _placeholder(context),
          errorWidget: (_, _, _) => _placeholder(context),
        );
      },
    );
  }

  Widget _placeholder(BuildContext context) {
    if (placeholderBuilder != null) return placeholderBuilder!(context);

    return Container(
      width: width,
      height: height,
      color: context.colors.surfaceContainer,
      child: Center(
        child: Icon(
          Icons.pets_rounded,
          size: 28,
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}