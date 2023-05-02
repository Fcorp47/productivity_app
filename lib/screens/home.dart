import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Login/login.dart';
import 'package:flutter_todo_app/screens/appbar.dart';
import 'package:flutter_todo_app/screens/imptask.dart';
import 'package:flutter_todo_app/screens/mydrawer.dart';
import 'package:flutter_todo_app/screens/option_cards.dart';
import 'package:flutter_todo_app/screens/waterintake.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var user = FirebaseAuth.instance.currentUser;
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

//here is delete function
  Future<void> deleteUser(id){
    // print("User Deleted $id");
    return tasks
        .doc(id)
        .delete()
        .then((value) => print('User deleted'))
        .catchError((error) => print('Failed to delte user: $error'));
  }


  Future<void> updateUser(id,statuss) {
    var status='';
    if(statuss=='1')
      {
        status = '0';
      }
    else{
      status = '1';
    }
   /* return tasks.doc(id)
        .update({'task': _todoController.text,'email':emailid,'status':status})
        .catchError((error) => print("failed to update user: $error"));*/
    return tasks.doc(id)
        .update({'status':status})
        .catchError((error) => print("failed to update user: $error"));
  }


  final status=1;
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  String emailid = FirebaseAuth.instance.currentUser!.email.toString();



  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> taskStream = FirebaseFirestore.instance.collection('tasks')
        .where("email",isEqualTo: emailid).snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: taskStream,
        builder:
            (BuildContext context,
            AsyncSnapshot<QuerySnapshot>snapshot) {
              if (snapshot.hasError) {
                print('Something went wrong !!');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
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

              return Scaffold(
                drawer: my_drawer(context),
                backgroundColor: Colors.grey,
                appBar: myappbar(),
                body: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          searchBox(),
                          Expanded(
                            child: ListView(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                      top: 50,
                                      bottom: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'TASK LIST',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )),


                                //for loop iterate the whole tasks....

                                // for (ToDo todoo in _foundToDo.reversed)

                                for(var i = 0; i < storedocs.length; i++)...[

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: ListTile(

                                      onTap: () {

                                          updateUser(storedocs[i]['id'],storedocs[i]['status']);
                                         // Navigator.pop(context);


                                        // onToDoChanged(todo);
                                      },

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      tileColor: Colors.black,
                                      leading: Icon(
                                        storedocs[i]['status']=="0" ? Icons.check_box : Icons.check_box_outline_blank,
                                        color: Colors.white,
                                      ),


                                      title: Text(

                                        storedocs[i]['task'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          ),
                                      ),
                                      trailing: Container(
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 12),
                                        height: 35,
                                        width: 35,

                                        child: IconButton(
                                          color: Colors.red,
                                          iconSize: 25,
                                          icon: Icon(Icons
                                              .remove_circle_outline_sharp),
                                          onPressed: () {
                                            deleteUser(storedocs[i]['id']);
                                          },
                                        ),
                                      ),
                                    ),
                                  )

                                ]
                              ],
                            ),

                            //for loop ends here  --- remark
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                              right: 20,
                              left: 20,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.red,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _todoController,
                              decoration: InputDecoration(
                                  hintText: 'Add a new task',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                          ),
                          child: ElevatedButton(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onPressed: () {
                              _addToDoItem(_todoController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: Size(10, 10),
                              elevation: 20,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              );
            });
  }



  Future<void> addUser() {
    //print("User Added");
    return tasks
        .add({'task': _todoController.text,'email': '${user!.email}','status':status})
        .then((value) => print('Task added!!'))
        .catchError((error) => print('Failed to add: $error'));
  }

  AppBar myappbar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${user!.email}', style: TextStyle(fontSize: 10)),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              child: Image.asset('assets/images/login.jpg'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ),
      ]),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    addUser();
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}
