class Question {
  String? query;
  String? choice;
  DateTime? createdAt;

  Question();

  Map<String, dynamic> toJson() => {
        "query": query,
        "choice": choice,
        "createdAt": createdAt,
      };

  Question.fromSnapshot(snapShot)
      : query = snapShot.data()["query"],
        choice = snapShot.data()["choice"],
        createdAt = snapShot.data()["createdAt"].toDate();
}
