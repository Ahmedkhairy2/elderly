
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/treatment_screens/hoem_user_screen.dart';

class EventCardHome extends StatefulWidget {
  String eventText;
  String timing;
  String Location;
  String description;
  EventCardHome(this.Location, this.eventText, this.timing, this.description);

  @override
  State<EventCardHome> createState() => _EventCardHomeState();
}

class _EventCardHomeState extends State<EventCardHome> {
  @override
  var h, s, w;

  Widget build(BuildContext context) {
    s = MediaQuery.of(context).size;
    h = s.height;
    w = s.width;
    return Container(
      height: 170 * h / 640,
      width: 150 * w / 360,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10 * w / 360),
          border: Border.all(
              color: Color.fromARGB(255, 224, 0, 0), width: 4 * w / 360)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.eventText,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 17 * w / 360),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 9 * w / 360,
              ),
              Icon(
                Icons.access_time_filled_outlined,
                color: Color.fromARGB(255, 207, 0, 0),
                size: 20 * h / 640,
              ),
              SizedBox(
                width: 6 * w / 360,
              ),
              Text(
                widget.timing,
                style: GoogleFonts.lato(
                  fontSize: 14 * w / 360,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 9 * w / 360,
              ),
              Icon(
                Icons.location_on_sharp,
                size: 20 * h / 640,
                color: Color.fromARGB(255, 209, 0, 0),
              ),
              SizedBox(
                width: 6 * w / 360,
              ),
              Text(
                widget.Location,
                style: GoogleFonts.lato(
                  fontSize: 14 * w / 360,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 13 * w / 360),
          )
        ],
      ),
    );
  }
}

class GradientCard extends StatefulWidget {
  const GradientCard({super.key});

  @override
  State<GradientCard> createState() => _GradientCardState();
}

class _GradientCardState extends State<GradientCard> {
  @override
  var h, s, w;

  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    s = MediaQuery.of(context).size;
    h = s.width;
    w = s.width;
    return Container(
      child: Column(
        children: [
          Center(
              child: Text("Health",
                  style: GoogleFonts.montserrat(
                      fontSize: 26 * w / 360,
                      fontWeight: FontWeight.w600,
                      color: Colors.white))),
          Text("Schedule your medication",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 20 * w / 360,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .collection("Health")
                        .get()
                        .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeUserScreen()))
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HealthPage(
                            //               HealthRef: value,
                            //             )))
                            );
                  },
                  child: Text("Click Here!  ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 20 * w / 360,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 155, 0, 0)))),
              Text("To manage your health",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 15 * w / 360,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ],
          ),
        ],
      ),
      height: 179 * h / 640,
      width: 320 * w / 360,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5 * w / 360),
            spreadRadius: w / 90,
            blurRadius: w / 110,
            offset: Offset(0, w / 130),
          ),
        ],
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 190, 158, 88), Color(0xff6BB2E7)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          // tileMode: TileMode.repeated,
        ),
        borderRadius: BorderRadius.circular(10 * w / 360),
      ),
    );
  }
}
