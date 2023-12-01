import 'package:flutter_svg/flutter_svg.dart';


class SvgUtils {
  const SvgUtils._();

  static Future precacheSvgPicture(String svgPath) async {
    final logo = SvgAssetLoader(svgPath);
    await svg.cache
        .putIfAbsent(logo.cacheKey(null), () => logo.loadBytes(null));
  }

  static Future precacheSvgPictures(List<String> svgPaths) async {
    await Future.wait(svgPaths.map((svgPath) => precacheSvgPicture(svgPath)));
  }

  // TODO: add svg caching to main.dart
}
