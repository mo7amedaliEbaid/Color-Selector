// ignore_for_file: use_build_context_synchronously, avoid_print, avoid_web_libraries_in_flutter
import 'dart:developer';
import 'dart:typed_data';

import 'package:color_picker/db/firestore_methods.dart';
import 'package:color_picker/screens/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  FirestoreMethods _firestoreMethods = FirestoreMethods();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();

  bool isLoginScreen = true;
  bool isEditingEmail = false;
  bool isEditingPassword = false;
  bool isEditingUsername = false;
  bool isRegistering = false;
  bool isLoggingIn = false;
  bool passwordIsVisible = false;

  String? validateEmail(String value) {
    value = value.trim();
    if (_emailcontroller.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }
    return null;
  }

  String? validatePassword(String value) {
    value = value.trim();
    if (_passwordcontroller.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      } else if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }
    return null;
  }

  String? validateUsername(String value) {
    value = value.trim();
    if (_usernamecontroller.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Username can\'t be empty';
      } else if (value.length < 6) {
        return 'Username must be at least 6 characters';
      }
    }
    return null;
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  Uint8List? _imageURL;

  selectedImage() async {
    Uint8List imageURL = await pickImage(
      ImageSource.gallery,
    );
    setState(() {
      _imageURL = imageURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    _register() {}
    return Scaffold(
        body: Consumer<UserProvider>(builder: (context, authdata, _) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 12),
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(isLoginScreen ? "Login" : "Create your account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      isLoginScreen
                          ? "Welcome back to the color selector."
                          : "Create an account to access.",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      isLoginScreen
                          ? "Login in with email and password "
                          : "Register with email and password",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ],
                ),
                !isLoginScreen
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: InkWell(
                            onTap: () {
                              selectedImage();
                            },
                            child: _imageURL != null
                                ? CircleAvatar(
                                    key: UniqueKey(),
                                    backgroundImage: MemoryImage(
                                      _imageURL!,
                                    ),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.13),
                                    radius: 50,
                                  )
                                : CircleAvatar(
                                    key: UniqueKey(),
                                    backgroundColor: Colors.white,
                                    radius: 50,
                                  )),
                      )
                    : SizedBox.shrink(),
                const SizedBox(
                  height: 15,
                ),
                !isLoginScreen
                    ? TextField(
                        focusNode: usernameFocus,
                        controller: _usernamecontroller,
                        onChanged: (value) {
                          setState(() {
                            isEditingUsername = true;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "jdoe123",
                            errorText: isEditingUsername
                                ? validateUsername(_usernamecontroller.text)
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )
                    : const SizedBox(
                        height: 1,
                      ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  focusNode: emailFocus,
                  controller: _emailcontroller,
                  onChanged: (value) {
                    setState(() {
                      isEditingEmail = true;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "abc@domain.com",
                      errorText: isEditingEmail
                          ? validateEmail(_emailcontroller.text)
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  focusNode: passwordFocus,
                  controller: _passwordcontroller,
                  onChanged: (value) {
                    setState(() {
                      isEditingPassword = true;
                    });
                  },
                  obscureText: !passwordIsVisible,
                  decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordIsVisible = !passwordIsVisible;
                            });
                          },
                          child: Icon(
                              passwordIsVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.lightBlue),
                        ),
                      ),
                      labelText: "Password",
                      hintText: "123456",
                      errorText: isEditingPassword
                          ? validatePassword(_passwordcontroller.text)
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    if (!isLoginScreen) {
                      var result = await authdata.userSignup(
                          _emailcontroller.text,
                          _passwordcontroller.text);
                      if (result == true) {
                        _firestoreMethods.createUser(
                            file: _imageURL ?? Uint8List(0),
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            dateCreated: DateTime.now().toString(),
                            email: _emailcontroller.text.toString().trim(),
                            username:
                                _usernamecontroller.text.toString().trim());
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Root()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error has occured")));
                      }
                    } else {
                      log("is logging in");
                      var result = await authdata.userLogin(
                        _emailcontroller.text,
                        _passwordcontroller.text,
                      );
                      result == true
                          ? Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Root()))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error has occured")));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: isRegistering || isLoggingIn
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            isLoginScreen ? "Login" : "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: isLoginScreen
                        ? "Want to create your own account?   "
                        : "Already have an account?   ",
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  TextSpan(
                      text: isLoginScreen ? "Register! " : "Log In!",
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isLoginScreen = !isLoginScreen;
                          });
                        })
                ])),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
