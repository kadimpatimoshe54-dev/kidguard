import 'package:hive/hive.dart';

class OfflineStorageService {
  static const String _boxName = 'offline_recordings_box';

  // Save recording path or data locally when internet is offline
  Future<void> saveOfflineData(String key, String filePath) async {
    var box = await Hive.openBox(_boxName);
    await box.put(key, {
      'path': filePath,
      'timestamp': DateTime.now().toIso8601String(),
      'isSynced': false,
    });
  }

  // Get all unsynced local records
  Future<List<Map<String, dynamic>>> getUnsyncedData() async {
    var box = await Hive.openBox(_boxName);
    List<Map<String, dynamic>> unsyncedList = [];
    
    for (var key in box.keys) {
      var data = box.get(key);
      if (data != null && data['isSynced'] == false) {
        unsyncedList.add({
          'key': key,
          'path': data['path'],
          'timestamp': data['timestamp'],
        });
      }
    }
    return unsyncedList;
  }

  // Delete from local memory after successful internet sync/upload
  Future<void> deleteSyncedData(dynamic key) async {
    var box = await Hive.openBox(_boxName);
    await box.delete(key);
  }
}
