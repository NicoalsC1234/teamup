import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamup/navigation/routes.dart';
import '../../cubit/cubit_auth.dart';
import '../../cubit/state_auth.dart';




class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static Widget create(BuildContext context) => const RegisterScreen();

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final repeatPasswordController = TextEditingController();
    final ageController = TextEditingController();
    final descriptionController = TextEditingController();

    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;

    String? emailValidator(String? value) {
      if (value == null || value.isEmpty) return 'This is a required field';
      if (!EmailValidator.validate(value)) return 'Enter a valid email';
      return null;
    }

    String? passwordValidator(String? value) {
      if (value == null || value.isEmpty) return 'This is a required field';
      if (value.length < 6) return 'Password should be at least 6 letters';
      if (passwordController.text != repeatPasswordController.text) {
        return 'Password do not match';
      }
      return null;
    }

    String? requiredValidator(String? value) {
      if (value == null || value.isEmpty) return 'This is a required field';
      return null;
    }


    return AbsorbPointer(
      
      absorbing: isSigningIn,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(229, 36, 55, 1),
        appBar: AppBar(
          title: const Text('Register User', style: TextStyle(color: Colors.black),),
          backgroundColor: const Color.fromRGBO(245, 184, 0, 1),
          
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ListView(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            
                            controller: nameController,
                            maxLength: 30,
                            decoration:
                                const InputDecoration(
                                    labelText: 'Full Name',
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                            validator: requiredValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: emailController,
                            maxLength: 30,
                            decoration:
                                const InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                            validator: emailValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: passwordController,
                            maxLength: 30,
                            decoration:
                                const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                            validator: passwordValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: repeatPasswordController,
                            maxLength: 30,
                            decoration: const InputDecoration(
                                    labelText: 'Repet password',
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                            validator: passwordValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: ageController,
                            maxLength: 3,
                            decoration: const InputDecoration(
                                    labelText: 'Age',
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                            validator: requiredValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextFormField(
                            controller: descriptionController,
                            maxLength: 500,
                            decoration: const InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                            validator: requiredValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
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
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(

                        primary: const Color.fromRGBO(245, 184, 0, 1),
                        onPrimary: Colors.black,
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 30, 
                            
                          ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Register'),
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          context.read<AuthCubit>().registerUser(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                int.tryParse(ageController.text) ?? 0,
                                descriptionController.text,
                              );
                        }
                      },
                    ),
                    Row(
                      // ignore: sort_child_properties_last
                      children: <Widget>[
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().reset();
                            Navigator.pushNamed(context, Routes.login);
                          },
                          child: const Text(
                            'LogIn',
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


