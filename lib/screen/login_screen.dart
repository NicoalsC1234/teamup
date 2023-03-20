import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamup/cubit/cubit_auth.dart';
import 'package:teamup/navigation/routes.dart';

import 'package:teamup/cubit/state_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Widget create(BuildContext context) => const LoginScreen();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;

    String? emailValidator(String? value) {
      if (value == null || value.isEmpty) return 'This is a required field';
      return null;
    }

    String? passwordValidator(String? value) {
      if (value == null || value.isEmpty) return 'This is a required field';
      return null;
    }

    return AbsorbPointer(
      absorbing: isSigningIn,
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ListView(
                  children: [
                    const Padding(padding: EdgeInsets.all(10.0)),
                    const Text(
                      'TEAM UP',
                      textAlign: TextAlign.center,
                      textScaleFactor: 5,
                      style: TextStyle(
                        color: Color.fromRGBO(245, 184, 0, 1),
                        fontFamily: 'BungeeInline',
                      ),
                        ),
                    Image.asset(
                      'lib/img/muñeco.png',
                      height: 120,
                      width: 120,
                    ),
                    const Padding(padding: EdgeInsets.all(20.0)),
                    Form(
                      key: formKey,
                      child: Column(children: [  
                        TextFormField(
                          textAlign: TextAlign.center,
                          controller: emailController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            icon:Icon(Icons.email, color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white)
                            ),
                          style: const TextStyle(color: Colors.black),
                          validator: emailValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          
                        ),
                        TextFormField(
                          controller: passwordController,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(
                                labelText: 'Password',
                                filled: true,
                                fillColor: Color.fromRGBO(255, 255, 255, 1),
                                icon:Icon(Icons.password, color: Colors.white),
                                ),
                          style: const TextStyle(color: Colors.black),
                          validator: passwordValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                        ),
                      ]),
                    ),
                    if (isSigningIn)
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: const CircularProgressIndicator(),
                      ),
                    if (state is AuthError)
                      Text(
                        state.message,
                        style: const TextStyle(
                            color: Colors.red,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
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
                        child: const Text('Log In'),
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {   
                            context.read<AuthCubit>().logInUser(
                              emailController.text,
                              passwordController.text,
                            );          
                                                        
                          }
                        }),
                    Row(
                      // ignore: sort_child_properties_last
                      children: <Widget>[
                        const Text(
                          'Does not have account?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().reset();
                            Navigator.pushNamed(context, Routes.register);
                          },
                          child: const Text(
                            'Sign Up',
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
