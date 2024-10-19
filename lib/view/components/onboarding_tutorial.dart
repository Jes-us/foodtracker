import 'package:foodtracker/view/components/screen_size.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:foodtracker/view_model/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:foodtracker/view/constants.dart';

class OnboardingTutorial {
  OnboardingTutorial({
    required this.context,
    required this.themeChanger,
    required this.scannerButton,
  });

  final BuildContext context;
  final GlobalKey themeChanger;
  final GlobalKey scannerButton;
  TutorialService tutorialService = TutorialService();
  late TutorialCoachMark tutorialCoachMark;

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Color(0xFFF05833),
      alignSkip: Alignment.bottomCenter,
      paddingFocus: 10,
      hideSkip: true,
      opacityShadow: 0.0,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        //   print("finish");
      },
      onClickTarget: (target) {
        //  print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        // print("target: $target");
        //print(
        //    "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        //print('onClickOverlay: $target');
      },
      onSkip: () {
        //  print("skip");
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    double screenwidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0.0;
    double screenHeigh = ScreenSizeProvider.of(context)?.screenWidth ?? 0.0;
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: kidentify1,
        keyTarget: themeChanger,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.all(10),
            builder: (context, controller) {
              return Container(
                height: screenHeigh * 0.2,
                width: screenwidth * 0.5,
                decoration: BoxDecoration(
                  color: Color(0xFFF05833),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      ktutorialDesc1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: kidentify2,
        keyTarget: scannerButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.all(10),
            builder: (context, controller) {
              return Container(
                height: screenHeigh * 0.6,
                width: screenwidth * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xFFF05833),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: screenwidth * 0.3,
                        width: screenwidth * 0.3,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(ktutorialImg4)),
                    Text(
                      ktutorialDesc2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: kidentify3,
        keyTarget: scannerButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.all(10),
            builder: (context, controller) {
              return Container(
                height: screenHeigh * 0.9,
                width: screenwidth * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xFFF05833),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: screenwidth * 0.5,
                        width: screenwidth * 0.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(ktutorialImg1)),
                    Text(
                      ktutorialDesc3,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: kidentify4,
        keyTarget: scannerButton,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.all(10),
            builder: (context, controller) {
              return Container(
                height: screenHeigh * 0.6,
                width: screenwidth * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xFFF05833),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: screenwidth * 0.4,
                            width: screenwidth * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(ktutorialImg2),
                          ),
                          Container(
                              padding: EdgeInsets.all(5),
                              height: screenwidth * 0.4,
                              width: screenwidth * 0.4,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(ktutorialImg3))
                        ]),
                    Spacer(),
                    Text(
                      ktutorialDesc4,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}
