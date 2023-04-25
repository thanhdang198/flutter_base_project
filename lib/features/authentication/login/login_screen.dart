import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_sample/components/demo.dart';
import 'package:flutter_sample/components/demo_appbar.dart';
import 'package:flutter_sample/components/demo_textfield.dart';
import 'package:flutter_sample/constants/routes.dart';
import 'package:flutter_sample/domains/use_case/authentication_use_case.dart';
import 'package:flutter_sample/features/authentication/bloc/authentication_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/demo_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationStateUserLoginSuccess) {
          Navigator.pushNamed(context, homeScreen);
          ScaffoldMessenger.of(context)
              .showSnackBar(const DEMOSnackBar(content: Text('LoginSuccess')));
        }
        if (state is AuthenticationStateUserLoginFailure) {
          //TODO: Handle on login failure here
          ScaffoldMessenger.of(context)
              .showSnackBar(const DEMOSnackBar(content: Text('LoginSuccess')));
        }
      },
      listenWhen: (previous, current) =>
          current is AuthenticationStateLoading ||
          current is AuthenticationStateUserLoginFailure ||
          current is AuthenticationStateUserLoginSuccess,
      child: Scaffold(
        appBar: const DEMOAppBar(title: 'Demo login'),
        body: Column(
          children: [
            DEMOTextField(controller: userNameController),
            DEMOTextField(controller: passwordController),
            DEMOButton(
              onPressed: () {
                if (userNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const DEMOSnackBar(
                      content: Text('User name must not empty')));
                  return;
                }
                if (userNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const DEMOSnackBar(
                      content: Text('Password must not empty')));
                  return;
                }
                context.read<AuthenticationBloc>().add(
                    AuthenticationEventUserLogin(
                        userLoginParams: UserLoginParams(
                            userName: userNameController.text,
                            password: passwordController.text)));
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
