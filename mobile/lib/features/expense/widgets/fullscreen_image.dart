import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FullscreenImage extends StatelessWidget {
  const FullscreenImage({
    Key? key,
    required this.child,
    required this.tag,
  }) : super(key: key);
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Hero(
          tag: tag,
          child: child,
        ),
      ),
    ));
  }
}
