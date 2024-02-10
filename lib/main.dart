import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credentials.dart';
import 'process.dart';

var temp=[FlSpot(0, 0)];
Future<void> main() async {

  Process p = new Process();
  await p.getTreeData();
  await p.retreivePlantingLog("Murthwaite");
  temp = await p.getPlots();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: siteName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  LineChartData sampleData1() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 2001,
      maxX: 2500,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: temp
            
          ,
          isCurved: false,
          // colors: [Colors.blue],
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(siteName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          sampleData1(),
        ),
      ),
    );
  }
}
