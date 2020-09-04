import 'package:flutter/material.dart';

class CircularBorderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      splashColor: Colors.black,
      color: Colors.black.withOpacity(0.6),
      onPressed: () => {},
      child: Text(
        'START',
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
          color: Colors.green,
        ),
      ),
    );
  }
}
