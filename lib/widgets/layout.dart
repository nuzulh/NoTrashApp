import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final Widget? header;

  const Layout({
    super.key,
    required this.child,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  top: header != null ? 80 : 0,
                  left: 18,
                  right: 18,
                ),
                child: child,
              ),
            ),
            Positioned(
              top: 0,
              child: header ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
