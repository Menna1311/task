import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentMonthYearWidget extends StatefulWidget {
  @override
  _CurrentMonthYearWidgetState createState() => _CurrentMonthYearWidgetState();
}

class _CurrentMonthYearWidgetState extends State<CurrentMonthYearWidget> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    // Format the current month
    String currentMonth =
        DateFormat('MMM').format(DateTime(selectedYear, selectedMonth));

    // Format the current year
    String currentYear = selectedYear.toString();

    return GestureDetector(
      onTap: () => _showMonthYearPicker(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentMonth,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(',',
              style: TextStyle(
                fontSize: 30,
              )),
          Text(
            currentYear,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMonthYearPicker(BuildContext context) async {
    final pickedYear = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Year'),
          content: Container(
            width: double.minPositive,
            height: 300,
            child: ListView.builder(
              itemCount: 61, // 1970 to 2030
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text((index + 1970).toString()),
                  onTap: () => Navigator.of(context).pop(index + 1970),
                );
              },
            ),
          ),
        );
      },
    );

    if (pickedYear != null) {
      final pickedMonth = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Month'),
            content: Container(
              width: double.minPositive,
              height: 300,
              child: ListView.builder(
                itemCount: 12, // 1 to 12
                itemBuilder: (context, index) {
                  final month = index + 1;
                  return ListTile(
                    title: Text(
                        DateFormat('MMM').format(DateTime(pickedYear, month))),
                    onTap: () => Navigator.of(context).pop(month),
                  );
                },
              ),
            ),
          );
        },
      );

      if (pickedMonth != null) {
        setState(() {
          selectedYear = pickedYear;
          selectedMonth = pickedMonth;
        });
      }
    }
  }
}
