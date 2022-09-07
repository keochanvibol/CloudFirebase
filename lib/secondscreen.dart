import 'package:firebase_read_write/student.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController scoreController = TextEditingController();
  List<String> docIds = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('student')
        .get()
        .then((value) => value.docs.forEach((DocumentSnapshot document) {
              setState(() {
                print('ID = ${document.reference.id}');
                docIds.add(document.reference.id);
              });
            }));
  }

  var varInit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    varInit = getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Data to Firebase'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.mail),
                  //hintText: 'Enter Email',
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: genderController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.mail),
                  //hintText: 'Enter Email',
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: scoreController,
                decoration: const InputDecoration(
                  //prefixIcon: Icon(Icons.mail),
                  //hintText: 'Enter Email',
                  labelText: 'Score',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {},
                    child: const SizedBox(
                        height: 45,
                        width: 80,
                        child: Center(child: Text('Insert')))),
                ElevatedButton(
                    onPressed: () async {},
                    child: const SizedBox(
                        height: 45,
                        width: 80,
                        child: Center(child: Text('Update')))),
                ElevatedButton(
                    onPressed: () async {},
                    child: const SizedBox(
                        height: 45,
                        width: 80,
                        child: Center(child: Text('Delete')))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //color: Colors.red,
                height: 400,
                child: StreamBuilder<List<Student>>(
                    stream: readStudent(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const Text('Something went wrong!');
                      } else if (snapshot.hasData) {
                        final students = snapshot.data!;
                        return ListView(
                            children: students.map(builderStudent).toList());
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builderStudent(Student student) => Card(
        child: Row(
          children: [
            Text(student.id),
            Text(student.name),
            Text(student.gender),
            Text(student.score),
          ],
        ),
      );
  Stream<List<Student>> readStudent() => FirebaseFirestore.instance
      .collection('student')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
}

class Student {
  String id;
  final String name;
  final String gender;
  final String score;
  Student({
    this.id = '',
    required this.name,
    required this.gender,
    required this.score,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'score': score,
      };
  static Student fromJson(Map<String, dynamic> json) => Student(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      score: json['score']);
}
