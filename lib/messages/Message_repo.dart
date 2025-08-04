
import 'MessageEntity.dart';

abstract class MessageRepo {
  Future<void> sendMessage(Message message);
  Stream<List<Message>> getMessages(String userId1, String userId2);
}
