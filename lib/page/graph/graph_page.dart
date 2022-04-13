import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/graphps.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF3a73b5),

          title: Text("ความดันโลหิตของฉัน"),
          //title: AppBarTitle(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlLineChartExample(),
        ),
      ),
    );
  }
}
