class UserState{
  late String email;
  late String name;
  late String image;


UserState(){
  email="";
  name="";
  image="";
}

UserState.fillUserInfo(this.email,this.name,this.image);

}