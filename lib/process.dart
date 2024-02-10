import 'dart:ffi';

import 'store.dart';
import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';

/*
    Middle Layer
    Calculations will be performed in this class
*/

class Process {
  Store store = new Store();
  List<Map<String, dynamic>> plantingLogs = [];
  List<Map<String, dynamic>> carbonSequestration = [];
  Map<int, dynamic> years= new Map<int,dynamic>();
  Future<void> getTreeData() async {
    carbonSequestration =
        await store.query("", "Dewar_Rewilding", "Tree_Sequestration");
  }

  // Queries database for the planting log for the for a given site
  Future<void> retreivePlantingLog(String site) async {
    plantingLogs = await store.query("", "Dewar_Rewilding", site);
  }

// WIP
// Work out the amount of yearly carbon sequestered at different points in tree's lifespan
  Future<void> calculatePlots() async {
    int start=_startDate();
    int now = new DateTime.now().year;
    int carbonIncrease;
    for(int i=start, j=0;i<now;i++, j++){
      carbonIncrease=1;
      years[i]=carbonIncrease;
    }
  }

  int _startDate() {
    int min = 0x20000000000000;
    for (int i = 0; i < plantingLogs.length; i++) {
      if (plantingLogs[i]["year"] < min) min = plantingLogs[i]["year"];
    }
 
    return min;
  }

  // get the total tonnage of carbon sequestered until today
  Future<List<FlSpot>> getPlots() async 
  {
    
    calculatePlots();
    int runningCount=0;
    List<FlSpot> plots = [FlSpot(_startDate().toDouble(), 0)];
    // loop for planing log

    //append list for each iteration
    for (int i = _startDate()+1; i < DateTime.now().year; i++) {
      plots.add(FlSpot(i.toDouble(), years[i].toDouble()));
    }
    // return list
    return plots;
  }
}
