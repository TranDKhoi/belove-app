import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/sidebar/sidebar_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';

class AddAnniversaryForm extends StatefulWidget {
  const AddAnniversaryForm({Key? key}) : super(key: key);

  @override
  State<AddAnniversaryForm> createState() => _AddAnniversaryFormState();
}

class _AddAnniversaryFormState extends State<AddAnniversaryForm> {
  final _titleController = TextEditingController();

  DateTime pickedDate = DateTime.now();

  final _bloc = SideBarBloc.ins;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      content: Wrap(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Ionicons.gift_outline),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintText: S.of(context).memoryname,
                            suffixIcon: _titleController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _titleController.clear();
                                      });
                                    },
                                    child:
                                        const Icon(Ionicons.close_circle_sharp))
                                : null,
                            suffixIconConstraints:
                                const BoxConstraints(maxWidth: 20),
                          ),
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Ionicons.calendar_outline),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {
                            showDatePicker();
                          },
                          child: Text(dateFormat(pickedDate)))
                    ],
                  ),
                ],
              ),
              const Divider(
                color: AppColors.primaryColor,
                endIndent: 0,
                thickness: 0.8,
              ),
              GestureDetector(
                onTap: () {
                  _bloc.uploadAnniversary(
                      _titleController.text.trim(), pickedDate);
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
                        S.of(context).create,
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
          )
        ],
      ),
    );
  }

  showDatePicker() async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.screenSize.height / 3,
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              backgroundColor: Colors.grey,
              initialDateTime: pickedDate,
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  pickedDate = newDate;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
