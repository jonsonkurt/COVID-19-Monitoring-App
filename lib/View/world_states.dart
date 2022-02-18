import 'package:covid/Model/world_states_model.dart';
import 'package:covid/Services/state_services.dart';
import 'package:covid/View/countries_list.dart';
import 'package:covid/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  _WorldStatesState createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285D4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
    const Color(0xff7e5242)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    // fetchWorledStatesRecords
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('About the Application'),
                          content: const Text(
                            'Covid 19 Tracker is a mobile aplication that can be used to track the total cases, active cases and other related informations that can help the user in knowing the latest updates regarding the Covid-19 Virus. \nThis application was developed by Afable, Jairo Joaquin, a student of De La Salle University - Dasmariñas.',
                            textAlign: TextAlign.justify,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.info,
                        size: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CountriesListScrren()));
                      },
                      child: Icon(
                        Icons.public_rounded,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 135, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'COVID-19 Bulletin',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kWhiteColor),
                    ),
                    Text(
                      'Worldwide Status',
                      style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: kWhiteColor),
                    )
                  ],
                ),
              ),

              //fetch api
              FutureBuilder(
                  future: statesServices.fetchWorledStatesRecords(),
                  builder: (context, AsyncSnapshot<World_cases> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          //   Divider(),
                          Container(
                              height: 199,
                              child: ListView(
                                padding: EdgeInsets.only(left: 16, right: 6),
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 344,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 120,
                                          child: Text(
                                            'TOTAL NUMBER OF CASES',
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          top: 145,
                                          child: Text(
                                            snapshot.data!.cases
                                                .toString()
                                                .replaceAllMapped(
                                                    RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => '${m[1]},'),
                                            style: GoogleFonts.inter(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 30,
                                          child: Icon(
                                            Icons.coronavirus_outlined,
                                            size: 85,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kBlueColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(3.0,
                                              3.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 344,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 120,
                                          child: Text(
                                            'TOTAL NUMBER OF RECOVERIES',
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          top: 145,
                                          child: Text(
                                            snapshot.data!.recovered
                                                .toString()
                                                .replaceAllMapped(
                                                    RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => '${m[1]},'),
                                            style: GoogleFonts.inter(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 30,
                                          child: Icon(
                                            Icons
                                                .face_retouching_natural_rounded,
                                            size: 85,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kGreyColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 344,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 120,
                                          child: Text(
                                            'TOTAL NUMBER OF DEATHS',
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          top: 145,
                                          child: Text(
                                            snapshot.data!.deaths
                                                .toString()
                                                .replaceAllMapped(
                                                    RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => '${m[1]},'),
                                            style: GoogleFonts.inter(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 30,
                                          child: Image.asset(
                                            'images/deaths.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kBlueColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(3.0,
                                              3.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 150, bottom: 16, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'COVID-19 Safety Measures',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: kWhiteColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 123,
                              child: ListView(
                                padding: EdgeInsets.only(left: 16, right: 6),
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 135,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 85,
                                          child: Text(
                                            'Wear Facemask',
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: kBlueColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 10,
                                          child: Icon(
                                            Icons.masks,
                                            color: kBlueColor,
                                            size: 90,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(3.0,
                                              3.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 135,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 85,
                                          child: Text(
                                            'Distancing',
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 10,
                                          child: Icon(
                                            Icons.social_distance_rounded,
                                            color: kWhiteColor,
                                            size: 75,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(28),
                                        color: kGreyColor),
                                    // decoration: BoxDecoration(
                                    //   image: DecorationImage(
                                    //     image: AssetImage("images/doh.png"),
                                    //     // fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 135,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 85,
                                          child: Text(
                                            'Wash Hands',
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: kBlueColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 10,
                                          child: Icon(
                                            Icons.clean_hands_rounded,
                                            color: kBlueColor,
                                            size: 75,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(3.0,
                                              3.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 199,
                                    width: 135,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          top: 85,
                                          child: Text(
                                            'Get Vaccinated',
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: kWhiteColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 5,
                                          right: 5,
                                          top: 10,
                                          child: Image.asset(
                                            'images/vaccines.png',
                                            width: 74,
                                            height: 74,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kGreyColor,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 50, bottom: 16, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Emergency Hotlines in the Philippines',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: kWhiteColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 130,
                            child: ListView(
                              padding: EdgeInsets.only(left: 16, right: 6),
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 80,
                                  width: 135,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Positioned(
                                        left: 85,
                                        top: 20,
                                        child: Text(
                                          '02-894-COVID (02-894-26843)',
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                      Positioned(
                                        left: 130,
                                        top: 40,
                                        child: Text(
                                          'Department of Health',
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                      Positioned(
                                        top: 85,
                                        child: Text(
                                          snapshot.data!.cases
                                              .toString()
                                              .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5,
                                        right: 300,
                                        top: 15,
                                        child: Image.asset(
                                          'images/doh.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    color: kBlueColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(3.0,
                                            3.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 5),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 80,
                                  width: 135,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Positioned(
                                        left: 120,
                                        top: 20,
                                        child: Text(
                                          '(+63 2) 8790-2382',
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                      Positioned(
                                        left: 130,
                                        top: 40,
                                        child: Text(
                                          'Philippine Red Cross',
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                      Positioned(
                                        top: 85,
                                        child: Text(
                                          snapshot.data!.cases
                                              .toString()
                                              .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: kWhiteColor),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5,
                                        right: 300,
                                        top: 15,
                                        child: Image.asset(
                                          'images/redcross.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      color: kGreyColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
