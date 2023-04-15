import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeclause_todo_appication/screens/todoAddSceen.dart';
import 'package:codeclause_todo_appication/screens/view_todo_data.dart';
import 'package:flutter/material.dart';
import '../Service/Auth_Service.dart';
import '../TodoCard.dart';
import '../main.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  // List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Todo's Lists",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          SizedBox(width: 25),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.home,
              size: 28,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoAddScreen(),
                  ),
                );
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: InkWell(
              onTap: () async {
                await authClass.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => MyApp()),
                    (route) => false);
              },
              child: Icon(
                Icons.logout,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      // Reading a data to firebase firestore
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              IconData iconData;
              Color iconColor;
              Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              switch (document["category"]) {
                case "Work":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                case "WorkOut":
                  iconData = Icons.alarm;
                  iconColor = Colors.teal;
                  break;
                case "Food":
                  iconData = Icons.local_grocery_store;
                  iconColor = Colors.blue;
                  break;
                case "Design":
                  iconData = Icons.audiotrack;
                  iconColor = Colors.green;
                  break;
                case "Run":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                default:
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
              }
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewTodoData(
                        document: document,
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 3, left: 12, right: 12),
                  child: TodoCard(
                    title: document["title"],
                    iconData: iconData,
                    iconBgColor: Colors.white,
                    time: DateTime.now(),
                    iconColor: iconColor,
                    index: index,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
