import 'package:flutter_bloc/flutter_bloc.dart';

import 'MessageEntity.dart';
import 'Message_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final MessageRepo messageRepo;

  ChatCubit({required this.messageRepo}) : super(ChatInitial());

  void sendMessage(Message message) async {
    await messageRepo.sendMessage(message);
  }

  void listenForMessages(String userId1, String userId2) {
    emit(ChatLoading());
    messageRepo.getMessages(userId1, userId2).listen((messages) {
      emit(ChatLoaded(messages));
    });
  }
}
