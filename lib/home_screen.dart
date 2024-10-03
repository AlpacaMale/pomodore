import 'package:flutter/material.dart';
import 'dart:async';

enum TimerState { active, inactive, sleep }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const initialSecond = 1500;
  static const sleepSecond = 300;
  int selectedSeconds = initialSecond;
  int totalSeconds = initialSecond;
  int cycle = 0, round = 0;
  String formatted = '25:00';
  TimerState timerState = TimerState.inactive;
  late Timer timer;

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0 && timerState == TimerState.active) {
      setState(() {
        timerState = TimerState.sleep;
        totalSeconds = sleepSecond;
        formatted = format(totalSeconds);
        if (cycle == 3) {
          cycle = 0;
          round = round + 1;
        } else {
          cycle = cycle + 1;
        }
      });
    } else if (totalSeconds == 0 && timerState == TimerState.sleep) {
      setState(() {
        timerState = TimerState.active;
        totalSeconds = selectedSeconds;
        formatted = format(totalSeconds);
      });
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
        formatted = format(totalSeconds);
      });
    }
  }

  void onTimeSelectd(time) {
    if (timerState != TimerState.inactive) timer.cancel();
    setState(() {
      selectedSeconds = time * 60;
      totalSeconds = selectedSeconds;
      formatted = format(totalSeconds);
      timerState = TimerState.inactive;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(microseconds: 1), onTick);
    setState(() {
      timerState = TimerState.active;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      timerState = TimerState.inactive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'POMOTIMER',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        formatted.substring(0, 2),
                        style: TextStyle(
                          fontSize: 88,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ':',
                      style: TextStyle(
                          fontSize: 88,
                          fontWeight: FontWeight.w300,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        formatted.substring(3),
                        style: TextStyle(
                          fontSize: 88,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  TimeSelectButton(
                    time: 15,
                    isSelected: selectedSeconds == 15 * 60,
                    onPressed: onTimeSelectd,
                  ),
                  TimeSelectButton(
                    time: 20,
                    isSelected: selectedSeconds == 20 * 60,
                    onPressed: onTimeSelectd,
                  ),
                  TimeSelectButton(
                    time: 25,
                    isSelected: selectedSeconds == 25 * 60,
                    onPressed: onTimeSelectd,
                  ),
                  TimeSelectButton(
                    time: 30,
                    isSelected: selectedSeconds == 30 * 60,
                    onPressed: onTimeSelectd,
                  ),
                  TimeSelectButton(
                    time: 35,
                    isSelected: selectedSeconds == 35 * 60,
                    onPressed: onTimeSelectd,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: IconButton(
                onPressed: timerState != TimerState.inactive
                    ? onPausePressed
                    : onStartPressed,
                icon: Icon(
                  timerState != TimerState.inactive
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                  color: Theme.of(context).cardColor,
                  size: 120,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$cycle/4',
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'ROUND',
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$round/12',
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'GOAL',
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSelectButton extends StatefulWidget {
  final int time;
  final bool isSelected;
  final Function(int) onPressed;

  const TimeSelectButton(
      {super.key,
      required this.time,
      required this.isSelected,
      required this.onPressed});

  @override
  State<TimeSelectButton> createState() => _TimeSelectButtonState();
}

class _TimeSelectButtonState extends State<TimeSelectButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(
              widget.isSelected
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).cardColor,
            ),
            backgroundColor: WidgetStateProperty.all<Color>(widget.isSelected
                ? Theme.of(context).cardColor
                : Theme.of(context).colorScheme.surface),
            shape: WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Theme.of(context).cardColor, width: 3),
              ),
            ),
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            ),
          ),
          onPressed: () => widget.onPressed(widget.time),
          label: Text(
            widget.time.toString(),
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
