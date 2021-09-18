import 'package:async_example_saegis/auth_controller.dart';
import 'package:async_example_saegis/login.dart';
import 'package:async_example_saegis/shared_pref_helper.dart';
import 'package:async_example_saegis/user_list.dart';
import 'package:async_example_saegis/value_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'add_user.dart';

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

  _showSharedPref() async {
    var number = await SharedPreferencesHelper.getValues(key: 'INT', dataType: DateTypeEnum.Integer);
    var text = await SharedPreferencesHelper.getValues(key: 'STRING', dataType: DateTypeEnum.String);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Firebase'),
            ),
            ListTile(
              title: const Text('Shared Preferences'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ValuesForm()),
                );
              },
            ),
            ListTile(
              title: const Text('Firestore'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersList()),
                );
              },
            ),
            ListTile(
              title: const Text('Add User'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUser()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Click Me'),
          onPressed: _showSharedPref,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
