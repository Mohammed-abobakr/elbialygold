import 'package:elbialygold/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class MoneyDashboard extends StatefulWidget {
  const MoneyDashboard({super.key});
  @override
  State<MoneyDashboard> createState() => _MyMoneyDashboard();
}

class _MyMoneyDashboard extends State<MoneyDashboard> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController note = TextEditingController();
  String? selectedValue;

  CollectionReference money = FirebaseFirestore.instance.collection('money');

  // Refresh Data
  Future<void> refreshDate() async {
    await Future.delayed(Duration(seconds: 3));
    getData();
  }

  // add
  Future<void> addMoney() async {
    await money.add({
      'amount': amount.text,
      'note': note.text,
      'history': dateController.text,
      'sort': selectedValue,
      'time': Timestamp.now(),
      'createdBy': await FirebaseAuth.instance.currentUser!.displayName,
      'userImage': await FirebaseAuth.instance.currentUser!.photoURL,
    });
  }

  // edit
  Future<void> editMoney(String docid) async {
    await money.doc(docid).update({
      'amount': amount.text,
      'note': note.text,
      'history': dateController.text,
      'sort': selectedValue,
    });
  }

  List<QueryDocumentSnapshot> moneyList = [];
  bool isLoading = true;
  Future<void> getData() async {
    setState(() => isLoading = true);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('money')
        .orderBy('time', descending: true)
        .get();
    setState(() {
      moneyList = querySnapshot.docs;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  int currentIndex = 0;
  final List<Widget> pages = [HomePage(), MoneyDashboard()];

  String formatTime(DateTime dateTime) {
    dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? 'ص' : 'م';

    // تحويل إلى 12 ساعة
    int hour12 = dateTime.hour % 12;
    if (hour12 == 0) hour12 = 12;

    return '$hour12:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('النقدية')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 10,
          onPressed: () {
            showDialog(
              fullscreenDialog: true,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    icon: Icon(Icons.money_off_rounded),
                    scrollable: true,
                    constraints: BoxConstraints(minWidth: 700),
                    title: Text("إضافة معاملة جديدة"),
                    content: Container(
                      alignment: Alignment.center,
                      child: Form(
                        key: formstate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 15,
                          children: [
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.handshake),
                                filled: true,
                                hintText: 'إختر نوع المعاملة',
                                fillColor: Colors.amberAccent,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              initialValue: selectedValue,
                              items: [
                                DropdownMenuItem(
                                  value: 'أجر عميل',
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text("اجر عملاء"),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'شراء كـ',
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text("شراء كسر"),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'قطع',
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text("قطع"),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'مصروفات',
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text("مصروفات"),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'واردة',
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text("نقدية واردة"),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "لا يمكن ترك هذا الحقل فارغ";
                                }
                                return null;
                              },
                              controller: amount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.attach_money),
                                hintText: 'المبلغ',
                                filled: true,
                                fillColor: const Color(0xFFFFD740),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),

                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "لا يمكن ترك هذا الحقل فارغ";
                                }
                                return null;
                              },
                              controller: note,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.note),
                                hintText: 'ملاحظة',
                                filled: true,
                                fillColor: Colors.amberAccent,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "لا يمكن ترك هذا الحقل فارغ";
                                }
                                return null;
                              },
                              controller: dateController,
                              readOnly: true, // مهم جدًا
                              decoration: InputDecoration(
                                fillColor: Colors.amberAccent,
                                filled: true,
                                hintText: 'اختر التاريخ',
                                prefixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  dateController.text =
                                      "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                }
                              },
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ), // Radius هنا
                                    ),
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      if (formstate.currentState!.validate()) {
                                        addMoney();
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isLoading = true;
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "تمت إضافة المعاملة بنجاح",
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        });
                                        await getData();
                                        amount.text = '';
                                        dateController.text = '';
                                        selectedValue = null;
                                      }
                                    },
                                    child: Text(
                                      "حفظ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ), // Radius هنا
                                    ),
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      note.text = '';
                                      amount.text = '';
                                      dateController.text = '';
                                      selectedValue = null;
                                      Navigator.of(context).pop();
                                    },

                                    child: Text(
                                      "إلغاء",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: refreshDate,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: ListView.builder(
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color:
                                moneyList[index]['sort'] == 'مصروفات' ||
                                    moneyList[index]['sort'] == 'شراء كـ'
                                ? Colors.red
                                : Colors.amberAccent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        selectedValue =
                                            moneyList[index]['sort'];
                                        amount.text =
                                            moneyList[index]['amount'];
                                        note.text = moneyList[index]['note'];
                                        dateController.text =
                                            moneyList[index]['history'];
                                        showDialog(
                                          fullscreenDialog: true,
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) {
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AlertDialog(
                                                icon: Icon(
                                                  Icons.money_off_rounded,
                                                ),
                                                scrollable: true,
                                                constraints: BoxConstraints(
                                                  minWidth: 700,
                                                ),
                                                title: Text(
                                                  "إضافة معاملة جديدة",
                                                ),
                                                content: Container(
                                                  alignment: Alignment.center,
                                                  child: Form(
                                                    key: formstate,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      spacing: 15,
                                                      children: [
                                                        DropdownButtonFormField(
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'هذا الحقل مطلوب';
                                                            }
                                                            return null;
                                                          },
                                                          decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.handshake,
                                                            ),
                                                            filled: true,
                                                            hintText:
                                                                'إختر نوع المعاملة',
                                                            fillColor: Colors
                                                                .amberAccent,
                                                            border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    100,
                                                                  ),
                                                            ),
                                                          ),
                                                          initialValue:
                                                              selectedValue,
                                                          items: [
                                                            DropdownMenuItem(
                                                              value: 'أجر عميل',
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  "اجر عملاء",
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 'شراء كـ',
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  "شراء كسر",
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 'قطع',
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  "قطع",
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 'مصروفات',
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  "مصروفات",
                                                                ),
                                                              ),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 'واردة',
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  "نقدية واردة",
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedValue =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                        TextFormField(
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return "لا يمكن ترك هذا الحقل فارغ";
                                                            }
                                                            return null;
                                                          },
                                                          controller: amount,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons
                                                                  .attach_money,
                                                            ),
                                                            hintText: 'المبلغ',
                                                            filled: true,
                                                            fillColor:
                                                                const Color(
                                                                  0xFFFFD740,
                                                                ),
                                                            border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    100,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),

                                                        TextFormField(
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return "لا يمكن ترك هذا الحقل فارغ";
                                                            }
                                                            return null;
                                                          },
                                                          controller: note,
                                                          decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.note,
                                                            ),
                                                            hintText: 'ملاحظة',
                                                            filled: true,
                                                            fillColor: Colors
                                                                .amberAccent,
                                                            border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    100,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return "لا يمكن ترك هذا الحقل فارغ";
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              dateController,
                                                          readOnly:
                                                              true, // مهم جدًا
                                                          decoration: InputDecoration(
                                                            fillColor: Colors
                                                                .amberAccent,
                                                            filled: true,
                                                            hintText:
                                                                'اختر التاريخ',
                                                            prefixIcon: Icon(
                                                              Icons
                                                                  .calendar_today,
                                                            ),
                                                            border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    100,
                                                                  ),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            DateTime?
                                                            pickedDate =
                                                                await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime.now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                        2000,
                                                                      ),
                                                                  lastDate:
                                                                      DateTime(
                                                                        2100,
                                                                      ),
                                                                );

                                                            if (pickedDate !=
                                                                null) {
                                                              dateController
                                                                      .text =
                                                                  "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                                            }
                                                          },
                                                        ),
                                                        Row(
                                                          spacing: 10,
                                                          children: [
                                                            Expanded(
                                                              child: MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        50,
                                                                      ), // Radius هنا
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed: () async {
                                                                  if (formstate
                                                                      .currentState!
                                                                      .validate()) {
                                                                    editMoney(
                                                                      moneyList[index]
                                                                          .id,
                                                                    );
                                                                    Navigator.of(
                                                                      context,
                                                                    ).pop();
                                                                    setState(() {
                                                                      isLoading =
                                                                          true;
                                                                      getData();
                                                                      ScaffoldMessenger.of(
                                                                        context,
                                                                      ).showSnackBar(
                                                                        const SnackBar(
                                                                          content: Text(
                                                                            "تم تعديل المعاملة بنجاح",
                                                                          ),
                                                                          backgroundColor:
                                                                              Colors.green,
                                                                        ),
                                                                      );
                                                                    });
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "حفظ",
                                                                  style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        50,
                                                                      ), // Radius هنا
                                                                ),
                                                                color: Colors
                                                                    .black,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed: () {
                                                                  note.text =
                                                                      '';
                                                                  amount.text =
                                                                      '';
                                                                  dateController
                                                                          .text =
                                                                      '';
                                                                  selectedValue =
                                                                      null;
                                                                  Navigator.of(
                                                                    context,
                                                                  ).pop();
                                                                },

                                                                child: Text(
                                                                  "إلغاء",
                                                                  style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      if (value == 'delete') {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.scale,
                                          title: 'حذف المعاملة',
                                          desc:
                                              'هل انت متأكد من حذف هذه المعاملة؟',
                                          btnOkOnPress: () async {
                                            await FirebaseFirestore.instance
                                                .collection('money')
                                                .doc(moneyList[index].id)
                                                .delete();
                                            // عرض رسالة نجاح
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text('تم الحذف بنجاح'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            await getData();
                                          },
                                          btnCancelOnPress: () {},
                                          btnOkText: 'نعم',
                                          btnCancelText: 'إلغاء',
                                        ).show();
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              Icon(Icons.edit),
                                              Text("تعديل"),
                                            ],
                                          ),
                                        ),
                                        value: 'edit',
                                      ),
                                      PopupMenuItem(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              Icon(Icons.delete),
                                              Text("حذف"),
                                            ],
                                          ),
                                        ),
                                        value: 'delete',
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${moneyList[index]['note']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            moneyList[index]['sort'] ==
                                                    'مصروفات' ||
                                                moneyList[index]['sort'] ==
                                                    'شراء كـ'
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${moneyList[index]['amount']} ج.م",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            moneyList[index]['sort'] ==
                                                    'مصروفات' ||
                                                moneyList[index]['sort'] ==
                                                    'شراء كـ'
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${moneyList[index]['sort']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              moneyList[index]['sort'] ==
                                                      'مصروفات' ||
                                                  moneyList[index]['sort'] ==
                                                      'شراء كـ'
                                              ? Colors.red
                                              : Colors.amber,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 1,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // الاسم مع أيقونة
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${moneyList[index]['userImage']!}",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        moneyList[index]['createdBy']!,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "${moneyList[index]['history']}",
                                    style: TextStyle(
                                      color:
                                          moneyList[index]['sort'] ==
                                                  'مصروفات' ||
                                              moneyList[index]['sort'] ==
                                                  'شراء كـ'
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  // الوقت مع أيقونة
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 16,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${formatTime(moneyList[index]['time'].toDate())}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: moneyList.length,
                  ),
                ),
              ),
      ),
    );
  }
}
