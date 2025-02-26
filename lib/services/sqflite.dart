import 'package:pesistencia_dados/model/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 


class SqfliteService {
  static Database? _db;
  
  static final SqfliteService instance = SqfliteService._constructor();
  
  final String _peopleTableName = "people";
  final String _peopleIdColumn = "id";
  final String _peopleNameColumn = "name";

  SqfliteService._constructor() {
    databaseFactory = databaseFactoryFfi;
  }

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
            CREATE TABLE IF NOT EXISTS $_peopleTableName (
                $_peopleIdColumn INTEGER PRIMARY KEY,
                $_peopleNameColumn TEXT NOT NULL
            )
        ''');
        print("SqfliteService: Table $_peopleTableName created or already exists");
      },
    );
    print("SqfliteService: Database initialized successfully");
    return database;
  }

  void addPerson(String name) async {
    final db = await database;
    await db.insert(
      _peopleTableName,
      {
        _peopleNameColumn: name,
      },
    );
  }

  Future<List<Person>> getPeople() async {
    final db = await database;
    final data = await db.query(_peopleTableName);
    //print(data);
    List<Person> people = data
                        .map((e) => Person(
                          id: e["id"] as int, 
                          name: e["name"] as String)
                        ).toList();
    return people;
  }
}
