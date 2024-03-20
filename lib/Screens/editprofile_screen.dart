import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairsalon_application/Widgets/DropDown.dart';
import 'package:hairsalon_application/Widgets/RoundedButton.dart';
import 'package:hairsalon_application/Widgets/TextInput.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static final String id = 'editProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

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
  String profileImage = '';

  bool _isLoading = true;
  bool _isObscure = true;

  late SalonUser currentUser;

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

  void _editProfile() async{

    setState(() {
      _isLoading = true;
    });

    if(_imageFile != null){
      String imageName = currentUser.name + ".jpg";

      final ref = FirebaseStorage.instance.ref().child("profile_image").child(imageName);
      await ref.putFile(_imageFile!);

      final imageUrl = await ref.getDownloadURL();
      currentUser.profileImg = imageUrl;
    }
    currentUser.name = _nameController.text;
    currentUser.email = _emailController.text;
    currentUser.gender = _gender;
    currentUser.contactNumber = _phoneController.text;
    currentUser.address = _addressController.text;

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).updateUserData(currentUser);

    setState(() {
      _isLoading = false;
    });

    SnackBar snackBar = SnackBar(
      content: Text(
        'Change details successfully',
        style: TextStyle(fontSize: 16.0),
      ),
      backgroundColor: Colors.teal,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.of(context).pop();

  }

  void _getUserData() async{

    currentUser =  await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).currentUser();

    _nameController.text = currentUser.name;
    _emailController.text = currentUser.email;
    _phoneController.text = currentUser.contactNumber;
    _addressController.text = currentUser.address;
    _gender = currentUser.gender;
    profileImage = currentUser.profileImg;

    setState(() {
      _isLoading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override

  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                                backgroundImage: profileImage != null ? NetworkImage(profileImage) : null,
                                child: profileImage == null
                                    ? Icon(Icons.camera_alt, size: 40)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        TextInput(
                          hintText: "Dhyey Desai",
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
                                    onPressed: _editProfile,
                                    title: 'Change Details')),
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
