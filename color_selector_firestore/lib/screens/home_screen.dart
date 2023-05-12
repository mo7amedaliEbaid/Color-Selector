import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/providers/selector_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/questionAndChoice_widget.dart';
import 'history_screen.dart';
class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _questionController = TextEditingController();
String? choice;
String? question;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Select For Me",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Icon(
                  Icons.history,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer2<SelectorProvider,AuthServiceProvider>(builder: (context, data,authdata, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Select Color",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 10),
                  child: Text(
                    "Which Color",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(
                        helperText: "Enter a Question",
                        helperStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2))),
                  ),
                ),
                InkWell(
                  onTap: ()  {
                    setState(() {
                      choice=data.getChoice();
                      question=_questionController.text.toString();
                    });
                    data.choiceOfQuestion(question??"Not yet", choice??"Not yet",
                       DateTime.now());
                    _questionController.clear();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: size.height * .05,
                    width: size.width * .2,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Ask",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                QuestionsAndChoice(
                  question??"not yet",choice??"not yet"
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 10),
                  child: Text(
                    "Free Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    "User Id !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "${authdata.currentUser!.uid}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }),
        ),
    );
  }
}
