import 'package:async_example_saegis/models/user.dart';
import 'package:flutter/material.dart';

import 'firestore_controller.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _address = TextEditingController();
  FireStoreController _fireStoreController = FireStoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _age,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextFormField(
                  controller: _address,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_name.text.isNotEmpty && _address.text.isNotEmpty && _age.text.isNotEmpty) {
                        var user = User(_name.text, _address.text, int.parse(_age.text));
                        _fireStoreController.addUser(user);
                        _name.text = '';
                        _address.text = '';
                        _age.text = '';
                      }
                    },
                    child: Text('Add User'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var docId = await _fireStoreController.getUserDocId(_name.text);
                      _fireStoreController.updateUserAddress('Denver', docId!);
                      _name.text = '';
                      _address.text = '';
                      _age.text = '';
                    },
                    child: Text('Update User'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var docId = await _fireStoreController.getUserDocId(_name.text);
                      _fireStoreController.deleteUser(docId!);
                    },
                    child: Text('Delete User'),
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
