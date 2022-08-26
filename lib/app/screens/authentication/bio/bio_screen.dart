import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/authentication/bio/bio_bloc.dart';
import 'package:belove_app/app/screens/authentication/bio/widgets/bio_form.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = BioBloc.ins;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.of(context).youare,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: BioForm(formKey: _formKey),
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
                      _bloc.validateBioForm(_formKey);
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
