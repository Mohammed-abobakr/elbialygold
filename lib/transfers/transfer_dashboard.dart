import 'package:flutter/material.dart';

class TransferDashboard extends StatefulWidget {
  const TransferDashboard({super.key});
  @override
  State<TransferDashboard> createState() => _MyTransferDashboard();
}

class _MyTransferDashboard extends State<TransferDashboard> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('الحوالات')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          onPressed: () {
            Navigator.pushNamed(context, 'addTransfer');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
