import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/log_in/premium_popup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home/home_page.dart';
import 'log_in/phone_auth_page.dart';
import 'services/auth_service.dart';
import '../constants.dart';
import 'log_in/welcome.dart';
import 'premium/new_premium_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();

  checkLogin() async {
    String? tokne = await authClass.getPhone();
    String? uid = await authClass.getUid();
    String? userName1 = await authClass.getName();
    String? skip = await storage.read(key: "skip");
    if (skip == 'true') {
      setState(() {
        skipped = true;
      });
    }
    if (tokne != null) {
      setState(() {
        userLogedIn = true;
        number = tokne;
        userUid = uid;
        userName = userName1!;
      });
      try {
        var tokenP = await FirebaseFirestore.instance
            .collection('NewPremiumData')
            .doc(userUid)
            .get();
        if (tokenP.exists) {
          premiumUser = true;
        }
      } catch (e) {
        log(e.toString());
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facelift Constructions',
      home: userLogedIn
          ? premiumUser
              ? const HomePage()
              : skipped
                  ? const HomePage()
                  : const NewPrimiumUserPop()
          : const WelcomeScreen(),
    );
  }
}

class HomeNotLoggedInScreen extends StatefulWidget {
  const HomeNotLoggedInScreen({Key? key}) : super(key: key);

  @override
  State<HomeNotLoggedInScreen> createState() => _HomeNotLoggedInScreenState();
}

class _HomeNotLoggedInScreenState extends State<HomeNotLoggedInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: const HomeScreen(logedIn: false),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: size.width * 0.225),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.black,
                // selectedFontSize: 1,
                // unselectedFontSize: 1,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: pinkColor,
                currentIndex: iindex,
                onTap: (val) {
                  setState(() {
                    val != 1
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneAuthScreen()))
                        : iindex = val;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.whatshot),
                    label: "",
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: screens[iindex],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 24, horizontal: size.width * 0.225),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.black,
            showSelectedLabels: true,
            selectedLabelStyle:
                const TextStyle(color: Colors.black, fontSize: 10),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            showUnselectedLabels: false,
            backgroundColor: pinkColor,
            currentIndex: iindex,
            onTap: (val) {
              setState(() {
                val == 2
                    ? premiumUser
                        ? iindex = val
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NewPrimiumUserScreen()))
                    : iindex = val;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.architecture),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "My Home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
