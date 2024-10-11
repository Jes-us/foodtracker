import 'package:flutter/material.dart';

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
                    'Better before',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                child: Text(
                                  DateTime.parse(text).day.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: FittedBox(
                                child: Text(
                                  _getMonth(
                                      DateTime.parse(text).month.toString()),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: RotatedBox(
                          quarterTurns: 3,
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
        nameMonth = 'ENE';
        return nameMonth;
      }

    case "2":
      {
        nameMonth = 'FEV';
        return nameMonth;
      }

    case "3":
      {
        nameMonth = 'MAR';
        return nameMonth;
      }

    case "4":
      {
        nameMonth = 'ABR';
        return nameMonth;
      }

    case "5":
      {
        nameMonth = 'MAY';
        return nameMonth;
      }

    case "6":
      {
        nameMonth = 'JUN';
        return nameMonth;
      }

    case "7":
      {
        nameMonth = 'JUL';
        return nameMonth;
      }

    case "8":
      {
        nameMonth = 'ADO';
        return nameMonth;
      }

    case "9":
      {
        nameMonth = 'SEP';
        return nameMonth;
      }

    case "10":
      {
        nameMonth = 'OCT';
        return nameMonth;
      }

    case "11":
      {
        nameMonth = 'NOV';
        return nameMonth;
      }

    case "12":
      {
        nameMonth = 'DIC';
        return nameMonth;
      }
  }
  return nameMonth;
}
