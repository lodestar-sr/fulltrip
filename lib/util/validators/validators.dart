class Validators {
  static String required(String value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  static String isNumeric(String value) {
    if (value == null || double.tryParse(value) == null) {
      return 'This field must be numeric';
    }
    return null;
  }

  static String isURL(String value) {
    if (!Uri.parse(value).isAbsolute) {
      return 'This field requires a valid URL address';
    }
    return null;
  }

  static String mustEmail(String value) {
    if (Validators.required(value) != null) {
      return Validators.required(value);
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'This field requires a valid email address';
    }
    return null;
  }

  static String mustNumeric(String value) {
    if (Validators.required(value) != null) {
      return Validators.required(value);
    }
    if (Validators.isNumeric(value) != null) {
      return Validators.isNumeric(value);
    }
    return null;
  }

  static String mustURL(String value) {
    if (Validators.required(value) != null) {
      return Validators.required(value);
    }
    if (Validators.isURL(value) != null) {
      return Validators.isURL(value);
    }
    return null;
  }
}
