import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class EventCard extends StatefulWidget {
  String Event = '';
  String About = '';



  int CardColor;
  EventCard(
      {required this.Event,
      required this.About,


      required this.CardColor});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    var h, w;
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Container(
      height: 300 * h / 640,
      margin: EdgeInsets.only(right: 10.0 * w / 360, left: 10.0 * w / 360),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.5),
          spreadRadius: 5 * w / 360,
          blurRadius: 7 * w / 360,
          offset: Offset(0, 4),
        )
      ], color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          Container(
            height: 35 * h / 640,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Color.fromARGB(255, 206, 0, 0),
            ),
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.all(6.0 * w / 360),
              child: Center(
                child: Text(widget.Event,
                    style: GoogleFonts.poppins(
                        fontSize: 20 * w / 360, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.only(left: 15 * w / 360),
                child: Text(
                  'Healthy recommendation:',
                  style: GoogleFonts.openSans(
                      fontSize: 14 * w / 360, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0 * w / 360, bottom: 15.0 * w / 360),
                child: Text(
                  widget.About,
                  style: GoogleFonts.openSans(
                    color: Color.fromARGB(255, 59, 15, 15) ,
                      fontSize: 15 * w / 360, fontWeight: FontWeight.w700),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
