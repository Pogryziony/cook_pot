String? validatePassword(String passphrase) {
  if (passphrase.isEmpty) {
    return "* Required";
  } else if (passphrase.length < 6) {
    return "Password should be at least 6 characters";
  } else if (passphrase.length > 25) {
    return "Password should not be greater than 25 characters";
  } else
    return null;
}