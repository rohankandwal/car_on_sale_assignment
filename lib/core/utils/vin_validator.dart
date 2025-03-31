/// For Vehicle Identification Number (VIN) validation
class VinValidator {
  VinValidator._();
  static bool isValidVin(String value) {
    return RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value) && value.length == 17;
  }
}
