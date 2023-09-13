import 'package:carousel_slider/carousel_slider.dart';
import 'package:elderr_app_project/screens/Chat/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elderr_app_project/widgets/bottom_nav_bar.dart';
import 'package:elderr_app_project/widgets/widgets_homepage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    'https://serving.photos.photobox.com/54075408e2bd0f361188aff8aa130a4f8b5db551dc778eba9d9c692b523819018234e0c2.jpg',
    'https://serving.photos.photobox.com/923452723a5b182bf62d630fad8f204d5120ab0e2fd1f83bbac3215000f08240fead11c3.jpg',
    'https://serving.photos.photobox.com/34706287933f1d96e51ebe33a155d982e93cea47ec0657dd0fbda120fce1889f4c4a78f7.jpg',
    'https://serving.photos.photobox.com/49469064d4b41e89c8756941c1379871ccd7b17807892c390905746fd7a7f7687cdc7031.jpg',
    'https://serving.photos.photobox.com/26532502644b81c3577f23b8930857aece42ac0dd80d86d42971e1174e42b91fce17ef10.jpg',
  ];

  @override
  var h, s, w;
  Widget build(BuildContext context) {
    s = MediaQuery.of(context).size;
    h = s.height;
    w = s.width;
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Home',
          style: GoogleFonts.montserrat(
              fontSize: 22 * w / 360,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 3,
        backgroundColor: Color.fromARGB(255, 206, 0, 0),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: urlImages.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = urlImages[index];
                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(
                      height: 422,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index))),
              SizedBox(height: 12),
              buildIndicator(),
              SizedBox(
                height: 10,
              ),
              GradientCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotWidth: 12, activeDotColor: Color.fromARGB(255, 206, 0, 0)),
        activeIndex: activeIndex,
        count: urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) =>
    Container(child: Image.network(urlImage, fit: BoxFit.cover));

void _showdialogue(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to Logout?"),
          actions: [
            TextButton(
                onPressed: () => FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginPage())))),
                child: Text("Yes")),
            TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => BottomNavBar()))),
                child: Text("No")),
          ],
        );
      });
}
