import 'package:flutter/material.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Layout(
      child: Column(
        children: [
          PrimaryButton(
            label: 'Keluar',
            onPressed: () {
              auth.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
