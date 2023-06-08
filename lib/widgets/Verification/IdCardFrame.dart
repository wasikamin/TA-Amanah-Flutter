import 'package:flutter/material.dart';

class IDCardFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Text(
            'ID Card',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            height: 150.0,
            color: Colors.grey[200],
          ),
          SizedBox(height: 10.0),
          Text(
            'Name: ',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'ID: ',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
