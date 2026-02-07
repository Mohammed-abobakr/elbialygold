import 'package:elbialygold/money/money_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  final List<Widget> pages = [HomePage(), MoneyDashboard()];
  int currentIndex = 1;
  // Refresh Data
  Future<void> refreshDate() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.amberAccent),
          actions: [
            IconButton(
              onPressed: () async {},
              icon: Icon(Icons.settings, color: Colors.amberAccent),
            ),
          ],
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Image.asset('images/bg.png', width: 25),
              Text(
                "البيلي جولد",
                style: TextStyle(color: Colors.amberAccent, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          backgroundColor: Colors.black,
        ),

        drawer: Drawer(
          backgroundColor: Colors.amber,
          child: Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${FirebaseAuth.instance.currentUser!.photoURL}',
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "${FirebaseAuth.instance.currentUser!.displayName}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.home),
                          Text(
                            'الرئيسية',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.report),
                          Text(
                            'التقارير',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.monetization_on),
                          Text(
                            'النقدية',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, 'login');
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.logout),
                          Text(
                            'تسجيل الخروج',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshDate,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.dashboard, color: Colors.amberAccent),
                    Text("لوحة التحكم", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .9,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pushNamed(context, 'moneyDashboard');
                      },
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/money.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "نقدية",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pushNamed(context, 'gold21Dashboard');
                      },
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/wedding-rings.png',
                                width: 70,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "كسر ٢١",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pushNamed(context, 'gold18Dashboard');
                      },
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/wedding-rings.png',
                                width: 70,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "كسر ١٨",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pushNamed(context, "transferDashboard");
                      },
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/data-transfer.png',
                                width: 70,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "الحوالات",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Image.asset('images/pay.png', width: 70),
                              ),
                              SizedBox(height: 20),
                              FittedBox(
                                child: Text(
                                  "قطع",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/crucible.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "سبك",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/bag.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "طلبات العملاء",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/ingots.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "سبائك العملاء",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/pay.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "لنا",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/paymoney.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "علينا",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/box.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "إدارة المشغولات",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/jewelry.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "إدارة المسواق",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/customer-engagement.png',
                                width: 70,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "إدارة العملاء",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {},
                      child: Card(
                        color: Colors.amber,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/employee.png', width: 70),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "إدارة الموظفين",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
