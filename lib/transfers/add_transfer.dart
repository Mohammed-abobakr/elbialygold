import 'package:flutter/material.dart';

class AddTransfer extends StatefulWidget {
  const AddTransfer({super.key});
  @override
  State<AddTransfer> createState() => _MyAddTransfer();
}

class _MyAddTransfer extends State<AddTransfer> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(appBar: AppBar(title: Text('إضافة حوالة جديدة'))),
    );
  }
}
