import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tmc_lab/models/bus.dart';
import 'package:tmc_lab/models/time_table.dart';
import 'package:tmc_lab/services/api_buses.dart';
import 'package:tmc_lab/services/api_timetable.dart';

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
            time.czas,
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          onPressed: () {},
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
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Material(
                    child: Text(
                      '${widget.info.nazwa_zespolu} ${widget.info.slupek} : bus nr. ${widget.bus}',
                      style: TextStyle(fontSize: 35, color: Colors.indigo),
                    ),
                  ),
                  Container()
                ],
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
