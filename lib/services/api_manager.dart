import 'package:contestalert/constants.dart';
import 'package:contestalert/models/allcontestData.dart';
import 'package:contestalert/models/contestData.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class APIManager {
  final bool allContest;
  final String ContestUrl;

  APIManager(this.allContest, this.ContestUrl);
  Future<List> getDataAsList() async {
    var client = http.Client();

    List contestDataAsList = [];

    try {
      var response = await client.get(Uri.parse(ContestUrl));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        if (allContest == true) {
          contestDataAsList =
              jsonMap.map((model) => AllContestData.fromJson(model)).toList();
        } else {
          contestDataAsList =
              jsonMap.map((model) => ContestData.fromJson(model)).toList();
        }

        return contestDataAsList;
      }
    } catch (Exception) {
      print(Exception.toString());
    }

    return contestDataAsList;
  }
}
