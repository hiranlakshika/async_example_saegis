import 'package:async_example_saegis/shared_pref_helper.dart';
import 'package:flutter/material.dart';

class ValuesForm extends StatelessWidget {
  const ValuesForm({Key? key}) : super(key: key);

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
                  decoration: InputDecoration(labelText: 'Integer'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'String'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Double'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Bool'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'String List'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      SharedPreferencesHelper.saveValue(key: 'INT', value: 2, dataType: DateTypeEnum.Integer);
                      SharedPreferencesHelper.saveValue(key: 'STRING', value: 'SAEGIS', dataType: DateTypeEnum.String);
                    },
                    child: Text('Save'),
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
