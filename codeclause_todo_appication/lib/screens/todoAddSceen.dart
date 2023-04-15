import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({super.key});

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String category = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1d1e26),
              Color(0xff252041),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "New Todo",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 25),
                    label("Task Title"),
                    SizedBox(height: 12),
                    title(),
                    SizedBox(height: 30),
                    label("Task Type"),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        taskSelect("Important", 0xff2664fa),
                        SizedBox(width: 20),
                        taskSelect("Planned", 0xff2bc8d9)
                      ],
                    ),
                    SizedBox(height: 25),
                    label("Description"),
                    SizedBox(height: 12),
                    description(),
                    SizedBox(height: 25),
                    label("Category"),
                    SizedBox(height: 12),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect("Design", 0xffff6d6e),
                        SizedBox(width: 20),
                        categorySelect("Run", 0xfff29732),
                        SizedBox(width: 20),
                        categorySelect("Work", 0xff6557ff),
                        SizedBox(width: 20),
                        categorySelect("Food", 0xff234ebd),
                        SizedBox(width: 20),
                        categorySelect("WorkOut", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 50),
                    button(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").add({
          "title": _taskController.text,
          "task": type,
          "description": _descriptionController.text,
          "category": category,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff2a2e3d),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Add Todo",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 145,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Description",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
      ),
    );
  }

  Widget taskSelect(String lable, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = lable;
        });
      },
      child: Chip(
        backgroundColor: type == lable ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          lable,
          style: TextStyle(
            color: type == lable ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 3.8),
      ),
    );
  }

  Widget categorySelect(String lable, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = lable;
        });
      },
      child: Chip(
        backgroundColor: category == lable ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          lable,
          style: TextStyle(
            color: category == lable ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 3.8),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _taskController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.1,
      ),
    );
  }
}
