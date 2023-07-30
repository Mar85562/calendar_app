import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Shared/components/components.dart';
import 'Shared/components/constants.dart';

class Tests extends StatefulWidget {
  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  final pageController = PageController();
  bool today = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Calendar',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              color: HexColor('#C8D7DE'),
            ),
          ),
        ),
        backgroundColor: HexColor('#2A3F47'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: HexColor('#586B74'),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.all(15.0),
                height: 60.0,
                width: double.infinity,
                color: HexColor('#3D5058'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if ((monthCounter) == 0) {
                            monthCounter = 11;
                            year--;
                          } else {
                            monthCounter--;
                          }
                          // getGridList(year: year, month: monthCounter, context: context);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                      color: HexColor("#CCDCE3"),
                    ),
                    Text(
                      // '${months[monthCounter]} $year',
                      '${months[monthCounter]} ${year}',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: HexColor('#CCDCE3'),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if ((monthCounter) == 11) {
                            monthCounter = 0;
                            year++;
                          } else {
                            monthCounter++;
                          }
                          // getGridList(year: 2023, month: 13, context: context);
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      color: HexColor("#CCDCE3"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, index) => GridView.builder(
                          itemCount: getGridList(
                            year: year,
                            month: monthCounter + 1,
                            context: context,
                          ).length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 12.5,
                            mainAxisExtent: 80.0,
                            childAspectRatio: 0.75,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            right: 10.0,
                            left: 10.0,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if(today == true) {
                              today = false;
                              return getGridList(
                                  year: DateTime.now().year,
                                  month: DateTime.now().month,
                                  context: context,
                                  isReminder: false,
                                  reminderText: 'Reminder')[index];
                            } else {
                              return getGridList(
                                  year: year,
                                  month: monthCounter + 1,
                                  context: context,
                                  isReminder: true,
                                  reminderText: 'Reminder')[index];
                            }
                          },
                        ),
                    onPageChanged: (pageIndex) {
                      setState(() {
                        if ((monthCounter) == 0) {
                          monthCounter = 11;
                          year--;
                        } else {
                          monthCounter--;
                        }
                        // getGridList(year: year, month: monthCounter, context: context);
                      });
                      print(pageIndex);
                    }),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      today = true;
                    });
                  },
                  child: const Text(
                    'Go To Today',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// GridView.builder(
//   itemCount: getGridList(
//     year: year,
//     month: monthCounter + 1,
//     context: context,
//   ).length,
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 7,
//     crossAxisSpacing: 5.0,
//     mainAxisSpacing: 12.5,
//     mainAxisExtent: 80.0,
//     childAspectRatio: 0.75,
//   ),
//   padding: const EdgeInsets.only(
//     bottom: 10.0,
//     right: 10.0,
//     left: 10.0,
//   ),
//   shrinkWrap: true,
//   itemBuilder: (context, index) => getGridList(
//       year: year,
//       month: monthCounter + 1,
//       context: context,
//       isReminder: true,
//       reminderText: 'Reminder')[index],
// ),
