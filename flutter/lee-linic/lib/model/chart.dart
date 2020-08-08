//for chart
class ChartData {
  final num date;
  final num value;

  ChartData(this.date, this.value);

  @override
  String toString() {
    return 'ChartData{date: $date, value: $value}';
  }
}

class Domain {
  String key;
  double minYaxis;
  double maxYaxis;
  num end;
  num start;

  Domain(this.key,
      {this.minYaxis, this.maxYaxis, this.end, this.start});

  @override
  String toString() {
    return 'Domain{key: $key, minYaxis: $minYaxis, maxYaxis: $maxYaxis, end: $end, start: $start}';
  }
}
