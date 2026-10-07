import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
String display = "";
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int open=0;
  String display = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    display,
                    style: TextStyle(
                      fontFamily: "Nothing",
                      color: Colors.white,
                      fontSize: 48,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        calcButton("AC"),
                        calcButton("( )"),
                        calcButton("%"),
                        calcButton("÷"),
                      ],
                    ),
                    Row(
                      children: [
                        calcButton("7"),
                        calcButton("8"),
                        calcButton("9"),
                        calcButton("×"),
                      ],
                    ),
                    Row(
                      children: [
                        calcButton("4"),
                        calcButton("5"),
                        calcButton("6"),
                        calcButton("−"),
                      ],
                    ),
                    Row(
                      children: [
                        calcButton("1"),
                        calcButton("2"),
                        calcButton("3"),
                        calcButton("+"),
                      ],
                    ),
                    Row(
                      children: [
                        calcButton("0"),
                        calcButton("."),
                        backspace(),
                        calcButton("="),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget backspace(){
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if(display.isNotEmpty){
                display =display.substring(0, display.length - 1);
              }
            });
          },
          style: buttonStyle("back"),
          child: const Icon(
            size: 28,
            Icons.backspace,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget calcButton(String text) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child : Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if(text=='AC'){
                display = "";
              }else if(text=='( )'){
                if(open==0){
                  display = display + '(';
                  open++;
                }else{
                  display = display + ')';
                  open--;
                }
              }else if(text=='='){
                try {
                  String expression = display
                      .replaceAll('×', '*')
                      .replaceAll('÷', '/')
                      .replaceAll('−', '-');

                  Parser p = Parser();
                  Expression exp = p.parse(expression);
                  double result = exp.evaluate(EvaluationType.REAL, ContextModel());

                  display = result.toString();
                } catch(e) {
                  display = "Error";
                }
              }
              else {
                display = display + text;
              }
            });
          },
          style: buttonStyle(text),
          child: Text(text),
        ),
      ),
      ),
    );
  }

  ButtonStyle buttonStyle(String text) {
    if(text=="AC" || text =="="){
      return ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.grey[900],
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(25),
        textStyle: const TextStyle(
          fontSize: 28,
          fontFamily: 'Nothing',
        ),
      );
    }
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(25),
      textStyle: const TextStyle(
        fontSize: 30,
        fontFamily: 'Nothing',
      ),
    );
  }
}