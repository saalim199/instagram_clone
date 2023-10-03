import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Resources/auth_methods.dart';
import 'package:instagram_clone/Widgets/TextfieldInput.dart';
import 'package:instagram_clone/utils/Routers.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/utils/snackBar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _name = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
    _username.dispose();
  }

  void setimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().Signupuser(
      username: _name.text,
      email: _username.text,
      password: _password.text,
      confirmpassword: _confirmpassword.text,
      bio: _bio.text,
      file: _image!,
    );
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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                // ignore: deprecated_member_use
                color: primaryColor,
              ),
              const SizedBox(
                height: 35,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage('assets/avatar.png'),
                        ),
                  Positioned(
                    bottom: -7,
                    right: 5,
                    child: IconButton(
                        onPressed: setimage,
                        icon: const Icon(Icons.add_a_photo)),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                textcontroller: _name,
                hinttext: "Username",
                keyboardtype: TextInputType.text,
                isPass: false,
              ),
              const SizedBox(
                height: 15,
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
              TextFieldInput(
                textcontroller: _confirmpassword,
                hinttext: "Confirm Password",
                keyboardtype: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                textcontroller: _bio,
                hinttext: "Bio",
                keyboardtype: TextInputType.text,
                isPass: false,
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: signupUser,
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
                          "SIgn up",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Registered?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginpage, (route) => false);
                      },
                      child: const Text(
                        "Log in.",
                        style: TextStyle(color: blueColor),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
