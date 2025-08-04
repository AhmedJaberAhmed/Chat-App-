import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/authentication/domain/entities/app_user.dart';
import '../user_repo.dart';

class UserRepoImp implements UserRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<AppUser>> getAllUsersExceptMe(String myUid) async {
    final querySnapshot = await firestore.collection("users").get();
    return querySnapshot.docs
        .where((doc) => doc.id != myUid)
        .map((doc) => AppUser.fromJson(doc.data()))
        .toList();
  }
}
