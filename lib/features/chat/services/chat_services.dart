import 'package:chat_app/core/services/firestore_sservices.dart';

import '../../../core/utils/api_path.dart';
import '../models/message_model.dart';

class ChatServices {
  final _firstoreServices = FirestoreService.instance;
  Future<void> sendMessage(MessageModel message) async {
    try {
      await _firstoreServices.setData(
          path: ApiPath.sendMessage(message.id), data: message.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<MessageModel>> getMessages() {
    try {
      return _firstoreServices.collectionStream(
        path: ApiPath.messages(),
        builder: (data, documentId) => MessageModel.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }
}


