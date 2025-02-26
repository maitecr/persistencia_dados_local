class Person {
  final int id;
  final String name;

  Person({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() { //Cast a object to a map
    return {
      'id': id,
      'name': name,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) { //Cast a map to an object
    return Person(
      id: map['id'],
      name: map['name'],
    );
  }

}