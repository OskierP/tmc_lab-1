import 'dart:convert';

import 'package:http/http.dart';
import 'package:tmc_lab/models/bus.dart';

class ApiBuses {
  static ApiBuses I = ApiBuses();

  static const String apiKey = "cf2be4bb-f716-4b02-a127-11003dd06008";

  Future<Response> invoke(var url) {
    return get(Uri.parse(url));
  }

  String getValue(List<Map<dynamic, dynamic>> entry, dynamic key) {
    return entry.firstWhere((element) => element["key"] == key)["value"];
  }

  List<Bus>? cache;
  Future<List<Bus>> getBuses(var Id, var Nr) async {
    if (cache != null) {
      return cache!;
    }

    var response = await invoke(
        "https://api.um.warszawa.pl/api/action/dbtimetable_get/?id=88cd555f-6f31-43ca-9de4-66c479ad5942&busstopId="+Id+"&busstopNr="+Nr+"&apikey=" +
            apiKey);

    List<Bus> buses = [];

    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> tmp = json.decode(jsonEncode(data.values.first));
    for (var value in tmp) {
      final List<dynamic> tmpRow = json.decode(jsonEncode(
          (json.decode(jsonEncode(value)) as Map<dynamic, dynamic>)
              .values
              .first));
      List<Map<dynamic, dynamic>> entry = List.generate(
          tmpRow.length, (i) => json.decode(jsonEncode(tmpRow[i])));

      Bus bus = Bus();

      bus.linia=getValue(entry, "linia");
      buses.add(bus);
      //print(bus.lina);

    }
  //cache = buses;
    return buses;
  }
}
