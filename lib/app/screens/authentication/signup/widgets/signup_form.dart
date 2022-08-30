import 'package:belove_app/app/screens/authentication/signup/signup_bloc.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_inherited.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../generated/l10n.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _rePassController = TextEditingController();

  late SignUpBloc _bloc;
  late GlobalKey<FormState> _formKey;

  @override
  void didChangeDependencies() {
    _bloc = SignUpInherited.of(context).bloc;
    _formKey = SignUpInherited.of(context).formKey;
    super.didChangeDependencies();
  }

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: S.of(context).enteryouremail,
              prefixIcon: const Icon(Ionicons.mail_outline),
              prefixIconConstraints: const BoxConstraints(maxWidth: 20),
              suffixIcon: _emailController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _emailController.clear();
                        });
                      },
                      child: const Icon(Icons.cancel))
                  : null,
              suffixIconConstraints: const BoxConstraints(maxWidth: 20),
            ),
            validator: (val) => _bloc.validateEmail(val),
            onChanged: (val) {
              setState(() {});
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            controller: _passController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: S.of(context).enteryourpass,
              prefixIcon: const Icon(Ionicons.lock_closed_outline),
              prefixIconConstraints: const BoxConstraints(maxWidth: 20),
            ),
            validator: (val) => _bloc.validatePassword(val),
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            controller: _rePassController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: S.of(context).enteryourpass,
              prefixIcon: const Icon(Ionicons.lock_closed_outline),
              prefixIconConstraints: const BoxConstraints(maxWidth: 20),
            ),
            validator: (val) => _bloc.validateRePass(val),
          ),
        ],
      ),
    );
  }
}
