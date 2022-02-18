import 'package:covid/View/world_states.dart';
import 'package:covid/constants/color_constant.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCase,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen(
      {required this.name,
      required this.image,
      required this.totalCase,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: kBlueColor,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        height: 150,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(widget.image),
                        ),
                      ),
                      ReusableRow(
                          title: "Total Cases",
                          value: widget.totalCase.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},')),
                      ReusableRow(
                          title: "Deaths",
                          value: widget.totalDeaths.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},')),
                      ReusableRow(
                          title: "Active Cases",
                          value: widget.active.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},')),
                      ReusableRow(
                          title: "Total Recoveries",
                          value: widget.todayRecovered
                              .toString()
                              .replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},')),
                      ReusableRow(
                          title: "Recoveries Today",
                          value: widget.totalRecovered
                              .toString()
                              .replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},')),
                      ReusableRow(
                          title: "Test Conducted",
                          value: widget.test.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},')),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
