import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static final HiveService instance = HiveService._constructor();
  static Box<Map<String, dynamic>>? _box;

  HiveService._constructor();

  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    _box = await Hive.openBox<Map<String, dynamic>>('peopleBox');
  }

  Future<void> addPerson(String name) async {
    await _box!.add({'name': name});
  }

  List<Map<String, dynamic>> getPeople() {
    return _box!.values.toList();
  }
}
