import 'package:cloud_firestore/cloud_firestore.dart';

String formattedDate(Timestamp time) =>
    time.toDate().toString().split(' ')[0].split('-').reversed.join('-');

String formattedDateTime(Timestamp time) =>
    '${time.toDate().toString().split(' ')[0].split('-').reversed.join('-')} ${time.toDate().toString().split(' ')[1].split('.')[0].substring(0, 5)}';
