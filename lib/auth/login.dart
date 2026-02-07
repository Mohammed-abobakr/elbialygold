import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _MyLogin();
}

class _MyLogin extends State<Login> {
  Future signInWithGoogle() async {
    setState(() => loading = true);
    GoogleSignIn.instance.initialize(
      serverClientId:
          '1063895312468-545h2e2f4adb49s8c9cu93npnfq9cog2.apps.googleusercontent.com',
    );
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();
    if (googleUser == null) {
      setState(() => loading = false);
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacementNamed(context, 'homescreen');
  }

  bool loading = false;
  @override
  Widget build(BuildContext contex) {
    return Center(
      child: loading
          ? CircularProgressIndicator()
          : Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  body: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Image.asset("images/bg.png", width: 100),
                              Text(
                                "البيلي جولد",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'للمشغولات الذهبية',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: Colors.amber,
                          onPressed: () {
                            signInWithGoogle();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("images/google.png", width: 30),
                              Text(
                                "تسجيل الدخول بحساب جوجل",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
