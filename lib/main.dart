import 'package:flutter/material.dart';
import 'package:tmc_lab/views/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ApiService.I.getStations().then((value) {
    //   for (var value1 in value) {
    //     print(value1.nazwa_zespolu + " " + value1.slupek + " ");
    //   }
    //   print(value.length);
    // });

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.blueAccent,),body: MainView());
  }
}
