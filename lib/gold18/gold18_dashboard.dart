import 'package:flutter/material.dart';

class Gold18Dashboard extends StatefulWidget {
  const Gold18Dashboard({super.key});
  @override
  State<Gold18Dashboard> createState() => _MyGold18Dashboard();
}

class _MyGold18Dashboard extends State<Gold18Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('كسر ١٨ ')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          onPressed: () {
            Navigator.pushNamed(context, 'addGold18');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
