import 'package:flutter/material.dart';
import 'package:pesistencia_dados/model/person.dart';
import 'package:pesistencia_dados/services/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final SqfliteService _sqfliteService = SqfliteService.instance;
  String? _person = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addPersonButton(),
      body: _peopleList(),
    );
  }

  Widget _addPersonButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context, 
          builder: (_) => AlertDialog(
            title:  Text('Add Person'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
               children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _person = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Subscribe',
                  ),
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (_person == null ||_person == "") return;
                    _sqfliteService.addPerson(_person!);
                    setState(() {
                      _person = null;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
               ],
            ),
          ),
        );
      },
      child: const Icon(
        Icons.add,
        ),
    );
  }

  Widget _peopleList() {
    return FutureBuilder(
      future: _sqfliteService.getPeople(), 
      builder: (context, snapshop) {
        return ListView.builder(
          itemCount: snapshop.data?.length ?? 0,
          itemBuilder: (context, index) {
            Person person = snapshop.data![index];
            return ListTile(
              title: Text(
                person.name
              ),
            );
          },
        );
      }
    );
  }
}
