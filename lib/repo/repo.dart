import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_quiz/model/quiz.dart';

class ApiRepo {
  static Future<List<NormalModel>> getData(BuildContext context) async {
    final Dio dio = Dio();
    try {
      final response = await dio.get("https://api.jsonserve.com/Uw5CrX");

      if (response.statusCode == 200) {
        final List<dynamic> listOfQuiz = response.data["questions"];

        print(listOfQuiz.toString());

        Fluttertoast.showToast(
            msg: "Question fetched",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return listOfQuiz.map((e) {
          return NormalModel.fromJson(e);
        }).toList();
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
