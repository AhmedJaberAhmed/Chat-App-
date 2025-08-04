
import '../../features/authentication/domain/entities/app_user.dart';

abstract class UserRepo {
  Future<List<AppUser>> getAllUsersExceptMe(String myUid);
}
