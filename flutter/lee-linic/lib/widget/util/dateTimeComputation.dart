class DateTimeComputation {
  static bool between(
    DateTime date, {
    DateTime startDate,
    DateTime endDate,
  }) {
    return startDate.isBefore(date) && endDate.isAfter(date);
  }
}
