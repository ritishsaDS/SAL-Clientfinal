import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/UI/MoodDoneScreen.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/data/repo/Addmoodrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddnoteRating extends StatefulWidget {
  final String moodId;

  const AddnoteRating({Key key, this.moodId}) : super(key: key);

  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<AddnoteRating> {
  Addmoodrepo addmoodrepo = Addmoodrepo();
  TextEditingController editingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    editingController.dispose();
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Would you like to write a bit about your appointment? Be rest assured, it stays between us",
                style: GoogleFonts.openSans(
                    color: Color(midnightBlue),
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                controller: editingController,
                style:GoogleFonts.openSans(fontSize: 15),
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
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            ),
            Expanded(
              child: SizedBox(),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xff0066B3),
                child: Text("Done"),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
