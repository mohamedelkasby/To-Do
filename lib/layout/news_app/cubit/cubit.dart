// import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/news_app/modules/busuness.dart';
import 'package:to_do_app/layout/news_app/modules/science.dart';
import 'package:to_do_app/layout/news_app/modules/sports.dart';
import 'package:to_do_app/layout/news_app/cubit/states.dart';

import '../shared/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  var currIndex = 0;
  List business = [];
  List sports = [];
  List science = [];
  List search = [];
  int bussIndex = 0;
  int sporIndex = 0;
  int scieIndex = 0;
  int searchIndex = 0;
  List bodyList = [const Business(), const Sports(), const Science()];
  List appBarList = ["Business", "Sports", "Science"];
  bool light = true;

  void bottomNav(int index) {
    currIndex = index;
    emit(BottomNavBarState());
  }

  void LightDarkButton() {
    light = !light;
    emit(LightDarkButtonState());
  }
  // void webLuncher(Uri url){
  //   launchUrl(url);
  // }

  void getBusiness() {
    emit(NewsLoadingState());
    DioHelper.getData(url: "v2/top-headlines", quary: {
      "country": "eg",
      "category": "business",
      "apiKey": "54429b9fa88d420b924daec0fd7711e0",
    }).then((value) {
      business = value.data["articles"];
      bussIndex = business.length;
      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      print("$e hhhhhhhhhhhhh");
      emit(NewsGetBusinessErrorState(e));
    });
  }

  void getSports() {
    emit(NewsLoadingState());
    DioHelper.getData(url: "v2/top-headlines", quary: {
      "country": "eg",
      "category": "sports",
      "apiKey": "54429b9fa88d420b924daec0fd7711e0",
    }).then((value) {
      sports = value.data["articles"];
      sporIndex = sports.length;
      // print(bussIndex);
      emit(NewsGetSportsSuccessState());
    }).catchError((e) {
      print("$e hhhhhhhhhhhhh");
      emit(NewsGetSportsErrorState(e));
    });
  }

  void getScience() {
    emit(NewsLoadingState());
    DioHelper.getData(url: "v2/top-headlines", quary: {
      "country": "eg",
      "category": "science",
      "apiKey": "54429b9fa88d420b924daec0fd7711e0",
    }).then((value) {
      science = value.data["articles"];
      scieIndex = science.length;
      emit(NewsGetScienceSuccessState());
    }).catchError((e) {
      print("$e IS THE ERROR");
      emit(NewsGetScienceErrorState(e));
    });
  }

  void getSearch(String value) {
    // emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: "v2/everything", quary: {
      "q": value,
      "apiKey": "54429b9fa88d420b924daec0fd7711e0",
    }).then((value) {
      search = value.data["articles"];
      searchIndex = search.length;
      emit(SearchTermsState());
    }).catchError((e) {
      print("$e IS THE ERROR");
      // emit(NewsGetScienceErrorState(e));
    });
  }

  // Future<List> getSearch(String value) async {
  //   List<String> searchTerms = [];

  //   DioHelper.getData(url: "v2/everything", quary: {
  //     "q": "$value",
  //     "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
  //   }).then((value) {
  //     return searchTerms = value.data["articles"];
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   emit(SearchTermsState());
  //   return searchTerms;
  // }
}
