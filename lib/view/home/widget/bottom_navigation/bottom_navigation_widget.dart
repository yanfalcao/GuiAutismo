import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/bottom_navigation_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:guiautismo/view/widget/icons/app_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavigationWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.getBloc<BottomNavigationBloc>();
    final localizations = AppLocalizations.of(context);

    return StreamBuilder<int>(
      stream: navigationBloc.outCurrentIndex,
      initialData: 0,
      builder: (context, snapshot) {
        return SizedBox(
          height: 65,
          child: BottomNavigationBar(
            currentIndex: snapshot.data,
            backgroundColor: AppColors.lightBlue,
            iconSize: 26,
            showUnselectedLabels: false,
            selectedLabelStyle: AppFonts.notoSansRegular(fontSize: 13),
            selectedItemColor: AppColors.white,
            items: [
              BottomNavigationBarItem(
                icon: snapshot.data == 0
                    ? AppIcons.home(height: 24, width: 24)
                    : AppIcons.homeOutline(height: 24, width: 24),
                label: localizations.home,
              ),
              BottomNavigationBarItem(
                  icon: snapshot.data == 1
                      ? AppIcons.book(height: 24, width: 20)
                      : AppIcons.bookOutline(height: 24, width: 20),
                  label: localizations.content
              ),
              BottomNavigationBarItem(
                  icon: snapshot.data == 2
                      ? AppIcons.user(height: 24, width: 24)
                      : AppIcons.userOutline(height: 24, width: 24),
                  label: localizations.profile
              )
            ],
            onTap: (currentIndex) {
              navigationBloc.inCurrentIndex.add(currentIndex);
            },
          ),
        );
      },
    );
  }
}