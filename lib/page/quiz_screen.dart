import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_quiz/model/quiz.dart';
import 'package:my_quiz/repo/repo.dart';

import 'widget/option_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

List<NormalModel>? data;

class _QuizScreenState extends State<QuizScreen> {
  int QuestionIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    final screenWidth = screenSize.size.width;
    final screenHeight = screenSize.size.height;

    if (data == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      final currentQuestion = data![QuestionIndex];
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
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
            children: [
              SizedBox(height: screenHeight * 0.05),
              Opacity(
                opacity: 0.7,
                child: Image.asset(
                  "assets/idea.png",
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.4,
                ),
              ),
              Container(
                height: screenHeight * 0.25,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.015),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
                  border: Border.all(color: Colors.black),
                  color: const Color.fromARGB(255, 229, 234, 242),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  currentQuestion.description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.4,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    final isSelected = _selectedIndex == index;
                    final showGreen = isSelected && option.isCorrect;
                    final showRed = isSelected && !option.isCorrect;

                    return CustomOption(
                      option: option.description,
                      borderColor: showGreen
                          ? Colors.green
                          : showRed
                              ? Colors.red
                              : Colors.black,
                      onTap: () {
                        _answerQuestion(option.isCorrect, index);
                      },
                    );
                  },
                ),
              ),
              if (_isAnswered)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05, color: Colors.white),
                  ),
                ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      );
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.blue.shade400,
        title: const Text(
          'Quiz Completed',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Your score is $_score/${data?.length ?? 0}',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                QuestionIndex = 0;
                _score = 0;
                _selectedIndex = null;
                _isAnswered = false;
              });
            },
            child: const Text(
              'Restart',
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    try {
      data = await ApiRepo.getData(context);
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _answerQuestion(bool isCorrect, int index) {
    if (_isAnswered) {
      return;
    }
    setState(() {
      _selectedIndex = index;
      _isAnswered = true;
      if (isCorrect) _score++;
    });
  }

  void _nextQuestion() {
    if (QuestionIndex < (data?.length ?? 1) - 1) {
      setState(() {
        QuestionIndex++;
        _selectedIndex = null;
        _isAnswered = false;
      });
    } else {
      _showResultDialog();
    }
  }
}
