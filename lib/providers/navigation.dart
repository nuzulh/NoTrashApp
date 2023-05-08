import 'package:flutter/material.dart';
import 'package:no_trash/screens/officer/history.dart';
import 'package:no_trash/screens/officer/home.dart';
import 'package:no_trash/screens/reporter/home.dart';
import 'package:no_trash/screens/reporter/information.dart';
import 'package:no_trash/screens/account.dart';

class Navigation with ChangeNotifier {
  // -------------------- REPORTER NAVIGATIONS --------------------
  final List<Widget> _reporterMenus = [
    const ReporterHome(),
    const Information(),
    const Settings(),
  ];
  int _selectedReporterMenu = 0;

  List<Widget> get reporterMenus => _reporterMenus;
  int get selectedReporterMenu => _selectedReporterMenu;

  void selectReporterMenu(int index) {
    _selectedReporterMenu = index;
    notifyListeners();
  }

  // -------------------- OFFICER NAVIGATIONS --------------------
  final List<Widget> _officerMenus = [
    const OfficerHome(),
    const History(),
    const Settings(),
  ];
  int _selectedOfficerMenu = 0;

  List<Widget> get officerMenus => _officerMenus;
  int get selectedOfficerMenu => _selectedOfficerMenu;

  void selectOfficerMenu(int index) {
    _selectedOfficerMenu = index;
    notifyListeners();
  }
}
