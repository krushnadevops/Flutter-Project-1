import 'package:flutter/material.dart';
import 'package:todo6/models/todo_model.dart';
import 'package:todo6/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Todo> todos = [];

  void addTodo() {
    if(controller.text.trim().isEmpty) return;

    setState(() {
      todos.add(Todo(title: controller.text));
      controller.clear();
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To Do'),),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                  controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter Task',
                      border: OutlineInputBorder(),
                    ),
                ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: addTodo, child: Text('Add'),),
              ],
            ),
          ),
          Expanded(
              child: todos.isEmpty
                  ? Center(child: Text('No Task Added'),)
                  : ListView.builder(
                itemCount: todos.length,
                  itemBuilder: (context, index) {
                  return TodoItem(
                      todo: todos[index],
                      onToggle: () => toggleTodo(index),
                      onDelete: () => deleteTodo(index)
                  );
                  },
              )
            ,
          ),
        ],
      ),
    );
  }
}
