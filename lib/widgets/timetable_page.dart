import 'package:flutter/material.dart';
import 'package:tmc_lab/models/time_table.dart';

class TimetablePage extends StatefulWidget {
  var info, times, bus;

  TimetablePage(this.info, this.bus, this.times);

  DateTime dateTime = DateTime.now();

  @override
  State<StatefulWidget> createState() => _TimetablePage();
}

class _TimetablePage extends State<TimetablePage> {
  List<SizedBox> _getTime(var times) {
    List<SizedBox> list = [];

    for (Timetable time in times) {
       if (compareTime(time.czas, widget.dateTime)) {
      list.add(SizedBox(
        width: 140,
        height: 120,
        child: TextButton(
          child: Text(
            '${time.czas}',
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          onPressed: () async {},
        ),
      ));
       }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,),
      body: Container(
          child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Center(
                  child: Material(
                        child: Text(
                          '${widget.info.nazwa_zespolu.toString().toUpperCase()} ${widget.info.slupek}: LINIA '
                          '${widget.bus}',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                ),
              ),

            ),
            flex: 1,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.horizontal,
                children: _getTime(widget.times),
              ),
            ),
            flex: 8,
          ),
        ],
      )),
    );
  }
}

bool compareTime(var time1, DateTime time2) {
  int hour1 = int.parse(time1.toString().substring(0, 2));
  int minutes1 = int.parse(time1.toString().substring(3, 5));

  return ((hour1 >= time2.hour && minutes1 >= time2.minute) ||
      (hour1 > time2.hour));
}
