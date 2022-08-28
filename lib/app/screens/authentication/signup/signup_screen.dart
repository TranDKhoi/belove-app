import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_bloc.dart';
import 'package:belove_app/app/screens/authentication/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _bloc = SignUpBloc.ins;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).signup,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: SignUpForm(formKey: _formKey),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Text(
                    S.of(context).Afterverified,
                    textAlign: TextAlign.center,
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
