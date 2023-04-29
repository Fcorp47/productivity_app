import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

   ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> taskStream = FirebaseFirestore.instance.collection('tasks').snapshots();
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: taskStream,
        builder:
        (BuildContext context,
        AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong !!');
          }

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();


          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ListTile(
              onTap: () {
                // print('Clicked on Todo Item.');

                onToDoChanged(todo);
              },

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tileColor: Colors.black,
              leading: Icon(
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.white,
              ),
              title: Text(
                todo.todoText!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 12),
                height: 35,
                width: 35,

                child: IconButton(
                  color: Colors.red,
                  iconSize: 25,
                  icon: Icon(Icons.remove_circle_outline_sharp),
                  onPressed: () {
                    // print('Clicked on delete icon');
                    onDeleteItem(todo.id);
                  },
                ),
              ),
            ),

          );

        }
    );


  }
}
