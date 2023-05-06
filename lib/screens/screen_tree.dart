import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/models/user.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/auth/register.dart';
import 'package:no_trash/screens/officer/index.dart';
import 'package:no_trash/screens/reporter/index.dart';
import 'package:no_trash/widgets/loading.dart';

class ScreenTree extends StatelessWidget {
  const ScreenTree({super.key});
  static const routeName = 'screen-tree';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: Auth().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.role.isEmpty) {
            return const Register();
          } else {
            return snapshot.data!.role == 'Petugas'
                ? const OfficerIndex()
                : const ReporterIndex();
          }
        } else {
          return const Scaffold(
            backgroundColor: kBgColor,
            body: Center(child: Loading()),
          );
        }
      },
    );
  }
}
