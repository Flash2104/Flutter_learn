import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimerSettingsKey { workTime, shortBreak, longBreak }

const String WORKTIME = "workTime";
const String SHORTBREAK = "shortBreak";
const String LONGBREAK = "longBreak";

class TimerSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimerSettingsState();
  }
}

class _TimerSettingsState extends State<TimerSettingsPage> {
  final TextStyle _textStyle = TextStyle(fontSize: 24);

  int _workTime;
  int _shortBreak;
  int _longBreak;

  SharedPreferences _prefs;

  TextEditingController _txtWork;
  TextEditingController _txtShort;
  TextEditingController _txtLong;

  FocusNode _workNode;
  FocusNode _shortNode;
  FocusNode _longNode;

  @override
  void initState() {
    _txtWork = TextEditingController();
    _txtShort = TextEditingController();
    _txtLong = TextEditingController();
    _readSettings();
    _workNode = FocusNode();
    _workNode.addListener(() {
      if (!_workNode.hasFocus) {
        _changeValue(WORKTIME, _txtWork.text);
      }
    });
    _shortNode = FocusNode();
    _shortNode.addListener(() {
      if (!_shortNode.hasFocus) {
        _changeValue(SHORTBREAK, _txtShort.text);
      }
    });
    _longNode = FocusNode();
    _longNode.addListener(() {
      if (!_longNode.hasFocus) {
        _changeValue(LONGBREAK, _txtLong.text);
      }
    });
    // _createSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
          child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(20),
        children: [
          Text('Work', style: _textStyle),
          Text(''),
          Text(''),
          SettingsButton(Color(0xff455A64), '-', -1, WORKTIME, _updateSetting),
          TextField(
              style: _textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              focusNode: _workNode,
              onSubmitted: (val) => _changeValue(WORKTIME, val),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, _CustomRangeTextInputFormatter(1, 180)],
              controller: _txtWork),
          SettingsButton(Color(0xff009688), '+', 1, WORKTIME, _updateSetting),
          Text('Short', style: _textStyle),
          Text(''),
          Text(''),
          SettingsButton(Color(0xff455A64), "-", -1, SHORTBREAK, _updateSetting),
          TextField(
              style: _textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              focusNode: _shortNode,
              onSubmitted: (val) => _changeValue(SHORTBREAK, val),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, _CustomRangeTextInputFormatter(1, 120)],
              controller: _txtShort),
          SettingsButton(Color(0xff009688), "+", 1, SHORTBREAK, _updateSetting),
          Text("Long", style: _textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", -1, LONGBREAK, _updateSetting),
          TextField(
              style: _textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              focusNode: _longNode,
              onSubmitted: (val) => _changeValue(LONGBREAK, val),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, _CustomRangeTextInputFormatter(1, 180)],
              controller: _txtLong),
          SettingsButton(Color(0xff009688), "+", 1, LONGBREAK, _updateSetting),
        ],
      )),
    );
  }

  _readSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _workTime = _prefs.getInt(WORKTIME);
    if (_workTime == null) {
      await _prefs.setInt(WORKTIME, _workTime = 30);
    }
    _shortBreak = _prefs.getInt(SHORTBREAK);
    if (_shortBreak == null) {
      await _prefs.setInt(SHORTBREAK, _shortBreak = 5);
    }
    _longBreak = _prefs.getInt(LONGBREAK);
    if (_longBreak == null) {
      await _prefs.setInt(LONGBREAK, _longBreak = 20);
    }
    setState(() {
      _txtWork.text = _workTime.toString();
      _txtShort.text = _shortBreak.toString();
      _txtLong.text = _longBreak.toString();
    });
  }

  void _changeValue(String key, String value) {
    var intValue = int.tryParse(value);
    if (intValue != null && (intValue >= 1 && intValue <= 180)) {
      _prefs.setInt(key, 0);
      _updateSetting(key, intValue);
    }
  }

  void _updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          _workTime = _prefs.getInt(WORKTIME);
          _workTime += value;
          if (_workTime >= 1 && _workTime <= 180) {
            _prefs.setInt(WORKTIME, _workTime);
            setState(() {
              _txtWork.text = _workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          _shortBreak = _prefs.getInt(SHORTBREAK);
          _shortBreak += value;
          if (_shortBreak >= 1 && _shortBreak <= 120) {
            _prefs.setInt(SHORTBREAK, _shortBreak);
            setState(() {
              _txtShort.text = _shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          _longBreak = _prefs.getInt(LONGBREAK);
          _longBreak += value;
          if (_longBreak >= 1 && _longBreak <= 180) {
            _prefs.setInt(LONGBREAK, _longBreak);
            setState(() {
              _txtLong.text = _longBreak.toString();
            });
          }
        }
        break;
    }
  }
}

class _CustomRangeTextInputFormatter extends TextInputFormatter {
  final int _minValue;
  final int _maxValue;

  _CustomRangeTextInputFormatter(this._minValue, this._maxValue);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var intValue = int.tryParse(newValue.text);
    if (intValue == null)
      return TextEditingValue().copyWith(text: '');
    else if (int.parse(newValue.text) < _minValue) return TextEditingValue().copyWith(text: _minValue.toString());

    return int.parse(newValue.text) > _maxValue ? TextEditingValue().copyWith(text: _maxValue.toString()) : newValue;
  }
}
