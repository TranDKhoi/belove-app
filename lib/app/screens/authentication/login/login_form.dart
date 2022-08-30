import 'package:belove_app/app/screens/authentication/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _bloc = LoginBloc();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Wrap(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: S.of(context).enteryouremail,
                        suffixIcon: _emailController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _emailController.clear();
                                  });
                                },
                                child: const Icon(Ionicons.close_circle_sharp))
                            : null,
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 20),
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: S.of(context).enteryourpass,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColors.primaryColor,
                endIndent: 0,
                thickness: 0.8,
              ),
              GestureDetector(
                onTap: () {
                  _bloc.loginWithEmailPass(
                      email: _emailController.text,
                      password: _passController.text);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.checkmark_circle_outline,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        S.of(context).login,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
