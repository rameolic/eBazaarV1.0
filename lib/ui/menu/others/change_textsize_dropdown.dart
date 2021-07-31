import 'package:flutter/material.dart';

class ChangeTextSizeDropdown extends StatefulWidget {
  @override
  ChangeTextSizeDropdownState createState() {
    return new ChangeTextSizeDropdownState();
  }
}

class ChangeTextSizeDropdownState extends State<ChangeTextSizeDropdown> {
  List<double> _sizes = [15.0, 17.0, 19.0, 21.0, 23.0, 25.0, 27.0, 28.0];
  double _selectedSize = 13.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Text Size - DropdownButton'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DropdownButton<double>(
              items: _sizes
                  .map((size) => DropdownMenuItem<double>(
                        child: Text(
                          "Size: " + size.toString(),
                          style: TextStyle(
                            fontSize: _selectedSize,
                          ),
                        ),
                        value: size,
                      ))
                  .toList(),
              onChanged: (double value) {
                setState(() => _selectedSize = value);
              },
              hint: Text(
                "Change Text Size",
                style: TextStyle(
                  fontSize: _selectedSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
