import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CircularBorderButton extends StatefulWidget {
  @override
  _CircularBorderButtonState createState() => _CircularBorderButtonState();
}

class _CircularBorderButtonState extends State<CircularBorderButton> {
  var _isTiming = false;
  var _dTime = "";

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(onChange: (value) {
    /*final displayTime = StopWatchTimer.getDisplayTime(value);
    print("displayTime $displayTime");*/
  });

  void _startTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
  }

  void _stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void _reset() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    print('reset timer');
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        splashColor: Colors.black,
        color: Colors.black.withOpacity(0.6),
        onPressed: () {
          this.setState(() {
            _isTiming = !_isTiming;
          });

          if (!_isTiming) {
            _stopTimer();
          } else {
            _startTimer();
          }
        },
        onLongPress: _reset,
        child:
            /*Text(
        "START",
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      padding: EdgeInsets.all(40),
      shape: CircleBorder(
        side: BorderSide(
          width: 5,
          color: _isTiming ? Colors.green : Colors.red,
        ),
      ),*/
            StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value);
                  return _isTiming ? Text(displayTime) : Text("Start");
                }));
  }
}
