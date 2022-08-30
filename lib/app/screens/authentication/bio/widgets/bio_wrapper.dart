import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/authentication/bio/bio_bloc.dart';
import 'package:belove_app/app/screens/authentication/bio/bio_inherited.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/values/color.dart';
import 'bio_form.dart';

class BioWrapper extends StatefulWidget {
  const BioWrapper({Key? key}) : super(key: key);

  @override
  State<BioWrapper> createState() => _BioWrapperState();
}

class _BioWrapperState extends State<BioWrapper> {
  late BioBloc _bloc;
  late GlobalKey<FormState> _formKey;

  @override
  void didChangeDependencies() {
    _bloc = BioInherited.of(context).bloc;
    _formKey = BioInherited.of(context).formKey;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: BioForm(),
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
                          Ionicons.checkmark_circle_outline,
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
    );
  }
}
