import 'dart:convert';

import 'package:http/http.dart';
import 'package:tmc_lab/models/bus.dart';
import 'package:tmc_lab/models/time_table.dart';

class ApiTimetable {
  static ApiTimetable I = ApiTimetable();

  static const String apiKey = "cf2be4bb-f716-4b02-a127-11003dd06008";

  Future<Response> invoke(var url) {
    return get(Uri.parse(url));
  }

  String getValue(List<Map<dynamic, dynamic>> entry, dynamic key) {
    return entry.firstWhere((element) => element["key"] == key)["value"];
  }


  Future<List<Timetable>> getTimetable(var Id, var Nr, var bus) async {

    var response = await invoke(
        "https://api.um.warszawa.pl/api/action/dbtimetable_get/?id=e923fa0e-d96c-43f9-ae6e-60518c9f3238&busstopId="+Id+"&busstopNr="+Nr+"&line="+bus+"&apikey="+
            apiKey);

    List<Timetable> timetables = [];

    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> tmp = json.decode(jsonEncode(data.values.first));
    for (var value in tmp) {
      final List<dynamic> tmpRow = json.decode(jsonEncode(
          (json.decode(jsonEncode(value)) as Map<dynamic, dynamic>)
              .values
              .first));
      List<Map<dynamic, dynamic>> entry = List.generate(
          tmpRow.length, (i) => json.decode(jsonEncode(tmpRow[i])));

      Timetable timetable = Timetable();

      timetable.czas=getValue(entry, "czas");
      timetable.kierunek = getValue(entry, "kierunek");
      timetable.brygada =getValue(entry, "brygada");
      timetable.trasa=getValue(entry, "trasa");
      timetables.add(timetable);


    }

    return timetables;
  }
}
