import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 22),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
