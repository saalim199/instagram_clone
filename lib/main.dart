import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/Routers.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/utils/globalvariables.dart';
import 'package:instagram_clone/views/LoginPage.dart';
import 'package:instagram_clone/views/SignUpPage.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Userprovider(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const MyHomePage();
            } else if (snapshot.hasError) {
              return Text((snapshot.error).toString());
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginPage();
        },
      ),
      routes: {
        homepage: (context) => const MyHomePage(),
        signuppage: (context) => const SignUpPage(),
        loginpage: (context) => const LoginPage(),
      },
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  addData() async {
    Userprovider userprovider = Provider.of(context, listen: false);
    await userprovider.refreshUser();
  }

  void navigationTapped(value) {
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<Userprovider>(context).getUser;
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _page = value;
          });
        },
        children: homeitems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        activeColor: primaryColor,
        currentIndex: _page,
        onTap: (value) => navigationTapped(value),
      ),
    );
  }
}
