import 'package:async_example_saegis/auth_controller.dart';
import 'package:async_example_saegis/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = AuthController();

  Future<String?> _signIn(LoginData data) async {
    var response = await _authController.signInWithEmail(data.name, data.password);
    return response;
  }

  Future<String?> _signUp(LoginData data) async {
    var response = await _authController.registerWithEmail(data.name, data.password);
    return response;
  }

  Future<String?> _recoverPassword(String name) async {
    await _authController.resetPassword(name);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Saegis',
      onLogin: _signIn,
      onSignup: _signUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
