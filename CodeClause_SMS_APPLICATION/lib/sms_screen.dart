import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SMSScreen extends StatefulWidget {
  @override
  State<SMSScreen> createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  TextEditingController _numberController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  List<String> _recipients = [];

  void _sendSMS() async {
    String message = _messageController.text;
    List<String> recipents = _recipients;

    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });

    print(_result);
  }

  void _addRecipient() {
    setState(() {
      _recipients.add(_numberController.text);
      _numberController.clear();
    });
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
              IconButton(
                onPressed: () {},
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
                      "SMS App",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 25),
                    label("Mobile Number"),
                    SizedBox(height: 12),
                    mobileNumber(),
                    SizedBox(height: 30),
                    label("Message"),
                    SizedBox(height: 12),
                    Message(),
                    SizedBox(height: 25),
                    button("Add Recipient"),
                    SizedBox(height: 12),
                    button("Send Message"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {
        if (text == "Add Recipient") {
          _addRecipient();
        } else {
          _sendSMS();
        }
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
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Message() {
    return Container(
      height: 145,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _messageController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Message",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          prefixIcon: Icon(Icons.message),
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
      ),
    );
  }

  Widget mobileNumber() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _numberController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Mobile Number",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          prefixIcon: Icon(Icons.phone),
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
        keyboardType: TextInputType.phone,
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
