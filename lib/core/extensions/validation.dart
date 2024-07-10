//extension to check if the email is valid or not
extension EmailValidator on String {
  bool isValidEmail() {
    final RegExp regex = RegExp(
      r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(this);
  }
}

//extension to check if the user name is valid
extension UsernameValidator on String {
  bool isValidUsername() {
    return this.length >= 3 &&
        !RegExp(r'^\d+$').hasMatch(this); // Checks if it's not only numbers
  }
}

//extension to check if the passowrd contains uppercase letters
extension UpperCaseValidator on String {
  bool isUpperCase() {
    return this
        .contains(RegExp(r'[A-Z]')); // Checks if it contains uppercase letters
  }
}

//extension to check if the passowrd contains lowercase letters
extension LowerCaseValidator on String {
  bool isLowerCase() {
    return this
        .contains(RegExp(r'[a-z]')); // Checks if it contains lowercase letters
  }
}

//extension to check if the passowrd contains atleast 1 digit
extension DigitValidator on String {
  bool isContainDigit() {
    return this
        .contains(RegExp(r'[0-9]')); // Checks if it contains atleast 1 digit
  }
}

//extension to check if the passowrd contains a special character
extension SpecialCharacterValidator on String {
  bool isContainSpecialCharacter() {
    return this.contains(RegExp(
        r'[!@#$%^&*(),.?":{}|<>]')); // Checks if it contains a special character
  }
}

//extension to check if the device IMEI starts with 865
extension NumberValidation on String {
  bool isValidIMEI() {
    //checking if the string is not null and has at least 15 characters
    if (this.length >= 15) {
      //checking if the imei contains digits
      String digits = this.substring(0);
      return int.tryParse(digits) != null;
    }
    return false;
  }
}

extension DateValidator on String {
  bool isValidDate() {
    // Regular expression for dd/mm/yyyy format
    final RegExp dateRegExp = RegExp(
      r'^([0-2][0-9]|(3)[0-1])\/((0)[1-9]|(1)[0-2])\/\d{4}$',
    );

    // Check if the string matches the regex pattern
    if (!dateRegExp.hasMatch(this)) {
      return false;
    }

    // Extract day, month, and year from the string
    final List<String> parts = this.split('/');
    final int day = int.parse(parts[0]);
    final int month = int.parse(parts[1]);
    final int year = int.parse(parts[2]);

    // Check if the date is valid using DateTime
    try {
      final DateTime date = DateTime(year, month, day);
      return date.day == day && date.month == month && date.year == year;
    } catch (e) {
      return false;
    }
  }
}
