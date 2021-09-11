import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> threeSecondsDelay() async {
    await Future.delayed(Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preview 1'),
        ),
      );
    });
  }

  Future<int> fourSecondsDelay() async {
    int number = 0;
    await Future.delayed(Duration(seconds: 4), () {
      number = 1;
    });
    return number;
  }

  clickMe() async {
    // await threeSecondsDelay();
    int number = await fourSecondsDelay();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(number.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Async'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Click Me'),
          onPressed: clickMe,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
