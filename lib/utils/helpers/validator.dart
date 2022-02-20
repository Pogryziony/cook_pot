import 'package:profanity_filter/profanity_filter.dart';

class Validator{
  final filter = ProfanityFilter();


  bool validatePassword(String passphrase){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(passphrase);
  }

  bool validateEmail(String email){
    String  pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool validateTextField(String string){
    if(filter.hasProfanity(string)){
      return false;
    }
    return true;
  }
}

