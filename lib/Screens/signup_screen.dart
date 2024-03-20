import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/dashboard_Screen.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Widgets/TextInput.dart';
import '../Services/auth.dart';
import '../Widgets/DropDown.dart';
import '../Widgets/RoundedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = 'SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthService auth = AuthService();

  var _signUPFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var kEmailValidationRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}';
  var kPasswordValidationRegex = '^[a-zA-Z0-9@_-]{7}';
  var kPhoneValidationRegex = '^[0-9]{10}';
  var kGenderList = [
    {'ID': 'Male', 'name': 'Male'},
    {'ID': 'Female', 'name': 'Female'},
    {'ID': 'Others', 'name': 'Others'}
  ];

  String _gender = 'Male';

  bool _isLoading = false;
  bool _isObscure = true;

  File? _imageFile;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    // getTeacherList();
    super.initState();
  }

  void signUp() async {
    if (_signUPFormKey.currentState!.validate()) {

      SalonUser user = SalonUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        contactNumber: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
        address: _addressController.text.trim(),
        gender: _gender,
      );

      String imageName = user.name + ".jpg";
      
      final ref = FirebaseStorage.instance.ref().child("profile_image").child(imageName);
      await ref.putFile(_imageFile!);

      final imageUrl = await ref.getDownloadURL();
      user.profileImg = imageUrl;

      dynamic result = await auth.registerWithEmailAndPassword(user.email, user.password,true,user);

      if (result == null) {
        SnackBar snackBar = SnackBar(
          content: Text(
            'Already have an account',
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        SnackBar snackBar = SnackBar(
          content: Text(
            'Create account successfully',
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, DashBoardScreen.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                  Container(
                    width: 90.0,
                    child: Divider(
                      color: Colors.black,
                      thickness: 5.0,
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _signUPFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                                child: _imageFile == null
                                    ? Icon(Icons.camera_alt, size: 40)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        TextInput(
                          hintText: 'John H. Doe',
                          labelText: 'Full Name',
                          textInputType: TextInputType.name,
                          validatorFunction: (String str) {
                            if (str.isEmpty)
                              return 'This field can not be empty.';
                            else
                              return null;
                          },
                          textEditingController: _nameController,
                          isPassword: false,
                        ),
                        TextInput(
                          hintText: 'jhondoe@mail.com',
                          labelText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          validatorFunction: (String str) {
                            if (str.isEmpty) {
                              return 'This field cannot be empty.';
                            } else if (!RegExp(kEmailValidationRegex,
                                caseSensitive: false)
                                .hasMatch(str)) {
                              return ('Invalid email.');
                            }
                            return null;
                          },
                          textEditingController: _emailController,
                          isPassword: false,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextInput(
                                hintText: '9876543210',
                                labelText: 'Contact Number',
                                textInputType: TextInputType.phone,
                                validatorFunction: (String str) {
                                  if (str.isEmpty) {
                                    return 'This field cannot be empty.';
                                  } else if (!RegExp(
                                      kPhoneValidationRegex,
                                      caseSensitive: false)
                                      .hasMatch(str)) {
                                    return ('Invalid Contact Number.');
                                  }
                                  return null;
                                },
                                textEditingController: _phoneController,
                                isPassword: false,
                              ),
                            ),
                            Expanded(
                              child: DropDown(
                                title: 'Gender',
                                value: _gender,
                                items: kGenderList,
                                onChange: (String? newValue) {
                                  setState(() {
                                    _gender = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        TextInput(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          textInputType: TextInputType.text,
                          validatorFunction: (String str) {
                            if (str.isEmpty) {
                              return 'This field cannot be empty.';
                            } else if (!RegExp(kPasswordValidationRegex,
                                caseSensitive: false)
                                .hasMatch(str)) {
                              return ('Invalid Password.');
                            }
                            return null;
                          },
                          isPassword: _isObscure,
                          textEditingController: _passwordController,
                        ),
                        TextInput(
                          hintText:
                          'Street 1, Street 2, City, Pin, State',
                          labelText: 'Address',
                          textInputType: TextInputType.streetAddress,
                          validatorFunction: (String str) {
                            if (str.isEmpty)
                              return 'This field can not be empty.';
                            else
                              return null;
                          },
                          textEditingController: _addressController,
                          isPassword: false,
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: RoundedButton(
                                    onPressed: signUp,
                                    title: 'Create Account')),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New User For Application? ',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blue),
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
    );
  }
}
