import 'package:flutter/material.dart';
import 'package:foodtracker/view/constants.dart';

class CardText extends StatelessWidget {
  final String text;

  const CardText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.transparent),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    kbetterBeforeMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: Text(
                          _getMonth(DateTime.parse(text).month.toString()),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: RotatedBox(
                          quarterTurns: 4,
                          child: Text(
                            DateTime.parse(text).year.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

String _getMonth(String date) {
  String nameMonth = '?';

  switch (date) {
    case "1":
      {
        nameMonth = kmonth1;
        return nameMonth;
      }

    case "2":
      {
        nameMonth = kmonth2;
        return nameMonth;
      }

    case "3":
      {
        nameMonth = kmonth3;
        return nameMonth;
      }

    case "4":
      {
        nameMonth = kmonth4;
        return nameMonth;
      }

    case "5":
      {
        nameMonth = kmonth5;
        return nameMonth;
      }

    case "6":
      {
        nameMonth = kmonth6;
        return nameMonth;
      }

    case "7":
      {
        nameMonth = kmonth7;
        return nameMonth;
      }

    case "8":
      {
        nameMonth = kmonth8;
        return nameMonth;
      }

    case "9":
      {
        nameMonth = kmonth9;
        return nameMonth;
      }

    case "10":
      {
        nameMonth = kmonth10;
        return nameMonth;
      }

    case "11":
      {
        nameMonth = kmonth11;
        return nameMonth;
      }

    case "12":
      {
        nameMonth = kmonth12;
        return nameMonth;
      }
  }
  return nameMonth;
}
