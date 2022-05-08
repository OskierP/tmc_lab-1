import 'dart:convert';

import 'package:http/http.dart';
import 'package:tmc_lab/models/station.dart';

class ApiService {
  static ApiService I = ApiService();

  static const String apiKey = "cf2be4bb-f716-4b02-a127-11003dd06008";

  Future<Response> invoke(var url) {
    return get(Uri.parse(url));
  }

  String getValue(List<Map<dynamic, dynamic>> entry, dynamic key) {
    return entry.firstWhere((element) => element["key"] == key)["value"];
  }

  List<Station>? cache;
  Future<List<Station>> getStations() async {
    if (cache != null) {
      return cache!;
    }
    var response = await invoke(
        "https://api.um.warszawa.pl/api/action/dbstore_get/?id=ab75c33d-3a26-4342-b36a-6e5fef0a3ac3&apikey=" +
            apiKey);

    List<Station> stations = [];

    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> tmp = json.decode(jsonEncode(data.values.first));
    for (var value in tmp) {
      final List<dynamic> tmpRow = json.decode(jsonEncode(
          (json.decode(jsonEncode(value)) as Map<dynamic, dynamic>)
              .values
              .first));
      List<Map<dynamic, dynamic>> entry = List.generate(
          tmpRow.length, (i) => json.decode(jsonEncode(tmpRow[i])));

      Station station = Station();

      station.dlug_geo = getValue(entry, "dlug_geo");
      station.id_ulicy = getValue(entry, "id_ulicy");
      station.kierunek = getValue(entry, "kierunek");
      station.nazwa_zespolu = getValue(entry, "nazwa_zespolu");
      station.obowiazuje_od = getValue(entry, "obowiazuje_od");
      station.slupek = getValue(entry, "slupek");
      station.szer_geo = getValue(entry, "szer_geo");
      station.zespol = getValue(entry, "zespol");
      stations.add(station);
    }
    cache = stations;
    return stations;
  }
}
