
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teamup/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamup/cubit/cubit_auth.dart';
import 'package:teamup/cubit/state_auth.dart';
import 'package:teamup/navigation/routes.dart';
import 'package:teamup/repository/implementation/auth_repository.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();

  final authCubit = AuthCubit(AuthRepository());

  runApp(BlocProvider(
    create: (context) => authCubit..init(),
    child: MyApp.create(),
  ));

}

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.home, (route) => false);
        }
      },
      child: const MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'TeamUp',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(0, 5, 20, 1)),
      onGenerateRoute: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
