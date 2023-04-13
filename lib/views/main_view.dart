import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tmc_lab/models/bus.dart';
import 'package:tmc_lab/models/station.dart';
import 'package:tmc_lab/models/time_table.dart';
import 'package:tmc_lab/services/api_service.dart';
import 'package:tmc_lab/widgets/buses_page.dart';
import 'package:tmc_lab/widgets/map_widget.dart';
import 'package:tmc_lab/widgets/search_widget.dart';

class MainView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Station>> stations = useState([]);
    ValueNotifier<Station?> station = useState(null);
    ValueNotifier<List<Bus>?> buses = useState(null);
    ValueNotifier<Bus?> bus = useState(null);
    useMemoized(() {
      ApiService.I.getStations().then((value) {
        stations.value = value;
        print('updated');
      });
    });

    var cntx = useContext();
    var controller = useState(MapController());
    print(bus);
    return stations.value.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              MapWidget(stations.value, controller.value, bus.value, (s) async {
                if (s == null) return;
                buses.value = null;
                station.value = s;
                ApiService.I
                    .getBuses(station.value!.zespol, station.value!.slupek)
                    .then((value) => buses.value = value);
              }),
              SearchWidget(stations.value, controller.value),
              Positioned(
                left: ((MediaQuery.of(context).size.width > 700)
                    ? MediaQuery.of(context).size.width - 400
                    : 0),
                child: station.value == null
                    ? Container()
                    : buses.value == null
                        ? CircularProgressIndicator()
                        : Container(
                            width: ((MediaQuery.of(context).size.width > 700)
                                ? 400
                                : MediaQuery.of(context).size.width),
                            height: 350,
                            child: BusesPage(buses.value, station.value, () {
                              buses.value = null;
                              station.value = null;
                            }, (Bus b, Timetable timetable) async {
                              await ApiService.I.updateLocation(b, timetable);
                              bus.value = Bus();
                              bus.value?.linia = b.linia;
                              bus.value?.szer_geo = b.szer_geo;
                              bus.value?.dlug_geo = b.dlug_geo;

                              if (b.dlug_geo != null && b.szer_geo != null) {
                                LatLng latlan = LatLng((bus.value!.szer_geo!),
                                    (bus.value!.dlug_geo!));
                                controller.value.move(latlan, 18);
                              }
                            }, () {
                              controller.value.move(
                                  LatLng(double.parse(station.value!.szer_geo!),
                                      double.parse(station.value!.dlug_geo!)),
                                  18);
                            }),
                          ),
              )
            ],
          );
  }
}
