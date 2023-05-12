import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/providers/selector_provider.dart';
import 'package:todo_firestore/widgets/historyitem_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late SelectorProvider selectorProvider;

  @override
  void initState() {
    selectorProvider = Provider.of<SelectorProvider>(context, listen: false);
    selectorProvider.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Past Choices",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
        body: Consumer<SelectorProvider>(builder: (context, data, _) {
          return data.history.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 400,
                    height: 700,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.history.length,
                        itemBuilder: (context, index) {
                          return historyItem(data.history[index]);
                        }),
                  ),
              );
        }));
  }
}
