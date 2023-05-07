import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_trash/models/information.dart';

class Common with ChangeNotifier {
  // RUNNING TIME PROVIDER
  String? _currentTime;
  String? get currentTime => _currentTime;

  void onStart() {
    _currentTime = formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => setTime());
  }

  void setTime() {
    final DateTime now = DateTime.now();
    final String formattedNow = formatDateTime(now);
    _currentTime = formattedNow;
    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yyyy hh:mm:ss').format(dateTime);

  // EXTERNAL INFORMATION PROVIDER
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;

  void startLoading() {
    _loading = true;
    notifyListeners();
  }

  void stopLoading() {
    _loading = false;
    notifyListeners();
  }

  Future<List<InformationModel>> getArticles(BuildContext context) async {
    startLoading();
    try {
      final res = await db.collection('articles').get();
      stopLoading();
      return res.docs.map((e) => InformationModel.fromJson(e.data())).toList();
    } on FirebaseException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.white,
              ),
              Text(' ${err.message.toString()}'),
            ],
          ),
        ),
      );
      stopLoading();
      return [];
    }
  }
}
