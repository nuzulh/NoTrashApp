import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/navigation.dart';
import 'package:provider/provider.dart';

class ReporterIndex extends StatelessWidget {
  const ReporterIndex({super.key});
  static const routeName = 'reporter';

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<Navigation>(context);

    return Scaffold(
      backgroundColor: kBgColor,
      body: navigation.reporterMenus.elementAt(navigation.selectedReporterMenu),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Information',
            icon: Icon(Icons.widgets_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: navigation.selectedReporterMenu,
        selectedItemColor: kPrimaryColor,
        onTap: navigation.selectReporterMenu,
      ),
    );
  }
}
