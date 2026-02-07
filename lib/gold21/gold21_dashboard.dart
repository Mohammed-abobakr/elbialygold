import 'package:flutter/material.dart';

class Gold21Dashboard extends StatefulWidget {
  const Gold21Dashboard({super.key});
  @override
  State<Gold21Dashboard> createState() => _MyGold21Dashboard();
}

class _MyGold21Dashboard extends State<Gold21Dashboard> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool laoding = false;
  Future<void> refreshData() async {
    setState(() {
      laoding = true;
    });
    // await getData;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('كسر ٢١ ')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          onPressed: () {
            showDialog(
              fullscreenDialog: true,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: Text('إضافة  كسر ٢١'),
                    icon: Icon(Icons.add),
                    content: Container(
                      child: Form(
                        key: formState,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [TextFormField(), TextFormField()],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: RefreshIndicator(
          child: Center(
            child: laoding
                ? CircularProgressIndicator()
                : ListView(children: [Text("لا توجد بيانات")]),
          ),
          onRefresh: refreshData,
        ),
      ),
    );
  }
}
