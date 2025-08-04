import 'package:chat_app/users/user_repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/authentication/domain/entities/app_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;

  UserCubit({required this.userRepo}) : super(UserInitial());

  void fetchUsers(String myUid) async {
    emit(UserLoading());
    try {
      final users = await userRepo.getAllUsersExceptMe(myUid);
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
