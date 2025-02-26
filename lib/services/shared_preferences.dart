import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pesistencia_dados/model/person.dart';

class SharedPreferencesService {
  static final SharedPreferencesService instance = SharedPreferencesService._constructor();

  SharedPreferencesService._constructor();

  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  Future<void> addPerson(Person person) async {
    final prefs = await _prefs;
    List<String> peopleJson = prefs.getStringList('people') ?? [];

    peopleJson.add(json.encode(person.toMap()));

    await prefs.setStringList('people', peopleJson);
  }

  Future<List<Person>> getPeople() async {
    final prefs = await _prefs;
    List<String> peopleJson = prefs.getStringList('people') ?? [];

    return peopleJson.map((e) => Person.fromMap(json.decode(e) as Map<String, dynamic>)).toList();
  }
}
