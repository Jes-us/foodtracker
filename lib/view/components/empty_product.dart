import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodtracker/view/constants.dart';

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({
    super.key,
    required this.offset,
  });

  final double offset;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset, offset),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //Card in the list
          Expanded(
            flex: 4,
            child: FittedBox(
              child: DottedBorder(
                color: Theme.of(context).colorScheme.onSurface,
                borderType: BorderType.RRect,
                radius: Radius.circular(10.0),
                borderPadding: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                dashPattern: [6, 6],
                strokeWidth: 1,
                child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            kemptyProductfilling,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          //End Card in the grid
          Flexible(
            flex: 1,
            child: Row(children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 6,
                child: DottedBorder(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10.0),
                  borderPadding: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(2.0),
                  dashPattern: [6, 6],
                  strokeWidth: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                              child: Text(
                                '            ',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                        ]),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ]),
          ),
          Flexible(
            flex: 1,
            child: FittedBox(
              child: Text(
                kemptyProduct,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
