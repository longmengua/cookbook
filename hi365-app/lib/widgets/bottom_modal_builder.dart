import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:hi365/utils/app_configs.dart';

class BottomModalBuilder {
  BuildContext _context;
  List<String> _items;
  TextEditingController _textController;
  int _tempSelectedItem = 0;
  int _selectedItem = 0;

  static DateTime _now = DateTime.now();
  DateTime _maximumDate;
  int _maximumYear;
  int _minimumYear;
  CupertinoDatePickerMode _mode;
  String _dateFormat;

  /// [BottomModalBuilder.items] is for building item list shown at bottom.
  /// [context] is the widget tree context.
  /// [items] is a list that will be shown updater modal.
  /// [textController] is the result biding with parent.
  ///
  /// # Example
  /// ```dart
  /// List<String> myItems = [
  ///   '1',
  ///   '2',
  ///   '3',
  /// ]
  ///
  /// BottomModalBuilder.items(
  ///   context,
  ///   _myController,
  ///   myItems,
  /// );
  /// ```
  BottomModalBuilder.items(
    BuildContext context,
    TextEditingController textController,
    List<String> items,
  )   : _context = context,
        _items = items,
        _textController = textController {
    _showInstitutionModal();
  }

  /// [BottomModalBuilder.dateTimePicker] is for building date time picker shown at bottom.
  /// [context] the widget tree context.
  /// [textController] is the result biding with parent.
  /// [maximumDate] optional param, the maxium date,default value is today.
  /// [maximumYear] optional param, the maxium year, default value is current year.
  /// [minimumYear] optional param, the minimum date, default value is cureent year minus 120.
  /// [mode] optional param, the format that will be displayed, default is date, see to [CupertinoDatePickerMode].
  /// [dateFormat] optional param, the result that will bind to controller.
  ///
  /// # Examples
  /// ## 1. Uses default setting
  /// ```dart
  /// BottomModalBuilder.dateTimePicker(context, dateController);
  /// ```
  /// ## 2. Customized setting
  /// ```dart
  /// BottomModalBuilder.dateTimePicker(
  ///   context,
  ///   dateController,
  ///   maximumDate: DateTime.utc(2008, 11, 9),
  ///   maximumYear: 2008,
  ///   minimumYear: 1980,
  ///   mode: CupertinoDatePickerMode.dateAndTime,
  ///   dateFormat: 'MM/dd/yyyy',
  /// );
  /// ```
  BottomModalBuilder.dateTimePicker(
    BuildContext context,
    TextEditingController textController, {
    DateTime maximumDate,
    int maximumYear,
    int minimumYear,
    CupertinoDatePickerMode mode,
    String dateFormat,
  })  : _context = context,
        _textController = textController,
        _maximumDate = maximumDate ?? _now,
        _maximumYear = maximumYear ?? _now.year,
        _minimumYear = minimumYear ?? _now.year - 120,
        _mode = mode ?? CupertinoDatePickerMode.date,
        _dateFormat = dateFormat ?? 'yyyy/MM/dd' {
    _showBirthdayModal();
  }

  void _showInstitutionModal() {
    showModalBottomSheet(
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Scaffold(
          appBar: _showInstitutionModalAppBar(),
          body: CupertinoPicker(
            backgroundColor: Colors.white,
            children: _items.map((item) => _itemBuilder(item)).toList(),
            itemExtent: 70,
            onSelectedItemChanged: (int index) => _tempSelectedItem = index,
          ),
        ),
      ),
      context: _context,
    );
  }

  AppBar _showInstitutionModalAppBar() {
    return AppBar(
      elevation: 0.5,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _showInstitutionModalCancel(),
            _showInstitutionModalDone(),
          ],
        ),
      ),
    );
  }

  FlatButton _showInstitutionModalCancel() {
    return FlatButton(
      child: Text(
        '取消',
        style: TextStyle(
          color: AppConfig().primaryColor,
          fontSize: 15,
        ),
      ),
      onPressed: () {
        Navigator.of(_context).pop();
      },
    );
  }

  FlatButton _showInstitutionModalDone() {
    return FlatButton(
      child: Text(
        '完成',
        style: TextStyle(
          color: AppConfig().primaryColor,
          fontSize: 15,
        ),
      ),
      onPressed: () {
        _selectedItem = _tempSelectedItem;
        _textController.text = _items[_selectedItem];
        Navigator.of(_context).pop();
      },
    );
  }

  Widget _itemBuilder(String name) {
    return Center(
      child: Text(
        name,
        style: TextStyle(fontSize: 23),
      ),
    );
  }

  Future<void> _showBirthdayModal() async {
    return await showModalBottomSheet(
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 3,
        child: CupertinoDatePicker(
          initialDateTime: _maximumDate,
          onDateTimeChanged: (DateTime newdate) {
            _textController.text = DateFormat(_dateFormat).format(newdate);
          },
          maximumDate: _maximumDate,
          maximumYear: _maximumYear,
          minimumYear: _minimumYear,
          mode: _mode,
        ),
      ),
      context: _context,
    );
  }
}
