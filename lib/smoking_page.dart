import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/models.dart';

class SmokingPage extends StatefulWidget {
  const SmokingPage({Key? key}) : super(key: key);

  @override
  State<SmokingPage> createState() => _SmokingPageState();
}

class _SmokingPageState extends State<SmokingPage> {

  late Database _database;
  String lastTime = "null";
  List<SmokeTime> tempList = [];

  @override
  void initState() {
    createDatabase();
    _setupDatabase();
    _getDatabase();
    super.initState();
  }

  Future<void> _setupDatabase() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), 'smokeTime.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE smokes(id INTEGER PRIMARY KEY, stringTime TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _getDatabase() async{
    tempList = await _accessDatabase();
    print("${tempList.first.stringTime}@@@@@@@@@@@");
  }

  Future<void> createDatabase() async{
    Future<void> insertTime(SmokeTime smokeTime) async{
      final Database db = _database;

      await db.insert(
        'smokes',
        smokeTime.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    final tempSmoke = SmokeTime(
        id: 0, stringTime: DateFormat('yy/MM/dd - HH:mm:ss').format(DateTime.now())
    );

    await insertTime(tempSmoke);
  }



  Future<List<SmokeTime>> _accessDatabase() async{
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('smokes');

    return List.generate(maps.length, (i){
      return SmokeTime(
        id: maps[i]['id'],
        stringTime: maps[i]['stringTime']
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smoking Time Page")
      ),
      body: Center(
        child: Text(tempList.isEmpty ? "nope" : tempList.first.stringTime),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

          _getDatabase();
          setState(() {});
        },
        label: const Text('Smoke!'),
        icon: const Icon(Icons.smoking_rooms_outlined),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
