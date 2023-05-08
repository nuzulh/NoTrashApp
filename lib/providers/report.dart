import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:no_trash/models/report.dart';
import 'package:no_trash/screens/officer/index.dart';
import 'package:no_trash/screens/reporter/index.dart';
import 'package:no_trash/widgets/prompt_dialog.dart';
import 'package:no_trash/widgets/success_dialog.dart';
import 'package:uuid/uuid.dart';

class Report with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  List<ReportModel> _reports = [];
  TextEditingController address = TextEditingController();
  TextEditingController notes = TextEditingController();
  String _map = '';
  bool _loading = false;
  String _error = '';
  String _tempFilePath = '';

  List<ReportModel> get reports => _reports;
  List<ReportModel> get confirmedReports =>
      _reports.where((x) => x.confirmed).toList();
  List<ReportModel> get unconfirmedReports =>
      _reports.where((x) => !x.confirmed).toList();
  int get poins =>
      _reports
          .where((x) =>
              x.confirmed && x.confirmedBy?.id == firebaseAuth.currentUser!.uid)
          .toList()
          .length *
      3;
  List<ReportModel> get myReports => _reports
      .where((x) => x.reporter.id == firebaseAuth.currentUser!.uid)
      .toList();
  List<ReportModel> get myConfirmedReports => _reports
      .where(
          (x) => x.confirmed && x.reporter.id == firebaseAuth.currentUser!.uid)
      .toList();
  List<ReportModel> get myHistoryReports => _reports
      .where((x) =>
          x.confirmed && x.confirmedBy?.id == firebaseAuth.currentUser!.uid)
      .toList()
    ..sort((a, b) =>
        b.confirmedDate!.toDate().compareTo(a.confirmedDate!.toDate()));

  String get map => _map;
  bool get loading => _loading;
  String get error => _error;
  String get tempFilePath => _tempFilePath;

  void onStart() async {
    _reports = [...await getReports()];
    notifyListeners();
    resetError();
  }

  void startLoading() {
    _loading = true;
    notifyListeners();
  }

  void stopLoading() {
    _loading = false;
    notifyListeners();
  }

  void setError(String err) {
    _error = err;
    notifyListeners();
  }

  void resetError() {
    _error = '';
    notifyListeners();
  }

  void setMap(String map) {
    _map = map;
    notifyListeners();
  }

  void setFile(String filePath) {
    _tempFilePath = filePath;
    notifyListeners();
  }

  void resetForm() {
    address.text = '';
    notes.text = '';
    _tempFilePath = '';
    _map = '';
    notifyListeners();
  }

  bool checkReportForm() {
    if (address.text.isEmpty || notes.text.isEmpty) {
      setError('Isian belum lengkap');
      stopLoading();
      return false;
    }
    if (_tempFilePath.isEmpty) {
      setError('Silahkan unggah foto terlebih dahulu');
      stopLoading();
      return false;
    }
    return true;
  }

  Future<List<ReportModel>> getReports() async {
    startLoading();
    try {
      final res = await db
          .collection('reports')
          .orderBy('reported_date', descending: true)
          .get();
      stopLoading();
      return res.docs.map((e) => ReportModel.fromJson(e.data())).toList();
    } on FirebaseException catch (err) {
      setError(err.message.toString());
      stopLoading();
      return [];
    }
  }

  Future<void> confirmReport(BuildContext context, String reportId) async {
    showDialog(
      context: context,
      builder: (context) => PromptDialog(
        text: 'Apakah Anda yakin mengkonfirmasi laporan ini?',
        approveLabel: 'Yakin',
        rejectLabel: 'Tidak',
        onApprove: () async {
          try {
            startLoading();
            final DocumentReference<Map<String, dynamic>> confirmedBy =
                db.collection('users').doc(firebaseAuth.currentUser!.uid);
            await db.collection('reports').doc(reportId).update({
              'confirmed': true,
              'confirmed_by': confirmedBy,
              'confirmed_date': Timestamp.now(),
            }).then((value) {
              stopLoading();
              showDialog(
                context: context,
                builder: (context) => SuccessDialog(
                  text:
                      'Laporan berhasil dikonfirmasi! Anda mendapatkan +3 poin.',
                  buttonLabel: 'Kembali ke Home',
                  onAction: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    OfficerIndex.routeName,
                    (route) => false,
                  ),
                ),
              );
            });
          } on FirebaseException catch (err) {
            setError(err.message.toString());
            stopLoading();
          }
        },
        onReject: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> addReport(BuildContext context) async {
    startLoading();
    try {
      if (checkReportForm()) {
        final uuid = const Uuid().v4();
        final String fileName = _tempFilePath.split('/').last;
        await uploadFile(uuid, _tempFilePath, fileName);
        await db
            .collection('reports')
            .doc(uuid)
            .set(ReportModel(
              id: uuid,
              reporter:
                  db.collection('users').doc(firebaseAuth.currentUser!.uid),
              notes: notes.text,
              address: address.text,
              map: _map,
              image: fileName,
              reportedDate: Timestamp.now(),
            ).toJson())
            .then((_) {
          showDialog(
            context: context,
            builder: (context) => SuccessDialog(
              text:
                  'Laporan berhasil dibuat. Silahkan tunggu konfirmasi oleh Petugas.',
              buttonLabel: 'Kembali ke Home',
              onAction: () => Navigator.pushNamedAndRemoveUntil(
                context,
                ReporterIndex.routeName,
                (route) => false,
              ),
            ),
          );
          stopLoading();
          resetForm();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.warning_rounded, color: Colors.white),
                Text(' $_error'),
              ],
            ),
          ),
        );
      }
    } on FirebaseException catch (err) {
      stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning_rounded, color: Colors.white),
              Text(' ${err.message}'),
            ],
          ),
        ),
      );
    }
  }

  Future<void> uploadTempFile(BuildContext context) async {
    await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    ).then((file) {
      if (file == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.warning_rounded, color: Colors.white),
                Text(' Tidak ada foto yang diunggah'),
              ],
            ),
          ),
        );
      } else {
        setFile(file.files.single.path!);
        notifyListeners();
      }
    });
  }

  Future<void> uploadFile(
    String reportId,
    String filePath,
    String fileName,
  ) async {
    startLoading();
    File file = File(filePath);
    try {
      await storage.ref('report/$reportId/$fileName').putFile(file);
      stopLoading();
    } on FirebaseException catch (err) {
      setError(err.message.toString());
      stopLoading();
    }
  }

  Future<String> downloadURL(String reportId) async {
    startLoading();
    ListResult files = await storage.ref('report/$reportId').listAll();
    if (files.items.isNotEmpty) {
      String res = await storage
          .ref('report/$reportId/${files.items[0].name}')
          .getDownloadURL();
      stopLoading();
      return res;
    }
    stopLoading();
    return '';
  }
}
