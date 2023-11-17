import 'package:mongo_dart/mongo_dart.dart';
import 'credentials.dart';
  /*
    Bottom Layer
    Queries will be sent to mongoDB from this class
  */
class Store{

// String result="";

 Future<List<Map<String,dynamic>>> _connect(String q, database,coll) async{
  var db = await Db.create("$connection/$database");

  await db.open();

  var collection = await db.collection("$coll");

  List<Map<String,dynamic>> result = await collection.find().toList();
  await db.close();
  return result;
 }

Future<List<Map<String,dynamic>>> query(String q, database, coll) async{
  //string[] of queries?
  List<Map<String,dynamic>> result = await _connect(q, database, coll);
  return result;
}

Future<List<Map<String,dynamic>>> queryNonSpecified(database, coll) async{
  //string[] of queries?
  List<Map<String,dynamic>> result = await _connect("", database, coll);
  return result;
}

}