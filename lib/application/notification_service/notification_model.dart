import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReceivedModel extends Equatable {
  final int id;
  final String title;
  final String body;
  final String imageUrl;
  final String payload;

  const ReceivedModel({
    required this.id,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.payload,
  });

  ReceivedModel copyWith({
    int? id,
    String? title,
    String? body,
    String? imageUrl,
    String? payload,
  }) {
    return ReceivedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      payload: payload ?? this.payload,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'payload': payload,
    };
  }

  factory ReceivedModel.fromMap(Map<String, dynamic> map) {
    return ReceivedModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      payload: map['payload'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceivedModel.fromJson(String source) =>
      ReceivedModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReceivedNotification(id: $id, title: $title, body: $body, imageUrl: $imageUrl, payload: $payload)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      body,
      imageUrl,
      payload,
    ];
  }
}
