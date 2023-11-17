import 'store.dart';
import 'dart:convert';
import 'dart:io';
/*
    Middle Layer
    Calculations will be performed in this class
*/
Future<void> main() async{
  Process p = new Process();
  await p.retreivePlantingLog("Murthwaite");
}
class Process {
  Store store = new Store();
  Future<void> getTreeData() async {
    List<Map<String,dynamic>> result = await store.query("", "Dewar_Rewilding", "Tree_Sequestration");
  
  }

  Future<void> retreivePlantingLog(String site) async {
    plantingLogs = await store.queryNonSpecified("Dewar_Rewilding",site);
    // var test = log.toString();
    // print(log)111;
  }

  List<Map<String, dynamic>> plantingLogs= []; 
  
}
