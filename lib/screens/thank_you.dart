import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confess_feature_suggestions/constants.dart';
import 'package:confess_feature_suggestions/screens/write_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({Key? key}) : super(key: key);
  static const routeName = 'thank_you';

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  RiveAnimationController? _controller;
  Artboard? _riveArtBoard;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/animations/hiya-georgie.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        // ignore: cascade_invocations
        artboard.addController(_controller = SimpleAnimation('fadein'));
        setState(() => _riveArtBoard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GlobalVariables.blackColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 0.40 * height,
                width: double.infinity,
                child: _riveArtBoard == null
                    ? const SizedBox()
                    : Rive(
                        artboard: _riveArtBoard!,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: height * 0.10,
              ),
              DefaultTextStyle(
                style: GlobalVariables.textStyle,
                textAlign: TextAlign.center,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Thanks for your\n  valuable suggestions :-)',
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: WriteSuggestion(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                child: const Text(
                  'Suggest Again',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: GlobalVariables.whiteColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Text(
                'Made by Sachin Dapkara',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  color: GlobalVariables.whiteColor.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
