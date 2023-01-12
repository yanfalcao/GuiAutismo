import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/bottom_navigation_bloc.dart';
import 'package:guiautismo/blocs/evaluation_bloc.dart';
import 'package:guiautismo/blocs/place_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/splash/splash_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import 'blocs/notice_bloc.dart';
import 'blocs/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return blocBuilder(
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'GuiAutismo',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('pt', ''),
            const Locale('en', '')
          ],
          theme: ThemeData(
            backgroundColor: AppColors.background,
          ),
          home: SplashView(),
        ),
      )
    );
  }
}

Widget blocBuilder({@required Widget child}){
  return BlocProvider(
    blocs: [
      Bloc((i) => BottomNavigationBloc()),
      Bloc((i) => PlaceBloc()),
      Bloc((i) => NoticeBloc()),
      Bloc((i) => UserBloc()),
      Bloc((i) => EvaluationBloc())
    ],
    child: child
  );
}
