class AppValidators {
  final RegExp emailRegExp = RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");

  String? validateEmail(String email) {
    if(email == "" && email.isEmpty){
      return 'Please enter email address';
    }
    else if (!emailRegExp.hasMatch(email.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }
  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter the phone number';
    } else if (value.length < 10) {
      return 'phone number must be 10 characters';
    }
    return null;
  }

  static String? validateCompanyCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter the valid company code';
    }
    return null;
  }

   String? commonValidate(String? value,type) {
     RegExp dateRegExp = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (value == null || value.isEmpty) {
      return 'please enter the $type';
    } else if(type == "year" && !dateRegExp.hasMatch(value)){
      return  'Enter a valid format (dd-mm-yyyy)';
    }
    else if(type == "year"){
      int? day = int.tryParse(value.split('-')[0]);
      int? month = int.tryParse(value.split('-')[1]);
      int? year = int.tryParse(value.split('-')[2]);
      if (day == null || day < 1 || day > 31 || month == null || month < 1 || month > 12 || year == null || year < 1900) {
        return 'Enter a valid format (dd-mm-yyyy)';
      }
    }
    return null;
  }
  String? validateDropDown(selectedOption) {
    if (selectedOption == null ) {
      return 'please select the dropdown';
    }
    return null;
  }

  String? validatePasswords({String? password1, String? password2}) {
    if (password1!.trim().isEmpty && password2!.trim().isEmpty) {
      return 'Please enter a password';
    } else if (password1.trim().length < 6 && password2!.trim().length < 6) {
      return 'Enter a valid password';
    }else if (password1 != password2) {
      return 'The password confirmation does not match.';
    }
    return null;
  }
  String? validatePassword({String? oldPassword}) {
    if (oldPassword!.trim().isEmpty) {
      return 'Please enter a password';
    } else if (oldPassword.trim().length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }
  String? validateName(String name,bool lastName ) {
    if (name.trim().isEmpty) {
      return (lastName == true)?'Enter last a name' : 'Enter first name';
    } else if (name.trim().length < 3) {
      return 'Enter a valid name';
    }
    return null;
  }
}
