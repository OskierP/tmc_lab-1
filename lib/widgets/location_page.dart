import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tmc_lab/models/bus.dart';
import 'package:tmc_lab/models/time_table.dart';

import 'package:tmc_lab/models/location.dart';
import 'package:tmc_lab/widgets/timetable_page.dart';

class LocationPage extends StatefulWidget {
  var location;
  var busName,info;

  LocationPage(this.location, this.busName, this.info);

  @override
  State<StatefulWidget> createState() => _LocationPage();
}

class _LocationPage extends State<LocationPage> {
  List<Container> _getLocation(var locations) {
    List<Container> list = [];
    for (Location location in locations) {
      list.add(Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: TextButton(
          child: Text(
            'Lat: ${location.Lat}  Lon:${location.Lon}',//location,
            style: TextStyle(fontSize: 35, color: Colors.black),
          ),
          onPressed: () {
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
                        '${widget.info.nazwa_zespolu.toString().toUpperCase()} ${widget.info.slupek}: LOCATION OF BUS NR.${widget.busName}',
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
                  children: _getLocation(
                      widget.location),
                ),
              ),
              flex: 8,
            ),
          ],
        ));
  }
}
