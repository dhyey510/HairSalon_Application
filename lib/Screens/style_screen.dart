import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Screens/prediction_screen.dart';
import 'package:hairsalon_application/Widgets/DropDown.dart';
import 'package:hairsalon_application/Widgets/RoundedButton.dart';
import 'package:hairsalon_application/Widgets/TextInput.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

class StyleScreen extends StatefulWidget {
  const StyleScreen({Key? key}) : super(key: key);

  static final String id = 'StyleScreen';

  @override
  State<StyleScreen> createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen> {

  File? _image;
  final picker = ImagePicker();
  String? selectedEditing = "both";
  String? selectHairstyle;
  List<String> hairstyles = ["afro hairstyle", "bob cut hairstyle", "bowl cut hairstyle", "braid hairstyle", "caesar cut hairstyle", "chignon hairstyle", "cornrows hairstyle", "crew cut hairstyle", "crown braid hairstyle", "curtained hair hairstyle", "dido flip hairstyle", "dreadlocks hairstyle", "extensions hairstyle", "fade hairstyle", "fauxhawk hairstyle", "finger waves hairstyle", "french braid hairstyle", "frosted tips hairstyle", "full crown hairstyle", "harvard clip hairstyle", "hi-top fade hairstyle", "high and tight hairstyle", "hime cut hairstyle", "jewfro hairstyle", "jheri curl hairstyle", "liberty spikes hairstyle", "marcel waves hairstyle", "mohawk hairstyle", "pageboy hairstyle", "perm hairstyle", "pixie cut hairstyle", "psychobilly wedge hairstyle", "quiff hairstyle", "regular taper cut hairstyle", "ringlets hairstyle", "shingle bob hairstyle", "short hair hairstyle", "slicked-back hairstyle", "spiky hair hairstyle", "surfer hair hairstyle", "taper cut hairstyle", "the rachel hairstyle", "undercut hairstyle", "updo hairstyle"];
  TextEditingController hairColor = TextEditingController();
  late String imgvalue;
  String imgurl = '';
  bool _isLoading = false;

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Change your style', style: TextStyle(color: Colors.white),)),
      ),
      body: _isLoading? LoadingScreen(): SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xffECEEF3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                _image!,
                height: 200,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: getImageFromCamera,
                    child: Text('Take Picture'),
                  ),
                  ElevatedButton(
                    onPressed: getImageFromGallery,
                    child: Text('Choose from Gallery'),
                  ),
                ],
              ),
        
              Container(
                height: 81,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select what you want to edit",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                          fontSize: 18),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child:
                        DropdownButtonFormField<
                            String>(
                          value: selectedEditing,
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .normal,
                              color: Colors.black,
                              fontSize: 15),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedEditing = newValue!;
                            });
                          },
                          items: <String>["hairstyle", "haircolor", "both"].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border:
                            InputBorder.none,
                          ),
                        )),
                  ],
                ),
              ),
        
              //choose hairstyle
              (selectedEditing == "both" || selectedEditing == "hairstyle") ? Container(
                height: 85,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Hairstyle",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                          fontSize: 18),
                    ),
                    Container(
                        padding:
                        EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(
                                  10)),
                        ),
                        child:
                        DropdownButtonFormField<
                            String>(
                          value: selectHairstyle,
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .normal,
                              color: Colors.black,
                              fontSize: 15),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectHairstyle = newValue!;
                            });
                          },
                          items: hairstyles.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border:
                            InputBorder.none,
                          ),
                        )),
                  ],
                ),
              ): SizedBox(height: 1,),
        
              (selectedEditing == "both" || selectedEditing == "haircolor") ? TextInput(
                hintText: "Type Color Name",
                textEditingController: hairColor,
                textInputType: TextInputType.text,
                labelText: "HairColor",
                isPassword: false,
                validatorFunction: (value){
                  return true;
                },
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              ):SizedBox(height: 1,),
        
              RoundedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await convertBase64(_image);
                  await _predictHairClip().then((value){
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PredictionScreen(imgurl: imgurl,)));
                  });

                  },
                title: 'Predict',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> convertBase64(File? _img) async {
    final fileBytes = await _img!.readAsBytes();
    final base64Image = base64Encode(fileBytes);
    imgvalue =  'data:image/jpeg;base64,$base64Image';
  }

  Future<void> _predictHairClip() async {

    Map<String, dynamic> requestBody = {
        "version": "b95cb2a16763bea87ed7ed851d5a3ab2f4655e94bcfb871edba029d4814fa587",
        "input": {
          "image": imgvalue,
          "editing_type": selectedEditing,
          "color_description": hairColor.text,
          "hairstyle_description": selectHairstyle,
        }
    };

    String requestBodyJson = jsonEncode(requestBody);

    Timer? _timer;

    Uri url = Uri.parse('https://api.replicate.com/v1/predictions');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Token r8_bWlhge8sVFGcMsNqCwsbgwM18yOb06V3Q0fLX',
      },
      body: requestBodyJson,
    );

    Map<String, dynamic> responseData = jsonDecode(response.body);

    if (responseData["status"] == "starting") {
      Completer<String> completer = Completer();

      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        try {
          var response = await http.get(Uri.parse(responseData["urls"]["get"]), headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token r8_bWlhge8sVFGcMsNqCwsbgwM18yOb06V3Q0fLX',
          },);

          responseData = jsonDecode(response.body);

          if (responseData["status"] == "succeeded") {
            imgurl = responseData["output"];
            _timer!.cancel();
            completer.complete(imgurl); // Signal that imgurl is collected
          } else if(responseData["status"] == "failed"){
            print('Failed to fetch data: ${responseData["status"]}');
            _timer!.cancel();
            completer.complete(imgurl);
          } else if(responseData["status"] == "canceled"){
            print('Failed to fetch data: ${responseData["status"]}');
            _timer!.cancel();
            completer.complete(imgurl);
          } else {
            print('Processing with status: ${responseData["status"]}');
          }
        } catch (e) {
          print('Error: $e');
        }
      });

      imgurl = await completer.future;

    } else if(responseData["status"] == "succeeded"){
      imgurl = responseData["output"];
    } else if(responseData["status"] == "failed"){
      print("Failed: ${response.body}");
    } else if(responseData["status"] == "canceled"){
      print("Canceled: ${response.body}");
    } else {
      print("error: ${response.body}");
    }
  }
}