part of 'index.dart';

//Don't change the order of this enum.
enum FitKitType {
  HEART_RATE,
  BLOOD_PRESSURE,
  ACTIVITY,
  SLEEP,
  WEIGHT,
  BLOOD_SUGAR
}

enum Period {
  Day,
  Week,
  Month,
  Year,
}

enum HealthType {
  HEART_RATE,
  BLOOD_PRESSURE,
  WEIGHT,
  SLEEP,
  STEP_COUNT,//STEP_COUNT = ACTIVITY
}

//in order to map the background restful path.
enum TypeOfData{
  DETAIL,
  HOURLY,
  DAILY,
  MONTHLY,
}
