import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key, required this.controller, required this.hint})
      : super(key: key);
  final TextEditingController controller;
  final String hint;
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? selectedDate;
  // TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        widget.controller.text =
            formattedDate.toString(); // Update the text field value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: 16),
        Expanded(
          child: TextFormField(
            controller:
                widget.controller, // Bind the controller to the text field
            decoration: InputDecoration(
              labelText: widget.hint,
            ),
            enabled: false, // Disable editing the text field
          ),
        ),
        IconButton(
          onPressed: () => _selectDate(context),
          icon: Icon(Icons.calendar_today),
        ),
      ],
    );
  }
}
