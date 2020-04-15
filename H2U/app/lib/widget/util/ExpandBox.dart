import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpandBox extends StatefulWidget {
  final Widget title;
  final Widget content;
  final CrossAxisAlignment crossAxisAlignment;

  ExpandBox(this.title, this.content, this.crossAxisAlignment);

  @override
  _ExpandBoxState createState() => _ExpandBoxState();
}

class _ExpandBoxState extends State<ExpandBox> {
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: <Widget>[
        title(isExpand ? collapsedButton() : expandedButton()),
        isExpand ? widget.content : Container(),
      ],
    );
  }

  Widget title(Widget button) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: widget.title,
          ),
          button,
        ],
      ),
      onTap: () {
        isExpand = !isExpand;
        setState(() {});
      },
    );
  }

  Widget expandedButton() {
    return SizedBox(
      height: 30,
      width: 30,
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 30,
        semanticLabel: 'Expanded the medicines detail',
      ),
    );
  }

  Widget collapsedButton() {
    return SizedBox(
      height: 30,
      width: 30,
      child: Icon(
        Icons.keyboard_arrow_up,
        size: 30,
        semanticLabel: 'Collapse the medicines detail',
      ),
    );
  }
}
