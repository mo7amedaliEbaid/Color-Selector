import 'package:flutter/material.dart';
import 'package:todo_firestore/extensions/string_extenstion.dart';
Widget QuestionsAndChoice(String query,String choice) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: Column(
      children: [
        Text(
          "Which of ${query}?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "We Choosed ${choice.capitalize()}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19,color: Colors.amber),
          ),
        )
      ],
    ),
  );
}