import 'package:flutter/material.dart';
import 'package:hairsalon_application/Screens/dashboard_Screen.dart';
import 'package:hairsalon_application/Screens/signup_screen.dart';

import '../Services/auth.dart';
import '../Widgets/RoundedButton.dart';
import '../Widgets/TextInput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthService auth = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var kEmailValidationRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}';
  var kPasswordValidationRegex = '^[a-zA-Z0-9@_-]{7}';

  bool _isObscure = true;

  var _emailFormKey = GlobalKey<FormState>();

  //login function
  void login() async {
    if(_emailFormKey.currentState!.validate()){
      dynamic result = await auth.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim(),true);
      if (result == null) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'No such account found',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        SnackBar snackBar = SnackBar(
          content: Text(
            'Login Successfull',
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 2),

        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).popAndPushNamed(DashBoardScreen.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // for image
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo_final_final.png', height: 120, width: 120,),
                      Text('HairSim', style: TextStyle(
                          fontSize: 46.0,
                          color: Colors.white),)
                    ],
                  )
                ),

                // for login form
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      color: Color(0xfffafafa),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 35,
                            spreadRadius: 1),
                      ],
                    ),
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                         // Email & Password
                          Container(
                            margin: EdgeInsets.only(bottom: 15.0, top: 15.0),
                            child: Form(
                              autovalidateMode: AutovalidateMode.always,
                              key: _emailFormKey,
                              child: Column(
                                children: [

                                  // email input
                                  TextInput(
                                    hintText: 'abc@mail.com',
                                    labelText: 'Email',
                                    textInputType: TextInputType.emailAddress,
                                    validatorFunction: (String str) {
                                      if (str.isEmpty) {
                                        return 'This field cannot be empty.';
                                      }else if (!RegExp(kEmailValidationRegex, caseSensitive: false).hasMatch(str)){
                                        return 'Invalid Email';
                                      }
                                      return null;
                                    },
                                    isPassword: false,
                                    textEditingController: _emailController,
                                  ),


                                  // password input
                                  TextInput(
                                    hintText: 'Password',
                                    labelText: 'Password',
                                    suffix: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                      child: _isObscure?Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: Colors.grey,
                                      ):Icon(Icons.visibility_off,color: Colors.grey,),
                                    ),
                                    textInputType: TextInputType.text,
                                    validatorFunction: (String str) {
                                      if (str.isEmpty) {
                                        return 'This field cannot be empty.';
                                      } else if (!RegExp(kPasswordValidationRegex, caseSensitive: false).hasMatch(str)) {
                                        return ('Invalid Password.');
                                      }
                                      return null;
                                    },
                                    isPassword: _isObscure,
                                    textEditingController: _passwordController,
                                  )
                                ],
                              ),
                            ),
                          ),


                          // Login button
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: RoundedButton(
                                    onPressed: login,
                                    title: 'LOGIN',
                                  ),
                                ),
                              ),
                            ],
                          ),



                          // Sized box for space
                          SizedBox(
                            height: 15,
                          ),


                          // For signup
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New user to an application? ',
                                style: TextStyle(
                                    fontSize: 16.0),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, SignUpScreen.id);
                                },
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.indigoAccent),
                                ),
                              )
                            ],
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
      ),
    );
  }
}
