import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import 'shimmer.dart';

/// Network image with caching, placeholder, and error widget.
/// Also renders local file paths (e.g. freshly picked photos).
class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.semanticLabel,
    super.key,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    Widget image;
    if (url == null || url.isEmpty) {
      image = _Fallback(width: width, height: height);
    } else if (url.startsWith('http')) {
      image = CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, _) => _Placeholder(width: width, height: height),
        errorWidget: (_, _, _) => _Fallback(width: width, height: height),
      );
    } else {
      image = Image.file(
        File(url),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _Fallback(width: width, height: height),
      );
    }

    return Semantics(
      image: true,
      label: semanticLabel,
      child: ClipRRect(
        borderRadius: borderRadius ?? AppRadius.mdAll,
        child: image,
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // A shimmering grey block while the image loads — matches the app's
    // skeleton language instead of a spinner-on-tint.
    return Shimmer(
      child: SkeletonBox(
        width: width,
        height: height,
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.primarySoft,
      child: const Icon(
        FluentIcons.animal_paw_print_24_regular,
        color: AppColors.primary,
      ),
    );
  }
}
