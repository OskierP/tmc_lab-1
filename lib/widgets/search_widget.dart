import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:search_page/search_page.dart';
import 'package:tmc_lab/models/station.dart';

class SearchWidget extends StatelessWidget {
  List<Station> stations;
  MapController controller;

  SearchWidget(this.stations, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.search),
        tooltip: 'Szukaj Przystanków',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Station>(
            items: stations,
            searchLabel: 'Szukaj przystanków',
            suggestion: Center(
              child: Text('Filtruj przystanki'),
            ),
            failure: Center(
              child: Text('Nie znaleziono odpowiedniego przystanku :('),
            ),
            filter: (station) => [station.nazwa_zespolu],
            builder: (station) => ListTile(
              title: Text(station.nazwa_zespolu),
              onTap: () {
                Navigator.pop(context);
                controller.move(
                    LatLng(double.parse(station.szer_geo),
                        double.parse(station.dlug_geo)),
                    18);
              },
              subtitle: Text(station.slupek),
              trailing: Text('Nastepny przystanek: ${station.kierunek}'),
            ),
          ),
        ),
      ),
    );
  }
}
