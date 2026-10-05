import 'package:flutter/foundation.dart';

class MonitoringViewModel extends ChangeNotifier {
  bool _isMonitoringActive = false;

  bool get isMonitoringActive => _isMonitoringActive;

  void toggleMonitoring(bool value) {
    _isMonitoringActive = value;
    notifyListeners();
  }
}
