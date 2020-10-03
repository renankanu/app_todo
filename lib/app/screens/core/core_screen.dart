import 'package:app_todo/app/models/todo.dart';
import 'package:app_todo/app/services/auth.dart';
import 'package:app_todo/app/services/database.dart';
import 'package:app_todo/app/widgets/todo_card.dart';
import 'package:app_todo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const CoreScreen({Key key, this.auth, this.firestore}) : super(key: key);
  @override
  _CoreScreenState createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kanu Todo"),
        centerTitle: true,
        actions: [
          IconButton(
            key: const ValueKey("signOut"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(auth: widget.auth).signOut();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: const ValueKey("addField"),
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: "Your task...",
                        suffixIcon: GestureDetector(
                          onTap: (){
                            if (_todoController.text != "") {
                              setState(() {
                                Database(firestore: widget.firestore).addTodo(
                                    uid: widget.auth.currentUser.uid,
                                    content: _todoController.text);
                                _todoController.clear();
                              });
                            }
                          },
                          child: const Icon(Icons.add, color: kLuckyPoint,),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Database(firestore: widget.firestore)
                  .streamTodos(uid: widget.auth.currentUser.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TodoModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data.isEmpty) {
                    return const Center(
                      child: Text("You don't have any unfinished Todos 😁"),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return TodoCard(
                        firestore: widget.firestore,
                        uid: widget.auth.currentUser.uid,
                        todo: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("loading..."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
