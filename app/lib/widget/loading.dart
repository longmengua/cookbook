import 'package:flutter/material.dart';

///@note Text can be replace to any widget if you like to custom loading page.
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          'Loading...',
          style: TextStyle(fontSize: 30),
        ),
      );
}
