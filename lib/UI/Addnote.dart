import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';

class Addnote extends StatefulWidget {
  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Add Note",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
      ),
      body: Container(
        //margin: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Do You Want to Write About It",
              style: TextStyle(
                  color: Color(midnightBlue),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  focusColor: Color(midnightBlue),
                  hoverColor: Color(midnightBlue),
                  hintStyle: TextStyle(
                    color: Color(midnightBlue),
                  ),
                  hintText: "Add Notes",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(midnightBlue)),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(midnightBlue)),
                    gapPadding: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(midnightBlue)),
                    gapPadding: 10,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
