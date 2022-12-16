import 'package:flutter/material.dart';

Widget musicProgressIndicator({position, duration}) {
  double resultVal = 0;
  if (position == 0 || duration == 0) {
    resultVal = 0;
  } else {
    resultVal = position / duration;
  }
  return SizedBox(
    height: 2,
    child: LinearProgressIndicator(
      backgroundColor: Colors.grey[200],
      valueColor: const AlwaysStoppedAnimation(Colors.black),
      value: resultVal,
    ),
  );
}
