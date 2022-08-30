import 'package:belove_app/app/screens/authentication/bio/bio_bloc.dart';
import 'package:belove_app/app/screens/authentication/bio/bio_inherited.dart';
import 'package:belove_app/app/screens/authentication/bio/widgets/bio_wrapper.dart';
import 'package:flutter/material.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final _bloc = BioBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BioInherited(_bloc, child: const BioWrapper());
  }
}
