import 'dart:convert';
import 'dart:developer';

import 'package:flutez/features/Search/Bloc/search_states.dart';
import 'package:flutez/features/Search/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  Uri searchUri(String text) {
    return Uri.parse(
        "https://youtube-music-api3.p.rapidapi.com/search?q=$text&type=song");
  }

  List searches = [];
  Future<void> searchTracks(String text) async {
    emit(SearchLoadingState());
    try{
      var response = await http.get(
        searchUri(text),
        headers: {
          'X-RapidAPI-Key': '2d8243ce2dmsh4e144f95478f00fp113780jsna2a7b17243c6',
          'X-RapidAPI-Host': 'youtube-music-api3.p.rapidapi.com'
        },
      );
      if(response.statusCode ==200){
        print(searches.length);
        Map<String,dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        searches = jsonResponse["result"].map((model) => SearchModel.fromJson(model)).toList();
        searches = searches.take(10).toList();
        emit(SearchSuccessState());
      }else{
        debugPrint("no tracks available");
        emit(SearchErrorState());
      }
    }catch (e){
      debugPrint(e.toString());
      emit(SearchErrorState());
    }


  }


}
