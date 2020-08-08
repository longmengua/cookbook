part of '../index.dart';

class Calendar {
  ///bool = false, don't show time picker.
  Future<DateTime> dateTimePicker(BuildContext context,
      {DateTime dateTime, bool bool = false}) async {
    var selectedDate = await _selectDateTime(context, dateTime);
    var selectedTime = TimeOfDay.now();
    if (selectedDate == null) return null;
    if (bool) {
      selectedTime = await _selectTime(context);
      if (selectedTime == null) return null;
    }
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context, [DateTime dateTime]) =>
      showDatePicker(
        context: context,
        initialDate: dateTime ?? DateTime.now(),
        firstDate: DateTime(1911),
        lastDate: DateTime(DateTime.now().year + 1),
        locale: Locale('zh', 'TW'),
      );
}
