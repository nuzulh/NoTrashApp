import 'package:flutter/material.dart';
import 'package:no_trash/widgets/layout.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          Text('HISTORY'),
        ],
      ),
    );
  }
}
