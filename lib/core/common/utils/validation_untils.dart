class ValidationUtils{

  static String? validateEmail(String? email) {
    if(email == null  || email.isEmpty){
      return 'Email is required';
    }
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      return 'Please enter a valid email ';
    }
    return null;
  }
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters ';
    }
    return null;
  }
  static String? valideteConfirmPassword(String? password , String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != password) {
      return 'Password do not match';
    }
    return null;
  }
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters ';
    }
    return null;
  }
}