import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/user.dart';
import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';
import '../profile_bloc.dart';

class PartnerInfoForm extends StatefulWidget {
  const PartnerInfoForm(this.bloc, {Key? key, required this.partner})
      : super(key: key);
  final User partner;
  final ProfileBloc bloc;

  @override
  State<PartnerInfoForm> createState() => _PartnerInfoFormState();
}

class _PartnerInfoFormState extends State<PartnerInfoForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Wrap(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Text(S.of(context).isthisyourbeloved),
              Padding(padding: const EdgeInsets.all(10), child: infoWidget()),
              const Divider(
                color: AppColors.primaryColor,
                endIndent: 0,
                thickness: 0.8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      navigatorKey.currentState?.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cancel_outlined,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).no,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await widget.bloc.connectPartner(widget.partner.userId!);
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
                            S.of(context).yes,
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
        ],
      ),
    );
  }

  Widget infoWidget() {
    return Column(
      children: [
        widget.partner.avatar! == ""
            ? Image.asset(
                widget.partner.gender == 0
                    ? "assets/images/boy.png"
                    : "assets/images/girl.png",
                width: 110,
                height: 110,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: Image.network(
                      widget.partner.avatar!,
                      fit: BoxFit.contain,
                    ).image,
                  ),
                ],
              ),
        const SizedBox(height: 20),
        Text(
          widget.partner.name!,
          style: const TextStyle(fontSize: 17),
        ),
        Text(
          dateFormat(widget.partner.birthday!),
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
