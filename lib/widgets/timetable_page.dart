import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmc_lab/models/bus.dart';
import 'package:tmc_lab/models/time_table.dart';

import 'package:tmc_lab/services/api_location.dart';

import 'package:tmc_lab/widgets/location_page.dart';
import 'package:http/http.dart' as http;

class TimetablePage extends StatefulWidget {
  var info, times, bus;

  TimetablePage(this.info, this.bus, this.times);

  @override
  State<StatefulWidget> createState() => _TimetablePage();
}

class _TimetablePage extends State<TimetablePage> {
  List<Container> _getTime(var times) {
    List<Container> list = [];

    for (Timetable time in times) {
      list.add(Container(
        width: 200,
        height: 40,
        child: TextButton(
          child: Text(
            '${time.czas}',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          onPressed: () async {
            //print(time.brygada);
            //List locations = await ApiLocation.I.getLocations(widget.bus, time.brygada);
//             var response = await http.post(Uri.parse("https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=%20f2e5503e-927d-4ad3-9500-4ab9e55deb59&apikey=cf2be4bb-f716-4b02-a127-11003dd06008&type=1&line=169&brigade=1"));
// print(response.body);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         LocationPage(locations, widget.bus, widget.info)));
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
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
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
                            Icons.arrow_back_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Material(
                      child: Text(
                        '${widget.info.nazwa_zespolu.toString().toUpperCase()} ${widget.info.slupek}: BUS NR.${widget.bus}',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            backgroundColor: Colors.cyan),
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
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  direction: Axis.vertical,
                  children: _getTime(widget.times),
                ),
              ),
              flex: 8,
            ),
          ],
        ));
  }
}
