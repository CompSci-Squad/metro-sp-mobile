class Globalvariables {
  String? email;
  dynamic PassengerResponse;


  Globalvariables();

  String? getEmail(){
    return email;
  }

  void setEmail(String newEmail){
    email = newEmail;
  }

  dynamic getPassengerResponse(){
    return PassengerResponse;
  }

  void setPassengerResponse(dynamic newPassengerResponse){
    PassengerResponse = newPassengerResponse;
  }

}

final globalvariables = Globalvariables();