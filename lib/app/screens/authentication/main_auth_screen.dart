import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/app/screens/authentication/login/login_bloc.dart';
import 'package:belove_app/app/screens/authentication/login/login_form.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class MainAuthScreen extends StatelessWidget {
  MainAuthScreen({Key? key}) : super(key: key);

  final _bloc = LoginBloc.ins;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/login_wallpaper.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: context.screenSize.height / 10),
                    Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                      height: 100,
                    ),
                    const Text(
                      "BeLove",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: context.screenSize.height / 16,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          navigatorKey.currentState?.pushNamed(signUpScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            S.of(context).signup,
                            textAlign: TextAlign.center,
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
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const LoginForm();
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            S.of(context).login,
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
