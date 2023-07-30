import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Shared/components/components.dart';
import '../Shared/components/constants.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class CalendarDesign extends StatefulWidget {
  @override
  State<CalendarDesign> createState() => _CalendarDesignState();
}

class _CalendarDesignState extends State<CalendarDesign> {

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: LinearGradient(
        colors: [HexColor("#0455BF"), HexColor("#1E69CB"), HexColor("#2D78DB"), HexColor("#438EF2"), HexColor("#74B0FF"),],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

      ),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Calendar',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              color: HexColor('#F9FCD2'),
            ),
          ),
        ),
        backgroundColor: HexColor('#0455BF'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! < 0) {
            // Left Swipe
            setState(() {
              if ((monthCounter) == 11) {
                monthCounter = 0;
                year++;
              } else {
                monthCounter++;
              }
              // getGridList(year: 2023, month: 13, context: context);
            });
          } else if (dragEndDetails.primaryVelocity! > 0) {
            //Right Swipe
            setState(() {
              if ((monthCounter) == 0) {
                monthCounter = 11;
                year--;
              } else {
                monthCounter--;
              }
              // getGridList(year: year, month: monthCounter, context: context);
            });
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: HexColor('#586B74'),
          child: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(15.0),
                  height: 60.0,
                  width: double.infinity,
                  color: HexColor('#74B0FF'),
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
                        color: HexColor("#000000"),
                      ),
                      Text(
                        // '${months[monthCounter]} $year',
                        '${months[monthCounter]} ${year}',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: HexColor('#000000'),
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
                        color: HexColor("#000000"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: getGridList(
                      year: year,
                      month: monthCounter + 1,
                      context: context,
                    ).length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    itemBuilder: (context, index) => getGridList(
                        year: year,
                        month: monthCounter + 1,
                        context: context,
                        isReminder: true,
                        reminderText: 'Reminder')[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
