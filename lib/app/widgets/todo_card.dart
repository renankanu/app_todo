import 'package:app_todo/app/models/todo.dart';
import 'package:app_todo/app/services/database.dart';
import 'package:app_todo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todo;
  final FirebaseFirestore firestore;
  final String uid;

  const TodoCard({Key key, this.todo, this.firestore, this.uid})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWildSand,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.todo.content,
                style: const TextStyle(
                  fontSize: 15,
                  color: kLuckyPoint,
                ),
              ),
            ),
            Checkbox(
              value: widget.todo.done,
              onChanged: (newValue) {
                setState(() {});
                Database(firestore: widget.firestore).updateTodo(
                  uid: widget.uid,
                  todoId: widget.todo.todoId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
