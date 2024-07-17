// you can run the code in dartpad: https://dartpad.dev/
typedef VoidCallback = dynamic Function();

class Throttler {
  Throttler({this.throttleGapInMillis});

  final int throttleGapInMillis;

  int lastActionTime;

  void run(VoidCallback action) {
    if (lastActionTime == null) {
      action();
      lastActionTime = DateTime.now().millisecondsSinceEpoch;
    } else {
      if (DateTime.now().millisecondsSinceEpoch - lastActionTime > (throttleGapInMillis ?? 500)) {
        action();
        lastActionTime = DateTime.now().millisecondsSinceEpoch;
      }
    }
  }
}
