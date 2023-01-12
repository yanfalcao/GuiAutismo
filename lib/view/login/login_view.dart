import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/services/auth_service.dart';
import 'package:guiautismo/services/resources_service.dart';
import 'package:guiautismo/view/home/home_view.dart';
import 'package:guiautismo/view/login/widget/button/login_button_widget.dart';
import 'package:guiautismo/view/login/widget/images/app_images.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:guiautismo/view/widget/icons/app_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          AppImages.backgroundLoginImage(),
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcons.logo(height: 200, width: 200),
                SizedBox(height: 12),
                Text(
                  localizations.guiAutismo,
                  style: AppFonts.montserratRegular(
                      fontSize: 30,
                      color: AppColors.mediumGrey
                  ),
                ),
                SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: LoginButtonWidget(
                    onTap: () async {
                      if(await ResourcesService.hasInternetConnection())
                        AuthService.loginWithfacebook(
                            successComplete: () =>
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => HomeView())
                                )
                        );
                    },
                    height: 55,
                    color: AppColors.blueFacebook,
                    icon: AppIcons.facebook(height: 25, width: 15),
                    text: localizations.loginFacebook
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: LoginButtonWidget(
                    onTap: () async {
                      if(await ResourcesService.hasInternetConnection())
                        AuthService.loginWithGoogle(
                          successComplete: () =>
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomeView())
                          )
                        );
                    },
                    height: 55,
                    icon: AppIcons.google(height: 25, width: 25),
                    text: localizations.loginGoogle,
                    textColor: AppColors.mediumGrey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void navigate(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeView())
    );
  }
}
