import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'auth_provider.dart';
import 'package:intl/intl.dart';
class SelectorProvider extends ChangeNotifier{
  List<Question> history=[];
  final uid=AuthServiceProvider().currentUser!.uid;
  Question question = Question();
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future<List<Question>>  getHistory()async{
    try {
      QuerySnapshot data = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("questions")
          .orderBy("createdAt", descending: true)
          .get();
      history=List.from(data.docs.map((doc) => Question.fromSnapshot(doc)));
      print(history.length.toString());
      notifyListeners();
      return history;
    }catch(e){
      throw Exception(e.toString());
    }
  }
  String getChoice() {
    var choices = ["red", "yellow", "green", "white","black","blue"];
    notifyListeners();
    return choices[Random().nextInt(choices.length)];
  }

  void choiceOfQuestion(String query,String choice,DateTime createdAt ) async {
    question.query = query;
    question.choice = choice;
    question.createdAt = createdAt;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthServiceProvider().currentUser!.uid)
        .collection("questions")
        .add(question.toJson());
  }
}