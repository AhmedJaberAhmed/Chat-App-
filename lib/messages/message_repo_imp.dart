import 'package:cloud_firestore/cloud_firestore.dart';

import 'MessageEntity.dart';
import 'Message_repo.dart';


class MessageRepoImp implements MessageRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> sendMessage(Message message) async {
    await firestore
        .collection("chats")
        .doc(getChatId(message.senderId, message.receiverId))
        .collection("messages")
        .doc(message.id)
        .set(message.toJson());
  }

  @override
  Stream<List<Message>> getMessages(String userId1, String userId2) {
    return firestore
        .collection("chats")
        .doc(getChatId(userId1, userId2))
        .collection("messages")
        .orderBy("timestamp")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Message.fromJson(doc.data()))
        .toList());
  }

  String getChatId(String uid1, String uid2) {
    if (uid1.hashCode <= uid2.hashCode) {
      return '${uid1}_$uid2';
    } else {
      return '${uid2}_$uid1';
    }
  }

}
