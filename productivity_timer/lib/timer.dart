import 'dart:async';

import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fullTime;
  int _workTimeMinutes = 30;
  int _shortBreak = 5;
  int _longBreak = 20;

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if(this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if(_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = _returnTime(this._time);
      return TimerModel(time, this._radius);
    });
  }

  void startWork() async {
    await _readSettings();
    _radius = 1;
    _fullTime = _time = Duration(minutes: _workTimeMinutes, seconds: 0);
  }

  void startBreak(bool short) {
    _radius = 1;
    _fullTime = _time = Duration(minutes: short ? _shortBreak : _longBreak, seconds: 0);
  }

  void startTimer() {
    if(_time.inSeconds > 0) {
      _isActive = true;
    }
  }

  void stopTimer() {
    _isActive = false;
  }
  
  _readSettings() async {
    var pref = await SharedPreferences.getInstance();
    var workTime = pref.getInt(WORKTIME);
    var short = pref.getInt(SHORTBREAK);
    var long = pref.getInt(LONGBREAK);
    _workTimeMinutes = workTime == null ? 30 : workTime;
    _shortBreak = short == null ? 5 : short;
    _longBreak = long == null ? 20 : long;
  }

  String _returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    return minutes + ':' + seconds;
  }


}
