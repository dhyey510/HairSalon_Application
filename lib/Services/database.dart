import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairsalon_application/Models/AppointmentModel.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';


class DatabaseService{

  String uid;

  DatabaseService({required this.uid});

  CollectionReference get obj {return FirebaseFirestore.instance.collection('Users');}

  List<AppointmentModel> convertToAppointmentModels(List<dynamic> data) {
    return data.map((item) {
      return AppointmentModel(
          id: item['id'],
          name: item['name'],
          address: item['address'],
          city: item['city'],
          state: item['state'],
          imageUrl: item['imgUrl'],
          appointmentDate: item['appointmentDate']
      );
    }).toList();
  }

  Future updateUserData(dynamic setobj) async {
      return await obj.doc(uid).set({
        'name': setobj.name,
        'email':setobj.email,
        'phone':setobj.contactNumber,
        'gender':setobj.gender,
        'address':setobj.address,
        'appointment':setobj.appointment.map((appointment) => appointment.toMap()).toList(),
        'profileImg':setobj.profileImg,
      }).then((value) => print('added'));
  }


  //stream for student
  Stream<SalonUser> get getcurrentUser {
    return obj.doc(uid).snapshots().map(_currentUser);
  }

  SalonUser _currentUser(DocumentSnapshot snapshot) {
    SalonUser user = SalonUser(
      name: snapshot.get('name'),
      gender: snapshot.get('gender'),
      contactNumber: snapshot.get('phone'),
      address: snapshot.get('address'),
      email: snapshot.get('email'),
      profileImg: snapshot.get('profileImg')
    );

    user.appointment = convertToAppointmentModels(snapshot.get('appointment'));

    return user;
  }

  Future<SalonUser> currentUser (){
    return obj.doc(uid).get().then((value) => _currentUser(value));
  }

}