import 'package:chat_app/users/user_cubit.dart';
import 'package:chat_app/users/user_repo/user_repo_imp/user_repo_imp.dart';
import 'package:chat_app/ustils/ustils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'features/Home/presentation/home.dart';
import 'features/authentication/data/repos/auth_repo_imp.dart';
import 'features/authentication/presentaion/cubits/auth_cubit/auth_cubit.dart';

import 'features/authentication/presentaion/pages/auth_page.dart';
import 'messages/chat_cubit.dart';
import 'messages/message_repo_imp.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<UserCubit>(
          create: (context) => UserCubit(userRepo: UserRepoImp()),
        ),


        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(messageRepo: MessageRepoImp()),
        ),


        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: AuthRepoImp())..checkAuth(),
        ),
        // BlocProvider<ProfileCubit>(
        //   create: (context) => ProfileCubit(
        //       storageRepo: StorageRepoImp(),
        //       profileRepo: FirebaseProfileRepo()),
        // ),
        // BlocProvider<PostCubit>(
        //   create: (context) =>
        //       PostCubit(storageRepo: StorageRepoImp(), postRepo: PostRepoImp()),
        // ),
        // BlocProvider<SearchCubit>(
        //     create: (context) => SearchCubit(searchRepo: SearchRepoImp())),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, currentTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: currentTheme,
            home: BlocConsumer<AuthCubit, AuthenticationState>(
              listener: (context, authState) {
                if (authState is AuthFailed) {
                  final overlay = Overlay.of(context);
                  showTopSnackBar(
                    overlay,
                    CustomSnackBar.error(message: authState.message),
                  );
                }
              },
              builder: (context, authState) {
                if (authState is AuthUnauthenticated) {
                  return const AuthPage();
                }

                if (authState is AuthAuthenticated) {
                  return const
                   HomePage();
                }

                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

