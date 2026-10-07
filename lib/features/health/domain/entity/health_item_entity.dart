import 'package:pet_care/features/health/domain/enums/health_item.dart';

abstract class HealthItem {
  DateTime get date;
  HealthItemType get type;
}