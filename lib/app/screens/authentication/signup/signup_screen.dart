import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/core/values/global_key.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = SignUpBloc.ins;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _rePassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _rePassController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  S.of(context).signup,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: S.of(context).enteryouremail,
                            prefixIcon: const Icon(Icons.mail_outline_rounded),
                            prefixIconConstraints:
                                const BoxConstraints(maxWidth: 20),
                            suffixIcon: _emailController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _emailController.clear();
                                      });
                                    },
                                    child: const Icon(Icons.cancel))
                                : null,
                            suffixIconConstraints:
                                const BoxConstraints(maxWidth: 20),
                          ),
                          validator: (val) => _bloc.validateEmail(val),
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: S.of(context).enteryourpass,
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            prefixIconConstraints:
                                const BoxConstraints(maxWidth: 20),
                          ),
                          validator: (val) => _bloc.validatePassword(val),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _rePassController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: S.of(context).enteryourpass,
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            prefixIconConstraints:
                                const BoxConstraints(maxWidth: 20),
                          ),
                          validator: (val) => _bloc.validateRePass(val),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.primaryColor,
            thickness: 0.8,
            height: 0,
          ),
          SizedBox(
            height: context.screenSize.height / 16,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () {
                      navigatorKey.currentState!.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cancel_outlined,
                            size: 15,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).cancel,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 0,
                ),
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () {
                      _bloc.validateSignUpForm(_formKey);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).OK,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
