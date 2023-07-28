import 'dart:async';

class MyTimer {
  int _seconds = 30;
  Timer? _timer;
  Function()? _onUpdate; // 追加

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds--;
      if (_onUpdate != null) { // 追加
        _onUpdate!(); // 追加
      }
    });
  }

  int get seconds => _seconds;

  void stop() {
    _timer?.cancel();
  }

  void setOnUpdate(Function() onUpdate) { // 追加
    _onUpdate = onUpdate; // 追加
  }

  void tick() {
    _seconds--;
  }

  int getSeconds() {
    return seconds;
  }

  void dispose() {
    stop();
  }
}