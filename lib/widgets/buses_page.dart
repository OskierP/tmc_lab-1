import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tmc_lab/models/bus.dart';
import 'package:tmc_lab/models/time_table.dart';

import 'package:tmc_lab/services/api_service.dart';

import 'package:tmc_lab/widgets/timetable_page.dart';

class BusesPage extends StatefulWidget {
  var busstopId, busstopNr;
  var buses;
  var info;

  BusesPage(this.busstopId, this.busstopNr, this.buses, this.info);

  @override
  State<StatefulWidget> createState() => _BusesPage();
}

class _BusesPage extends State<BusesPage> {
  List<Container> _getBuses(var busId, var busNr, var buses) {
    List<Container> list = [];
    for (Bus bus in buses) {
      list.add(Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: TextButton(
          child: Text(
            bus.linia,
            style: TextStyle(fontSize: 35, color: Colors.black),
          ),
          onPressed: () async {
            List timetables = await ApiService.I
                .getTimetable(widget.busstopId, widget.busstopNr, bus.linia);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TimetablePage(widget.info, bus.linia, timetables)));
          },
        ),
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.cyan),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Material(
                      child: Text(
                        '${widget.info.nazwa_zespolu.toString().toUpperCase()} ${widget.info.slupek}',
                        style: TextStyle(fontSize: 35, color: Colors.white,backgroundColor: Colors.cyan),
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
              flex: 1,
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: _getBuses(
                      widget.busstopId, widget.busstopNr, widget.buses),
                ),
              ),
              flex: 8,
            ),
          ],
        ));
  }
}
