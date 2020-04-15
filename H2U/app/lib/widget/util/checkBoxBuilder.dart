import 'package:flutter/material.dart';

class RadioBoxBuilder extends StatefulWidget {
  final List<String> glucoseRecords;
  final List<String> glucoseRecordsOptions;
  final List<String> groupValue;

  RadioBoxBuilder(
      {this.groupValue,
      this.glucoseRecords,
      this.glucoseRecordsOptions,
      Key key})
      : super(key: key);

  @override
  RadioBoxBuilders createState() => RadioBoxBuilders();
}

class RadioBoxBuilders extends State<RadioBoxBuilder> {
  List<String> groupValue;

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValue ??
        List.generate(widget.glucoseRecords.length, (value) => '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.glucoseRecords
          .asMap()
          .map(
            (index, title) => checkBoxItem(
              index,
              title,
              widget.glucoseRecordsOptions.asMap(),
            ),
          )
          .values
          .toList(),
    );
  }

  MapEntry<int, Widget> checkBoxItem(
    int index,
    String title,
    Map<int, String> glucoseRecordsOptionsMap,
  ) {
    List<Widget> widgets = [];
    //in here, option is represented as MapEntry
    glucoseRecordsOptionsMap.entries.fold<List<Widget>>(widgets,
        (widgets, option) {
      widgets.add(
        Radio(
          activeColor: Colors.red,
          value: option.key.toString(),
          groupValue: groupValue[index],
          onChanged: (value) {
            setState(() {
              try {
                groupValue[index] = value;
              } catch (e) {
                print(e);
              }
              FocusScope.of(context).requestFocus(FocusNode());
            });
          },
        ),
      );
      widgets.add(
        Text(
          option.value ?? '-',
          style: TextStyle(fontSize: 20),
        ),
      );
      return widgets;
    });
    widgets.add(Text(
      '${title ?? '-'} : ',
      style: TextStyle(fontSize: 20),
    ));
    return MapEntry(
      index,
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widgets.reversed.toList(),
      ),
    );
  }
}
