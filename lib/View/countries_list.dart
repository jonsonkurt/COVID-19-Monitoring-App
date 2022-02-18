import 'package:covid/Services/state_services.dart';
import 'package:covid/View/detail_screen.dart';
import 'package:covid/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScrren extends StatefulWidget {
  const CountriesListScrren({Key? key}) : super(key: key);

  @override
  _CountriesListScrrenState createState() => _CountriesListScrrenState();
}

class _CountriesListScrrenState extends State<CountriesListScrren> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBlueColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Enter Country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: kGreyColor,
                            highlightColor: kBlueColor,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  totalCase: snapshot
                                                      .data![index]['cases'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  test: snapshot.data![index]
                                                      ['tests'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                )));
                                  },
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data![index]['country'],
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: kWhiteColor),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]['cases']
                                          .toString()
                                          .replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => '${m[1]},'),
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: kWhiteColor),
                                    ),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  totalCase: snapshot
                                                      .data![index]['cases'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  test: snapshot.data![index]
                                                      ['tests'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                )));
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 80,
                                        width: 80,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
