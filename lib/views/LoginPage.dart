import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/Resources/auth_methods.dart';
import 'package:instagram_clone/Widgets/TextfieldInput.dart';
import 'package:instagram_clone/utils/Routers.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/snackBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
    _username.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .LoginUser(email: _username.text, password: _password.text);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(homepage, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            SvgPicture.asset(
              "assets/ic_instagram.svg",
              // ignore: deprecated_member_use
              color: primaryColor,
            ),
            const SizedBox(
              height: 45,
            ),
            TextFieldInput(
              textcontroller: _username,
              hinttext: "Email",
              keyboardtype: TextInputType.emailAddress,
              isPass: false,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
              textcontroller: _password,
              hinttext: "Password",
              keyboardtype: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : const Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not Registered yet?"),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          signuppage, (route) => false);
                    },
                    child: const Text(
                      "Sign Up.",
                      style: TextStyle(color: blueColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
