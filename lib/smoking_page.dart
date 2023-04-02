import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SmokingPage extends StatefulWidget {
  const SmokingPage({Key? key}) : super(key: key);

  @override
  State<SmokingPage> createState() => _SmokingPageState();
}

class _SmokingPageState extends State<SmokingPage> {

  String getTime(){
    var now = DateTime.now();
    String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(now);
    return formatDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smoking Time Page")
      ),
      body: Center(
        child: Text(getTime()),
      )
    );
  }
}
