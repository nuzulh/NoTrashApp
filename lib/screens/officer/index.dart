import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/navigation.dart';
import 'package:provider/provider.dart';

class OfficerIndex extends StatelessWidget {
  const OfficerIndex({super.key});
  static const routeName = 'officer';

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<Navigation>(context);

    return Scaffold(
      backgroundColor: kBgColor,
      body: navigation.officerMenus.elementAt(navigation.selectedOfficerMenu),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: navigation.selectedOfficerMenu,
        selectedItemColor: kPrimaryColor,
        onTap: navigation.selectOfficerMenu,
      ),
    );
  }
}
