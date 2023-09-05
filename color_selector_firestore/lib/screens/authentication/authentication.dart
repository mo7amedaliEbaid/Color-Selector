// ignore_for_file: use_build_context_synchronously, avoid_print, avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:color_picker/screens/root.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../custom_auth.dart';


class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

TextEditingController _emailcontroller=TextEditingController();
TextEditingController _usernamecontroller=TextEditingController();
TextEditingController _passwordcontroller=TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    height:50,
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
                        ? "If you do not want to create an account "
                        : "You can use fake information",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
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
                              ? validateUsername(
                                  _usernamecontroller.text)
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
                            color: Colors.lightBlue                        ),
                      ),
                    ),
                    labelText: "Password",
                    hintText: "123456",
                    errorText: isEditingPassword
                        ? validatePassword(
                           _passwordcontroller.text)
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
                  var result = await userSignup(
                      _usernamecontroller.text,
                      _emailcontroller.text,
                      _passwordcontroller.text);
                  result==true?Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Root())):
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error has occured")));
                },
                child: Container(
                  decoration: BoxDecoration(
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
                ),
                TextSpan(
                    text: isLoginScreen ? "Register! " : "Log In!",
                    style: TextStyle(color: Colors.white),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isLoginScreen = !isLoginScreen;
                        });
                      })
              ])),
              const SizedBox(
                height: 15,
              ),
              isLoginScreen
                  ? const Center(
                      child: Text(
                      "-   Or   -",
                      style: TextStyle(color: Colors.grey),
                    ))
                  : const SizedBox(
                      height: 1,
                    ),
              const SizedBox(
                height: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }
}


