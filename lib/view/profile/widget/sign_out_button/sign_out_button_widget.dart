import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/services/auth_service.dart';
import 'package:guiautismo/view/login/login_view.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignOutButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () async {
        AuthService.logout();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginView())
        );
      },
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            margin: EdgeInsets.only(top: 15, right: 25),
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              localizations.signOut,
              style: AppFonts.montserratSemiBold(fontSize: 12, color: AppColors.black),
            ),
          )
        ],
      ),
    );
  }
}
