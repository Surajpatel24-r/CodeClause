import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeclause_todo_appication/screens/todoHomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTodoData extends StatefulWidget {
  ViewTodoData({super.key, required this.document, required this.id});
  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewTodoData> createState() => _ViewTodoDataState();
}

class _ViewTodoDataState extends State<ViewTodoData> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String type = "";
  String category = "";
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.document["title"]);
    _descriptionController =
        TextEditingController(text: widget.document["description"]);
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: edit ? Colors.green : Colors.white,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showMyDialog();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Editing" : "View",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your Todo",
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
                        categorySelect("Food", 0xffff6d6e),
                        SizedBox(width: 20),
                        categorySelect("WorkOut", 0xfff29732),
                        SizedBox(width: 20),
                        categorySelect("Work", 0xff6557ff),
                        SizedBox(width: 20),
                        categorySelect("Design", 0xff234ebd),
                        SizedBox(width: 20),
                        categorySelect("Run", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 50),
                    edit ? button() : Container(),
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff1d1e26),
          title: Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                'DELETE',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Are you sure you want to delete this item?',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Todo")
                    .doc(widget.id)
                    .delete()
                    .then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoHomeScreen(),
                        )));
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").doc(widget.id).update({
          "title": _titleController.text,
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
          child: Text("Update Todo"),
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
        enabled: edit,
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
      onTap: edit
          ? () {
              setState(() {
                type = lable;
              });
            }
          : null,
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
      onTap: edit
          ? () {
              setState(() {
                category = lable;
              });
            }
          : null,
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
        controller: _titleController,
        enabled: edit,
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
