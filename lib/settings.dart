import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtLong = TextEditingController();
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Text("Work", style: textStyle),
        const Text(""),
        const Text(""),
        SettingsButton(
            const Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
        TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(
            const Color(0xff009688), "+", 1, WORKTIME, updateSetting),
        Text("Short", style: textStyle),
        const Text(""),
        const Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtShort,
            keyboardType: TextInputType.number),
        SettingsButton(
            const Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
        Text(
          "Long",
          style: textStyle,
        ),
        const Text(""),
        const Text(""),
        SettingsButton(
            const Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtLong,
            keyboardType: TextInputType.number),
        SettingsButton(
            const Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
      ],
    );
  }

  readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME) ?? 0;
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int shortBreak = prefs.getInt(SHORTBREAK) ?? 0;
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int longBreak = prefs.getInt(LONGBREAK) ?? 0;
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME) ?? 0;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK) ?? 0;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK) ?? 0;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
