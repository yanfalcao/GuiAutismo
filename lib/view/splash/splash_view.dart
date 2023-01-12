import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/user_bloc.dart';
import 'package:guiautismo/services/auth_service.dart';
import 'package:guiautismo/view/home/home_view.dart';
import 'package:guiautismo/view/login/login_view.dart';
import 'package:guiautismo/view/widget/icons/app_icons.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthService authService;
  final userBloc = BlocProvider.getBloc<UserBloc>();

  @override
  void initState() {
    super.initState();

    authService = AuthService();
    authService.authCheck(bloc: userBloc);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: userBloc.outUser,
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.waiting){
          if(!snapshot.hasData){
            WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginView())
              )
            );

          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeView())
                )
            );
          }
        }

        return Scaffold(
          body: Center(
            child: AppIcons.logo(height: 200, width: 200),
          ),
        );
      }
    );
  }
}
