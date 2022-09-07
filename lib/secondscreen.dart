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
                color: Colors.red,
                height: 400,
                child: FutureBuilder(
                  future: varInit,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something was worng..');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading data...');
                    }
                    return ListView.builder(
                        itemCount: docIds.length,
                        itemBuilder: (context, index) {
                          return getStudent(documentId: docIds[index]);
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
