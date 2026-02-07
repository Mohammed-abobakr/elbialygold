import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _TotalMoneyPageState();
}

class _TotalMoneyPageState extends State<Report> {
  double totalCash = 0;
  double gold21 = 0;
  double gold18 = 0;
  double transfer = 0;
  bool loading = true;

  Future<void> calculateTotal() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('money')
        .get();

    double tempTotal = 0; // متغير مؤقت للحساب

    // Future<void> claculateGold21() async {
    //   QuerySnapshot snapshot = await FirebaseFirestore.instance
    //       .collection('gold21')
    //       .get();
    // }

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      int amount = int.tryParse(data['amount'].toString()) ?? 0;
      String sort = data['sort'] ?? '';

      if (sort == 'شراء كـ' || sort == 'مصروفات') {
        tempTotal -= amount;
      } else {
        tempTotal += amount;
      }
    }
    setState(() {
      totalCash = tempTotal;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    calculateTotal();
    // calculateGold21();
    // calculateGold();
  }

  Future<void> refreshData() async {
    setState(() {
      loading = true;
    });
    await calculateTotal(); // إعادة الحساب
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('التقارير')),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    // البطاقة الرئيسية
                    Container(
                      padding: const EdgeInsets.all(30),
                      margin: EdgeInsets.all(20),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'إجمالي النقدية الحالية',
                            style: TextStyle(color: Colors.amber, fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${totalCash} جنيه', // ✅ عرض منزلتين عشريتين
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.amber,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            'إجمالي كسر 21',
                            style: TextStyle(color: Colors.amber, fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${0} جرام', // ✅ عرض منزلتين عشريتين
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.amber,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            'إجمالي كسر 18',
                            style: TextStyle(color: Colors.amber, fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${0} جرام', // ✅ عرض منزلتين عشريتين
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.amber,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            'إجمالي الحولات',
                            style: TextStyle(color: Colors.amber, fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${0} جرام', // ✅ عرض منزلتين عشريتين
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
