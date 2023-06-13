import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/todo_item.dart';

import 'package:todo_app/models/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> foundToDo = [];
  final _toDoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    foundToDo = todoList;
  }

  void _runFilter(String enteredKeyWord) {
    List<Todo> result = [];

    if (enteredKeyWord.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((todo) => todo.todoText!
              .toLowerCase()
              .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = result;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: const Text(
                        'All ToDo\'s',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: tdBlack,
                        ),
                      ),
                    ),
                    for (Todo todo in foundToDo)
                      ToDoItem(
                        todo: todo,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _onDeleteItem,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 40,
                  right: 20,
                  left: 20,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: face,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: const TextStyle(color: tdBlack),
                  controller: _toDoController,
                  decoration: const InputDecoration(
                    hintText: 'Add a New todo item',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: tdBlack,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40, right: 20),
              child: ElevatedButton(
                  onPressed: () => {_addToDoItem(_toDoController.text)},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  )),
            )
          ]),
        ),
      ]),
    );
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _onDeleteItem(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void _addToDoItem(String todoText) {
    setState(() {
      todoList.add(Todo(
        id: DateTime.now().toString(),
        todoText: todoText,
      ));
    });

    _toDoController.clear();
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      decoration: BoxDecoration(
        color: face,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => {_runFilter(value)},
        style: const TextStyle(color: tdBlack),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: tdBlack,
            )),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }
}
