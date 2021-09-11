import 'package:async_example_saegis/auth_controller.dart';
import 'package:async_example_saegis/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _title = 'ABC';

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

    setState(() {
      _title = 'New Name';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthController().signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            icon: Icon(Icons.logout),
          )
        ],
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
