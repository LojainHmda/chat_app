// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final String senderPhotoUrl;
  final DateTime dateTime;

  MessageModel(
      {required this.id,
      required this.senderId,
      required this.senderName,
      required this.message,
      required this.senderPhotoUrl,
      required this.dateTime});




      

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'message': message,
      'senderPhotoUrl': senderPhotoUrl,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
     id: map['id'] as String,
     senderId: map['senderId'] as String,
     senderName: map['senderName'] as String,
     message: map['message'] as String,
     senderPhotoUrl: map['senderPhotoUrl'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

}
