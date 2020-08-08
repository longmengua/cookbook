import 'dart:async';

import 'package:app/home/homeEvent.dart';
import 'package:app/widget/errorPages/noHealthBankFileError.dart';
import 'package:app/widget/secondLayer/BiochemicalExam.dart';
import 'package:app/widget/secondLayer/CCIScore.dart';
import 'package:app/widget/secondLayer/DrugFoodInteraction.dart';
import 'package:app/widget/secondLayer/MedicinesInquiry.dart';
import 'package:app/widget/secondLayer/HealthPromotionServices.dart';
import 'package:app/widget/secondLayer/MedicalRecord.dart';
import 'package:app/widget/secondLayer/PersonalHealthRiskAssessment.dart';
import 'package:app/widget/firstLayer/conclusion.dart';
import 'package:app/widget/firstLayer/config.dart';
import 'package:app/widget/dashboard/dashboard.dart';
import 'package:app/widget/firstLayer/diabetes.dart';
import 'package:app/widget/errorPages/error.dart';
import 'package:app/widget/firstLayer/glucose.dart';
import 'package:app/widget/firstLayer/healthBank.dart';
import 'package:app/widget/loading.dart';
import 'package:app/widget/firstLayer/medical.dart';
import 'package:app/widget/errorPages/netWorkError.dart';
import 'package:app/widget/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homeBloc.dart';
import 'homeState.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewWidgetState createState() => HomeViewWidgetState();
}

class HomeViewWidgetState extends State<HomeView> {
  Timer _timer; //讀取超過十秒後，自動導回首頁。
  HomeBloc homeBloc;

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        Widget toReturn;
        _timer?.cancel();
        switch (state) {
          case HomeState.splash:
            Future.delayed(Duration(seconds: 1))
                .then((v) => homeBloc.add(HomeEvent.dashboard));
            toReturn = Splash();
            break;
          case HomeState.loading:
            _timer = Timer(
              Duration(seconds: 10),
              () => homeBloc.add(HomeEvent.dashboard),
            );
            toReturn = Loading();
            break;
          case HomeState.dashboard:
            toReturn = DashBoard();
            break;
          case HomeState.diabetes:
            toReturn = Diabetes();
            break;
          case HomeState.medical:
            toReturn = Medical();
            break;
          case HomeState.healthBank:
            toReturn = HealthBank();
            break;
          case HomeState.glucose:
            toReturn = Glucose();
            break;
          case HomeState.config: //personal setting
            toReturn = Config();
            break;
          case HomeState.conclusion:
            toReturn = Conclusion();
            break;
          case HomeState.CCIScore:
            toReturn = CCIScore();
            break;
          case HomeState.BiochemicalExam:
            toReturn = BiochemicalExam();
            break;
          case HomeState.DrugInquiry:
            toReturn = MedicinesInquiry();
            break;
          case HomeState.DrugFoodInteraction:
            toReturn = DrugFoodInteraction();
            break;
          case HomeState.HealthPromotionService:
            toReturn = HealthPromotionService();
            break;
          case HomeState.MedicalRecord:
            toReturn = MedicalRecord();
            break;
          case HomeState.PersonalHealthRiskAssessment:
            toReturn = PersonalHealthRiskAssessment();
            break;
          case HomeState.networkError:
            Future.delayed(Duration(seconds: 1))
                .then((v) => homeBloc.add(HomeEvent.dashboard)); //顯示後，自動導回主頁。
            toReturn = NetWorkErrors();
            break;
          case HomeState.noHealthBankFileError:
            Future.delayed(Duration(seconds: 1))
                .then((v) => homeBloc.add(HomeEvent.dashboard)); //顯示後，自動導回主頁。
            toReturn = NoHealthBankFileError();
            break;
          case HomeState.error:
          default:
            Future.delayed(Duration(seconds: 1))
                .then((v) => homeBloc.add(HomeEvent.dashboard)); //顯示後，自動導回主頁。
            toReturn = Errors();
            break;
        }
        return toReturn;
      },
    );
  }
}
