import 'package:confess_feature_suggestions/constants.dart';
import 'package:confess_feature_suggestions/screens/thank_you.dart';
import 'package:confess_feature_suggestions/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';
import 'package:flutter/src/painting/gradient.dart' as gradient;

class WriteSuggestion extends StatefulWidget {
  const WriteSuggestion({Key? key}) : super(key: key);
  static const routeName = 'write_suggestion';

  @override
  State<WriteSuggestion> createState() => _WriteSuggestionState();
}

class _WriteSuggestionState extends State<WriteSuggestion> {
  RiveAnimationController? _controller;
  Artboard? _riveArtBoard;

  final _formkey = GlobalKey<FormState>();
  late String suggestion;
  final suggestionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/animations/plant-parent.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        // ignore: cascade_invocations
        artboard.addController(_controller = SimpleAnimation('Idle'));
        setState(() => _riveArtBoard = artboard);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    suggestionController.dispose();
  }

  void clearText() {
    suggestionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: gradient.LinearGradient(
          colors: [
            GlobalVariables.blueColor,
            GlobalVariables.pinkColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 0.33 * height,
                  width: double.infinity,
                  child: _riveArtBoard == null
                      ? const SizedBox()
                      : Rive(
                          artboard: _riveArtBoard!,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.75,
                        height: height * 0.23,
                        decoration: BoxDecoration(
                          color: GlobalVariables.whiteColor,
                          border: Border.all(
                            color: GlobalVariables.blackColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: const TextStyle(
                              color: GlobalVariables.blackColor,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              height: 1.3,
                            ),
                            maxLines: 7,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write your suggestions here...',
                              hintStyle: TextStyle(
                                color: GlobalVariables.greyColor,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              ),
                              errorStyle: TextStyle(
                                color: GlobalVariables.redColor,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            controller: suggestionController,
                            onChanged: (value) {
                              suggestion = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter suggestion!';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            ApiServices.sendSuggestion(suggestion: suggestion);
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: ThankYou(),
                                type: PageTransitionType.fade,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.blackColor,
                          side: const BorderSide(
                            color: GlobalVariables.whiteColor,
                            width: 3,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          minimumSize: Size(
                            width * 0.50,
                            height * 0.06,
                          ),
                        ),
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      const Text(
                        'Made by Sachin Dapkara',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10,
                          color: GlobalVariables.whiteColor,
                        ),
                      ),
                    ],
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
