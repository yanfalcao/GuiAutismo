import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/commons/filter_constants.dart';
import 'package:guiautismo/services/filter_service.dart';
import 'package:guiautismo/view/home/widget/bottom_sheet_filter/widget/buttom_border.dart';
import 'package:guiautismo/view/home/widget/bottom_sheet_filter/widget/buttom_full.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetFilter{
  static FilterConstants _CLASSIFICAR_POR_SELECTED = FilterConstants.NONE;
  static FilterConstants _TIPO_LOCAL_SELECTED = FilterConstants.NONE;

  static void build(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius()
      ),
      builder: (context) {
        final localizations = AppLocalizations.of(context);

        return StatefulBuilder(builder: (context, setState){
          return _buildBottomSheetScaffold(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(localizations.filter,
                  style: AppFonts.montserratLight(
                      fontSize: 25,
                      color: AppColors.black
                  ),
                ),
              ),
              SizedBox(height: 25),
              _buildTitle(localizations.sortBy),
              SizedBox(height: 15),
              _buildFilterRow(
                  children: [
                    ButtomBorder(
                        text: localizations.highScore,
                        color: _CLASSIFICAR_POR_SELECTED == FilterConstants.MAIS_ALTA
                            ? AppColors.greenDark
                            : null,
                        onTap: () {
                          setState(() {
                            if(_CLASSIFICAR_POR_SELECTED == FilterConstants.MAIS_ALTA)
                              _CLASSIFICAR_POR_SELECTED = FilterConstants.NONE;
                            else
                              _CLASSIFICAR_POR_SELECTED = FilterConstants.MAIS_ALTA;
                          });
                        }
                    ),
                    SizedBox(width: 15),
                    ButtomBorder(
                        text: localizations.lowestScore,
                        color: _CLASSIFICAR_POR_SELECTED == FilterConstants.MAIS_BAIXA
                            ? AppColors.greenDark
                            : null,
                        onTap: () {
                          setState(() {
                            if(_CLASSIFICAR_POR_SELECTED == FilterConstants.MAIS_BAIXA)
                              _CLASSIFICAR_POR_SELECTED = FilterConstants.NONE;
                            else
                              _CLASSIFICAR_POR_SELECTED = FilterConstants.MAIS_BAIXA;
                          });
                        }
                    )
                  ]
              ),
              SizedBox(height: 25),
              _buildTitle(localizations.typeOfPlace),
              SizedBox(height: 15),
              _buildFilterRow(
                  children: [
                    ButtomBorder(
                        text: localizations.supermarket,
                        color:_TIPO_LOCAL_SELECTED == FilterConstants.SUPERMERCADO
                            ? AppColors.greenDark
                            : null,
                        onTap: () {
                          setState(() {
                            if(_TIPO_LOCAL_SELECTED == FilterConstants.SUPERMERCADO)
                              _TIPO_LOCAL_SELECTED = FilterConstants.NONE;
                            else
                              _TIPO_LOCAL_SELECTED = FilterConstants.SUPERMERCADO;
                          });
                        }
                    ),
                    SizedBox(width: 15),
                    ButtomBorder(
                        text: localizations.cinema,
                        color: _TIPO_LOCAL_SELECTED == FilterConstants.CINEMA
                            ? AppColors.greenDark
                            : null,
                        onTap: () {
                          setState(() {
                            if(_TIPO_LOCAL_SELECTED == FilterConstants.CINEMA)
                              _TIPO_LOCAL_SELECTED = FilterConstants.NONE;
                            else
                              _TIPO_LOCAL_SELECTED = FilterConstants.CINEMA;
                          });
                        }
                    )
                  ]
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtomFull(
                    text: localizations.cancel,
                    color: AppColors.lightGrey,
                    onTap: () {
                      _CLASSIFICAR_POR_SELECTED = FilterConstants.NONE;
                      _TIPO_LOCAL_SELECTED = FilterConstants.NONE;
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 15),
                  ButtomFull(
                    text: localizations.filtrate,
                    color: AppColors.greenStar,
                    onTap: () {
                      Navigator.pop(context);
                    }
                  )
                ],
              ),
            ]
          );
        });
      }
    ).then((value) {
      (FilterService.instance).filterPlaces(
          classificarPorFilter: _CLASSIFICAR_POR_SELECTED,
          tipoLocalFilter: _TIPO_LOCAL_SELECTED
      );
    });
  }

  static Widget _buildBottomSheetScaffold({List<Widget> children}) => Container(
    width: double.maxFinite,
    decoration: BoxDecoration(borderRadius: _borderRadius()),
    child: Padding(
      padding: EdgeInsets.only(top: 12, left: 15, right: 10, bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    ),
  );

  static Widget _buildFilterRow({List<Widget> children}) => Align(
    alignment: Alignment.centerLeft,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children
      ),
    ),
  );

  static BorderRadius _borderRadius() => BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20)
  );

  static Widget _buildTitle(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(text,
      style: AppFonts.montserratLight(
          fontSize: 20,
          color: AppColors.black
      ),
    )
  );
}