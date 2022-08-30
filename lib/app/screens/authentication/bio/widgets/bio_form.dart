import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/screens/authentication/bio/bio_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../generated/l10n.dart';
import '../bio_bloc.dart';
import '../bio_inherited.dart';

class BioForm extends StatefulWidget {
  const BioForm({Key? key}) : super(key: key);

  @override
  State<BioForm> createState() => _BioFormState();
}

class _BioFormState extends State<BioForm> {
  final _nameController = TextEditingController();
  late GlobalKey<FormState> _formKey;
  late BioBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = BioInherited.of(context).bloc;
    _formKey = BioInherited.of(context).formKey;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          StreamBuilder<int>(
              stream: _bloc.genderStream,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Opacity(
                      opacity: _bloc.gender == 0 ? 1 : 0.5,
                      child: GestureDetector(
                        onTap: () {
                          _bloc.updateGender(0);
                        },
                        child: Image.asset(
                          "assets/images/boy.png",
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _bloc.gender == 1 ? 1 : 0.5,
                      child: GestureDetector(
                        onTap: () {
                          _bloc.updateGender(1);
                        },
                        child: Image.asset(
                          "assets/images/girl.png",
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                );
              }),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: S.of(context).yourname,
              prefixIcon: const Icon(Ionicons.person_outline),
              prefixIconConstraints: const BoxConstraints(maxWidth: 20),
              suffixIcon: _nameController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _nameController.clear();
                        });
                      },
                      child: const Icon(Ionicons.close_circle_sharp))
                  : null,
              suffixIconConstraints: const BoxConstraints(maxWidth: 20),
            ),
            validator: (val) => _bloc.validateName(val),
            onChanged: (val) {
              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.cake_outlined,
                color: AppColors.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: StreamBuilder<String>(
                  stream: _bloc.birthDayStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      );
                    }
                    return Text(
                      S.of(context).dateofbirth,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    );
                  },
                ),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: context.screenSize.height / 3,
                        color: CupertinoColors.systemBackground
                            .resolveFrom(context),
                        child: SafeArea(
                          top: false,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime(2001, 3, 25),
                            maximumDate: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime newDate) {
                              _bloc.updateBirthDay(newDate);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
