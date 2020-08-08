part of 'index.dart';

///for storing the variable and page status.
class Repository {
  final permissions = Channel.permissionsRequest();
  int chartState = 0;
  int detailState = 0;
  Period period = Period.Week;
  TypeOfData typeOfData = TypeOfData.DAILY;
  List responseBody = [];
  FitKitType fitKitType = FitKitType.HEART_RATE;
  List ticks;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  num glucoseDuration = 3;
  List topLowest = [];
  bool lock = false;
  DetailOnChartPoint detailOnChartPoint = DetailOnChartPoint();
  String account;

  var glucose;

}
