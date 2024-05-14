import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/services/user_services.dart';
import '../models/message_model.dart';
import '../services/chat_services.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final chatServices = ChatServices();
  final userServices = UserServices();

  Future<void> sendMessage(String message) async {
    emit(ChatMessageSending());
    try {
      final currentUser = await userServices.getUser();

      final chatMessage = MessageModel(
        id: DateTime.now().toIso8601String(),
        message: message,
        senderId: currentUser.id,
        senderName: currentUser.username,
        senderPhotoUrl: currentUser.photoUrl,
        dateTime: DateTime.now(),
      );

      await chatServices.sendMessage(chatMessage);
      emit(ChatMessageSent());
    } catch (e) {
      emit(ChatMessageSendFailure(e.toString()));
    }
  }

  Future<void> getMessages() async {
    emit(ChatLoading());
    try {
      final messagesStream = chatServices.getMessages();
      messagesStream.listen((messages) {
        emit(ChatSuccess(messages));
      });
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }
}
