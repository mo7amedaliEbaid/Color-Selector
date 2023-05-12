import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/models/question_model.dart';
import 'package:todo_firestore/providers/selector_provider.dart';

Widget historyItem(Question question) {
  return Consumer<SelectorProvider>(builder: (context,data,_){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.circular(10)
        ),

        child:StatefulBuilder(builder: (context,setState){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,18,18,18),
                child: Text("Your Question Was...${question.query.toString()}",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19
                ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text("We Selected...${question.choice.toString()}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                    SizedBox(width: 70,),
                    Text("${data.convertDateTimeDisplay(question.createdAt.toString())}",style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              )
            ],
          );
        }),


      ),
    );
  });
    
}
