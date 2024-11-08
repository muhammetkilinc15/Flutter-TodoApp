import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/Constraints/colors.dart';
import 'package:todoapp/Models/todo_model.dart';
import 'package:todoapp/Widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> foundTodo = [];
  final _searchController = TextEditingController();
  final _todoController = TextEditingController();

  @override
  void initState() {
    foundTodo = todoList;
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            SearchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: const Text(
                      "All todos",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  for (Todo todo in foundTodo.reversed)
                    TodoItem(
                      todo: todo,
                      onTodoChange: _handleTodoChange,
                      deleteTodo: _deleteTodo,
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            // Türkçe ve Latin karakterlere izin veren regex
                            RegExp(r'[a-zA-ZçÇğĞıİöÖşŞüÜ\s]'),
                          ),
                        ],
                        controller: _todoController,
                        decoration: const InputDecoration(
                          hintText: 'Add new task',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed:  (){
                        _addTodo(_todoController.text);
                      },
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue, minimumSize: Size(60, 60)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

void _runFilter(String searchText){
    List<Todo> results = [];
    if(searchText.isEmpty){
      results = todoList;
    }else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

    setState(() {
      foundTodo = results;
    });
}


  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void _addTodo(String todoText) {
    setState(() {
      todoList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todoText));
    });
    _todoController.clear();
  }


  // Widget olarak ayırdık
  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => _runFilter(value),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            // Türkçe ve Latin karakterlere izin veren regex
            RegExp(r'[a-zA-ZçÇğĞıİöÖşŞüÜ\s]'),
          ),
        ],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 35,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.png')),
          )
        ],
      ),
      backgroundColor: tdBgColor,
    );
  }
}
