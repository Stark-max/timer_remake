import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timer_remake/settings.dart';
import 'package:timer_remake/timer.dart';
import 'package:timer_remake/timermodel.dart';
import 'package:timer_remake/widgets.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My work Timer',
      home: TimerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimerHomePage extends StatelessWidget {
  TimerHomePage({Key? key}) : super(key: key);

  final spacer = const Padding(padding: EdgeInsets.all(5));
  CountDownTimer timer = CountDownTimer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work timer'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Settings',
                  child: Text('Settings'),
                )
              ];
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          double availableWidth = constraint.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  spacer,
                  Expanded(
                      child: MainButton(
                    onPressed: () => timer.startWork(),
                    color: Colors.indigoAccent,
                    text: 'work',
                    size: 2,
                  )),
                  spacer,
                  Expanded(
                      child: MainButton(
                    onPressed: () => timer.startBreak(true),
                    color: Colors.indigoAccent,
                    text: 'short break',
                    size: 2,
                  )),
                  spacer,
                  Expanded(
                      child: MainButton(
                    onPressed: () => timer.startBreak(false),
                    color: Colors.indigoAccent,
                    text: 'long break',
                    size: 2,
                  )),
                  spacer,
                ],
              ),
              Expanded(
                child: StreamBuilder(
                    initialData: TimerModel('00:00', 1.0),
                    stream: timer.stream(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      TimerModel timer = snapshot.data;
                      return CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 10.0,
                        percent: timer.percent,
                        center: Text(timer.time,
                            style: Theme.of(context).textTheme.headlineMedium),
                        progressColor: const Color(0xff009688),
                      );
                    }),
              ),
              Row(
                children: [
                  spacer,
                  Expanded(
                      child: MainButton(
                    color: const Color(0xff212121),
                    text: 'Stop',
                    onPressed: () => timer.stopTimer(),
                    size: 3,
                  )),
                  spacer,
                  Expanded(
                      child: MainButton(
                    color: const Color(0xff009688),
                    text: 'Restart',
                    onPressed: () => timer.startTimer(),
                    size: 3,
                  )),
                  spacer,
                ],
              )
            ],
          );
        },
      ),
    );
  }

  void goToSettings(BuildContext context) {
    print('in gotoSettings');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }
}
