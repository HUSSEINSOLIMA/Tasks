import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class allPosts extends StatelessWidget {
  var titleContoller1 = TextEditingController();
  var descripationContoller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 156, 155, 155),
        title: const Center(
          child: Text(
            'All posts',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                isThreeLine: true,
                title: Text(document['title']),
                subtitle: Text(
                  document['descripton'],
                ),
                dense: true,
                trailing: IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('posts')
                        .doc(document.id)
                        .delete();
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
