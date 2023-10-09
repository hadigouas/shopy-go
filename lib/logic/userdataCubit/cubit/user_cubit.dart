import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/User_moudel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  Usermodule? usermodule;
  Future<void> fetchuserinfo() async {
    var user = await FirebaseAuth.instance.currentUser;
    var userid = user!.uid;
    if (user != null) {
      var userinfo = await FirebaseFirestore.instance
          .collection('userinfo')
          .doc(userid)
          .get();
      var userdoc = userinfo.data() as Map<String, dynamic>?;
      usermodule = Usermodule(
          userimage: userinfo.get('image'),
          username: userinfo.get('username'),
          useremail: userinfo.get('email'),
          userpassword: userinfo.get('password'),
          userwish:
              userdoc!.containsKey('userwish') ? userinfo.get('userwish') : [],
          usercard:
              userdoc.containsKey('usercard') ? userinfo.get('usercard') : []);
      emit(fetcheddata(usermodule: usermodule!));
    } else {
      return null;
    }
  }
}
