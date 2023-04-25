extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  int getIntMinuteFromString() {
    String timeString = this;
    List<String> time = timeString.split(':');
    return (int.tryParse(time.first) ?? 0) * 60 +
        (int.tryParse(time.last) ?? 0);
  }
}
