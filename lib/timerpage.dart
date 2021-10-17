import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwacth_app/model/lapse_time.dart';
import 'package:stopwacth_app/widgets/buttons_style.dart';
import 'package:stopwacth_app/widgets/lapse_time_item.dart';
import 'package:stopwacth_app/widgets/style.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  //set initial time for the watch (hour=minute=second=0)
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => addTime(),
    );
  }

  void reset() {
    setState(() => duration = const Duration());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
      durations.clear();
    }

    setState(() => timer?.cancel());
  }

  final List<LapseTimeModel> durations = [];

  @override
  Widget build(BuildContext context) {
    // set isRunning = timer value and if the value
    // equals to null then return false else return true
    final isRunning = timer == null ? false : timer!.isActive;

    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    double sizeH = SizeConfig.blockSizeH!;

    Widget buildTime() {
      String twoDigits(int n) => n.toString().padLeft(2, '0');

      final hours = twoDigits(duration.inHours.remainder(24));
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));

      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$hours : $minutes : $seconds',
                  style: TextStyle(
                    fontSize: sizeV * 9.5,
                    color: whiteColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: sizeV * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons(
                      iconData: Icons.timelapse,
                      color: accentColor,
                      onPressed: () {
                        final LapseTimeModel lapseTimeModel = LapseTimeModel(
                          hour: duration.inHours,
                          minute: duration.inMinutes,
                          second: duration.inSeconds,
                        );
                        durations.add(lapseTimeModel);
                      },
                    ),
                    SizedBox(width: sizeH * 4),
                    Buttons(
                      iconData: isRunning ? Icons.pause : Icons.play_arrow,
                      color: accentColor,
                      onPressed: () {
                        if (isRunning) {
                          stopTimer(resets: false);
                        } else {
                          startTimer(resets: false);
                        }
                      },
                    ),
                    SizedBox(width: sizeH * 4),
                    Buttons(
                      iconData: Icons.stop,
                      color: Colors.grey,
                      onPressed: () {
                        stopTimer();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: durations.length,
                itemBuilder: (context, index) {
                  return LapseTimeItem(
                      order: index + 1,
                      hour: durations[index].hour,
                      minute: durations[index].minute,
                      second: durations[index].second);
                }),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: buildTime(),
    );
  }
}
