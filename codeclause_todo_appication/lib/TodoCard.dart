import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.iconBgColor,
    required this.index,
  }) : super(key: key);
  // {
  //   time = DateTime.now();
  // }

  final String title;
  final IconData iconData;
  final Color iconColor;
  final DateTime time;
  final Color iconBgColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String formattedTime = DateFormat.jm().format(time);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Container(
                      height: 29,
                      width: 32,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(iconData, color: iconColor),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
