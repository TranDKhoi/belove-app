import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/screens/profile/widgets/partner_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';
import '../profile_bloc.dart';

class ConnectPartnerForm extends StatefulWidget {
  const ConnectPartnerForm({Key? key}) : super(key: key);

  @override
  State<ConnectPartnerForm> createState() => _ConnectPartnerFormState();
}

class _ConnectPartnerFormState extends State<ConnectPartnerForm> {
  final _codeController = TextEditingController();
  final _bloc = ProfileBloc.ins;

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
                      controller: _codeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: S.of(context).partnerId,
                        suffixIcon: _codeController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _codeController.clear();
                                  });
                                },
                                child: const Icon(Icons.cancel))
                            : null,
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 20),
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(S.of(context).myId),
                    TextField(
                      readOnly: true,
                      controller: TextEditingController()
                        ..text = GlobalData.ins.currentUser!.userId!,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: GlobalData.ins.currentUser!.userId));
                              EasyLoading.showToast(S.of(context).copied);
                            },
                            child: const Icon(Ionicons.copy_outline)),
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 20),
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
                onTap: () async {
                  if (_codeController.text.isEmpty) return;
                  var partner = await _bloc.findPartner(_codeController.text);
                  if (partner != null) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PartnerInfoForm(partner: partner);
                        });
                  }
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
                        S.of(context).confirm,
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
