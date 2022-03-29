import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
class SelectGender extends StatelessWidget {
  const SelectGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      decoration: const InputDecoration(labelText: 'Gender',   //color: Colors.blue,
        isDense: true,

        filled: true,
      ),
      hint: const Text('Select Gender'),
      items: ['Male', 'Female'].map((gender) => DropdownMenuItem(value: gender, child: Text('$gender'))).toList(),
      name: 'gender',
      onChanged: (value){},
    );
  }
}
