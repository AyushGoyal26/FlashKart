
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/cubit/user_state.dart';
import 'package:grocery_app/services/oauth.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit():super(UserState());


  void login()async{
    OAuth oauth=OAuth();
    final userCred=await oauth.signInWithGoogle();
    String email=userCred.user!.email!.toString();
    String name=userCred.user!.displayName!.toString();
    String image=userCred.user!.photoURL!.toString();
    emit(UserState.fillUserInfo(email, name, image));
  }

}
