import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:tmc_lab/models/station.dart';
import 'package:tmc_lab/services/api_service.dart';
import 'package:tmc_lab/widgets/map_widget.dart';
import 'package:tmc_lab/widgets/search_widget.dart';

class MainView extends HookWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Station>> stations = useState([]);

    useMemoized(() {
      ApiService.I.getStations().then((value) {
        stations.value = value;
        print('updated');
      });
    });
    var controller = useState(MapController());
    return stations.value.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              MapWidget(stations.value, controller.value),
              SearchWidget(stations.value, controller.value)
            ],
          );
  }
}
