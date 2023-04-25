import 'package:flutter/material.dart';
import 'package:flutter_sample/components/demo_button.dart';
import 'package:flutter_sample/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/demo_appbar.dart';
import '../../constants/routes.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(),
      child: Scaffold(
        appBar: const DEMOAppBar(title: 'Demo homepage'),
        body: Column(children: [
          DEMOButton(
              child: const Text('LoginScreen'),
              onPressed: () {
                Navigator.pushNamed(context, loginScreen);
              })
        ]),
      ),
    );
  }
}
