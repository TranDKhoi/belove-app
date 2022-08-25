import 'package:belove_app/app/core/values/theme.dart';
import 'package:belove_app/app/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../generated/l10n.dart';
import '../../core/values/global_key.dart';
import '../../screens/my_app/my_app_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final MyAppBloc _bloc = MyAppBloc.ins;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _bloc.languageStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          navigatorKey: navigatorKey,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale:
              snapshot.hasData ? Locale(snapshot.data!) : const Locale("en"),
          builder: EasyLoading.init(),
          initialRoute: mainAuthScreen,
          routes: appRoute,
        );
      },
    );
  }
}
