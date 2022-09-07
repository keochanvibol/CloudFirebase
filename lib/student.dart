import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getStudent extends StatelessWidget {
  getStudent({Key? key, required this.documentId}) : super(key: key);
  String documentId;
  @override
  Widget build(BuildContext context) {
    CollectionReference stu = FirebaseFirestore.instance.collection('student');
    return FutureBuilder<DocumentSnapshot>(
        future: stu.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Card(
              child: ListTile(
                subtitle: Text(documentId),
                leading: Text(data['id'].toString()),
              ),
            );
          }
          return const ListTile(
            title: Text('loading.....'),
          );
        });
  }
}
