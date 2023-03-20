import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamup/cubit/cubit_auth.dart';
import 'package:teamup/cubit/user_cubit.dart';
import 'package:teamup/model/user.dart';
import 'package:teamup/navigation/routes.dart';
import 'package:teamup/repository/implementation/user_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(UserRepository())..getUser(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserReadyState) {
            return HomeBuild(state.user);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class HomeBuild extends StatefulWidget {
  final MyUser user;

  const HomeBuild(this.user, {super.key});

  @override
  State<HomeBuild> createState() => _HomeBuildState();
}

class _HomeBuildState extends State<HomeBuild> {
  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'lib/Images/IconLogo.png',
      fit: BoxFit.fill,
    );

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: ClipOval(
            child: SizedBox(
              child: IconButton(
                icon: image,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.profile);
                },
              ),
            ),
          ),
        ),
        title: Text(widget.user.name),
        actions: [
          IconButton(
            onPressed: () 
            =>  context.read<AuthCubit>().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TEAM UP',
              textAlign: TextAlign.center,
              textScaleFactor: 3,
              style: TextStyle(
                color: Color.fromRGBO(245, 184, 0, 1),
                fontFamily: 'BungeeInline',
              ),
            ),
            Image.asset(
              'lib/img/muñeco.png',
              height: 80,
              width: 80,
            ),
            ElevatedButton(
            
            style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(229, 36, 55, 50),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30, 
            ),
              minimumSize: const Size.fromHeight(50),
            ),
              child: const Text('MAP'),
            onPressed: () {
              Navigator.pushNamed(context, Routes.register);
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(245, 184, 0, 1),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30, 
              ),
                minimumSize: const Size.fromHeight(50),
              ),
                child: const Text('TEAMS'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(229, 36, 55, 50),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30, 
              ),
                minimumSize: const Size.fromHeight(50),
              ),
                child: const Text('SPORTS'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(245, 184, 0, 1),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30, 
              ),
                minimumSize: const Size.fromHeight(50),
              ),
                child: const Text('SEARCH'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(229, 36, 55, 50),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30, 
              ),
                minimumSize: const Size.fromHeight(50),
              ),
                child: const Text('ROUTINES'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(245, 184, 0, 1),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 30, 
              ),
                minimumSize: const Size.fromHeight(50),
              ),
                child: const Text('TOURNAMENTS'),
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
            }),
          ],
        ),
      ),
    );
  }
}
