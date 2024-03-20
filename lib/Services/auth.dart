
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairsalon_application/Services/database.dart';

import '../Models/CommonUser.dart';

class AuthService{
  final FirebaseAuth auth = FirebaseAuth.instance;


  CommonUser _userFromFirebaseUser(User? user){
    if (user !=null) {
      return CommonUser(uid: user.uid);
    }else{
      return CommonUser(uid: '');
    }
  }

  Stream<CommonUser> get user{
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with email password

  Future signInWithEmailAndPassword(String email, String password, bool isStudent) async{
    try{
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // register with email password
  Future registerWithEmailAndPassword(String email, String password, bool isStudent, dynamic obj ) async{
    try{
      print(obj.toString());
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      await DatabaseService(uid: user!.uid).updateUserData(obj);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // signout

  Future signout() async{
    try {
      print("logout");
      return await auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}