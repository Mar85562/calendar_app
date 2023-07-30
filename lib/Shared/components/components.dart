import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:date_time_format/date_time_format.dart';

var monthCounter = DateTime.now().month - 1;
var year = DateTime.now().year;

Widget DayItem({
  required String day,
  String? reminder,
  bool isReminder = false,
  required BuildContext context,
  required int year,
  required int month,
  required int dayInt,
}){
  return Container(
    width: 150.0,
    height: 200.0,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: HexColor("#29527D"),
      border: Border.all(),
    ),
    child: MaterialButton(
      onPressed: () {
        if(isReminder) {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              children: [
                Container(
                  height: 30.0,
                  color: HexColor("#222C30"),
                ),
                Container(
                  padding:
                  const EdgeInsets.only(
                    top: 15.0,
                  ),
                  alignment: AlignmentDirectional.topCenter,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Text(
                    DateTimeFormat.format(DateTime(year, month, dayInt), format: AmericanDateFormats.dayOfWeekWithComma),
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#EDFFFC"),
                    ),
                  ),
                ),
                Text(
                  reminder!,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
            backgroundColor: HexColor('#334247'),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              children: [
                Container(
                  height: 30.0,
                  color: HexColor("#222C30"),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 15.0,
                  ),
                  alignment: AlignmentDirectional.topCenter,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Text(
                    DateTimeFormat.format(DateTime(year, month, dayInt), format: AmericanDateFormats.dayOfWeekWithComma),
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#EDFFFC"),
                    ),
                  ),
                ),
                const Text(
                  'No Reminders due for chosen date',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
            backgroundColor: HexColor('#334247'),

          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            day,
            style: TextStyle(
              color: HexColor("#FFFFFF"),
              fontSize: 12.5,
            ),
          ),
          Divider(
            color: HexColor("#FFFFFF"),
            thickness: 1.0,
          ),
          Text(
            reminder ?? '',
            style: TextStyle(
              fontSize: 10.0,
              color: HexColor("#FFFFFF"),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

Widget DayHeader({
  required String day,
}) {
  return Center(
    child: Text(
      day,
      style: TextStyle(
        fontSize: 19.0,
        color: HexColor('#D3E3EB'),
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget TodayItem({
  required String day,
  String? reminder,
  required bool isReminder,
  required BuildContext context,
}){
  isReminder = false;

  return Container(
    width: 150.0,
    height: 150.0,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: HexColor("#A0AAB1"),
      border: Border.all(),
    ),
    child: MaterialButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Text('Bottom Sheet Test'),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            day,
            style: TextStyle(
              color: HexColor("#04091D"),
              fontSize: 12.5,
            ),
          ),
          Divider(
            color: HexColor("#04091D"),
            thickness: 1.0,
          ),
          Text(
            reminder ?? '',
            style: TextStyle(
              fontSize: 10.0,
              color: HexColor("#04091D"),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

List<Widget> getGridList(
    {required int year,
    required int month,
    required BuildContext context,
    bool isReminder = false,
    String reminderText = ''}) {
  List<Widget> gridItems = [
    DayHeader(day: 'Sun'),
    DayHeader(day: 'Mon'),
    DayHeader(day: 'Tue'),
    DayHeader(day: 'Wed'),
    DayHeader(day: 'Thu'),
    DayHeader(day: 'Fri'),
    DayHeader(day: 'Sat'),
  ];

  var offset = DateUtils.firstDayOffset(
      year, month, const DefaultMaterialLocalizations());
  var daysInMonth = DateUtils.getDaysInMonth(year, month);
  bool isEmpty = true;

  for (int i = 0; i < offset; i++) {
    gridItems.add(Container());
  }

  isEmpty = false;

  for (int i = 0; i < daysInMonth; i++) {
    if (i + 1 == DateTime.now().day && month == DateTime.now().month && year == DateTime.now().year) {
      gridItems.add(TodayItem(
        day: '${DateTime(year, month, i + 1).day}',
        isReminder: isReminder,
        reminder: reminderText,
        context: context,
      ));
    } else {
      gridItems.add(DayItem(
        day: '${DateTime(year, month, i + 1).day}',
        isReminder: isReminder,
        reminder: reminderText,
        context: context,
        month: month,
        year: year,
        dayInt: i + 1,
      ));
    }
  }

  return gridItems;
}
