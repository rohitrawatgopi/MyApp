import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_quiz/page/quiz_screen.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    final screenWidth = screenSize.size.width;
    final screenHeight = screenSize.size.height;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00C6FF),
                Color(0xFF0072FF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/onboard.png",
                  height: screenHeight * 0.3, width: screenWidth),
              Container(
                height: screenHeight * 0.45,
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 229, 234, 242),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Text(
                      "Learn Through Play!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Test your knowledge and earn rewards along the way!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        minimumSize:
                            Size(screenWidth * 0.6, screenHeight * 0.08),
                        backgroundColor:
                            const Color.fromARGB(255, 205, 219, 243),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen()),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.green,
                            size: screenWidth * 0.07,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
