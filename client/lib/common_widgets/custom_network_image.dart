import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/common_widgets/custom_ink_well.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.url, {
    super.key,
    this.borderRadius,
    this.width,
    this.height,
    this.isZoomable = false,
    this.backgroundColor,
    this.noImagePlaceholder,
    this.loading,
    this.fit,
  });

  final String? url;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final bool isZoomable;
  final Color? backgroundColor;
  final Widget? noImagePlaceholder;
  final Widget? loading;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    String? fixUrl(String? url) {
      if (url == null || url.isEmpty || !url.contains('.')) return null;
      // if url is not in a good format, return null

      if (url.startsWith('https://')) return url;
      if (url.startsWith('http://')) {
        return url.replaceFirst('http://', 'https://');
      }
      return 'https://$url';
    }

    final url = fixUrl(this.url);

    print(url);

    final imageIcon = Icon(
      Icons.image_outlined,
      color: context.colors.primary.withOpacity(0.5),
      size: 20.rm,
    );

    Widget image() {
      if (url == null) return noImagePlaceholder ?? imageIcon;
      return CachedNetworkImage(
        cacheKey: url,
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        fit: fit ?? BoxFit.cover,
        imageUrl: url,
        progressIndicatorBuilder:
            loading == null ? loadingBuilder : (_, __, ___) => loading!,
        errorWidget: (_, __, ___) => noImagePlaceholder ?? imageIcon,
      );
    }

    void showZoomImage() {
      context.customWidgetDialog(
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PinchZoom(
                child: image(),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: context.pop,
                  icon: Icon(
                    Icons.close_rounded,
                    color: context.colors.white,
                    size: 30.rm,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CustomInkWell(
      borderRadius: borderRadius,
      onTap: isZoomable ? showZoomImage : null,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colors.primary.withOpacity(0.1),
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: image(),
        ),
      ),
    );
  }

  Widget loadingBuilder(
      BuildContext context, String url, DownloadProgress downloadProgress) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          backgroundColor: context.colors.primary.withOpacity(0.2),
          color: context.colors.primary.withOpacity(0.5),
          value: downloadProgress.progress,
        ),
      ),
    );
  }
}
