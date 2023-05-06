import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final DocumentReference<Map<String, dynamic>> reporter;
  final String notes;
  final String address;
  final String map;
  final String image;
  final bool confirmed;
  final Timestamp reportedDate;
  final DocumentReference<Map<String, dynamic>>? confirmedBy;
  final Timestamp? confirmedDate;

  ReportModel({
    required this.id,
    required this.reporter,
    required this.notes,
    required this.address,
    required this.map,
    required this.image,
    required this.reportedDate,
    this.confirmed = false,
    this.confirmedBy,
    this.confirmedDate,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json['id'],
        reporter: json['reporter'],
        notes: json['notes'] ?? '',
        address: json['address'] ?? '',
        map: json['map'] ?? '',
        image: json['image'] ?? '',
        confirmed: json['confirmed'],
        reportedDate: json['reported_date'],
        confirmedBy: json['confirmed_by'],
        confirmedDate: json['confirmed_date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reporter': reporter,
        'notes': notes,
        'address': address,
        'map': map,
        'image': image,
        'confirmed': confirmed,
        'reported_date': reportedDate,
        'confirmed_by': confirmedBy,
        'confirmed_date': confirmedDate,
      };
}
