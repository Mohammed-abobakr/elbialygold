import 'package:flutter/material.dart';

class AddGold18 extends StatefulWidget {
  const AddGold18({super.key});
  @override
  State<AddGold18> createState() => _MyAddGold18();
}

class _MyAddGold18 extends State<AddGold18> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(appBar: AppBar(title: Text('إضافة كـــ١٨ جديد'))),
    );
  }
}
