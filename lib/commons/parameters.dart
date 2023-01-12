import 'package:flutter/cupertino.dart';
import 'package:guiautismo/model/place.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParametersConstants{
  static Map<String, String> _paramCine = {
    'param_1':'Recebeu atendimento adequando?',
    'param_2':'A publicidade da sessão foi adequada?',
    'param_3':'A luminosidade na sessão foi agradável?',
    'param_4':'O volume de som na sessão foi agradável?',
    'param_5':'Como avalia o acesso (entrada e saída) a sala durante a exibição?'
  };

  static Map<String, String> _paramMarket = {
    'param_1':'Recebeu atendimento adequando?',
    'param_2':'Como avalia a prioridade nos caixas?',
    'param_3':'A luminosidade é agradável?',
    'param_4':'Como avalia os sons do local?',
    'param_5':'Como avalia a facilidade de encontrar os produtos?'
  };

  static String getTitleParam(BuildContext context, TypePlace typePlace, String id){
    final localizations = AppLocalizations.of(context);

    if(typePlace == TypePlace.CINEMA){
      switch(id){
        case 'param_1':
          return localizations.param_1_cine;
        case 'param_2':
          return localizations.param_2_cine;
        case 'param_3':
          return localizations.param_3_cine;
        case 'param_4':
          return localizations.param_4_cine;
        case 'param_5':
          return localizations.param_5_cine;
      }
    }
    switch(id){
      case 'param_1':
        return localizations.param_1_market;
      case 'param_2':
        return localizations.param_2_market;
      case 'param_3':
        return localizations.param_3_market;
      case 'param_4':
        return localizations.param_4_market;
      case 'param_5':
        return localizations.param_5_market;
    }
  }

  static List<String> getAllKeysParam(TypePlace typePlace){
    if(typePlace == TypePlace.CINEMA){
      return _paramCine.keys.toList();
    }
    return _paramMarket.keys.toList();
  }

  static String _getTitleParamCinema(String id){
    return _paramCine[id];
  }

  static String _getTitleParamSupermarket(String id){
    return _paramMarket[id];
  }
}