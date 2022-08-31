import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../generated/l10n.dart';
import '../../global_data/global_key.dart';
import '../../screens/my_app/my_app_bloc.dart';
import '../sidebar/sidebar_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyAppBloc _bloc = MyAppBloc.ins;

  @override
  void dispose() {
    _bloc.dispose();
    SideBarBloc.ins.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _bloc.darkModeStream,
      builder: (context, darkData) {
        return StreamBuilder<String>(
          stream: _bloc.languageStream,
          builder: (context, snapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: darkData.hasData
                  ? darkData.data == false
                      ? AppColors().lightTheme
                      : AppColors().darkTheme
                  : GlobalData.ins.isDark == false
                      ? AppColors().lightTheme
                      : AppColors().darkTheme,
              navigatorKey: navigatorKey,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: snapshot.hasData
                  ? Locale(snapshot.data!)
                  : Locale(GlobalData.ins.currentLang),
              builder: EasyLoading.init(),
              initialRoute: GlobalData.ins.currentUser?.userId == null
                  ? mainAuthScreen
                  : bottomBarScreen,
              routes: appRoute,
            );
          },
        );
      },
    );
  }
}
