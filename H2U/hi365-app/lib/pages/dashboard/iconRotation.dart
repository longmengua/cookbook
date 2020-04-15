import 'dart:math';

import 'package:flutter/material.dart';

class IconRotation extends StatefulWidget {
  final Function doSomething;
  final RotationModel rotation;

  IconRotation(this.doSomething, this.rotation);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IconRotation> {
  @override
  void initState() {
    animation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(IconRotation oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Transform.rotate(
          angle: widget?.rotation?.angle ?? 0,
          child: Icon(
            Icons.sync,
            color: Theme.of(context).accentColor,
            size: 30,
          ),
        ),
        onPressed: () {
          rotate();
        },
      ),
    );
  }

  void rotate() {
    widget?.rotation?.angle = 0;
    if (widget?.rotation?.running == true) return;
    widget?.rotation?.running = true;
    if (widget?.doSomething != null) {
      widget.doSomething(widget?.rotation);
    }
    animation();
  }

  void animation() async {
    print(widget?.rotation?.running);
    while (widget?.rotation?.running ?? false) {
      setState(() {});
      widget?.rotation?.angle -= 10;
      await Future.delayed((Duration(milliseconds: 500)));
    }
  }
}

class RotationModel {
  double angle = 0;
  bool running = false;
}
