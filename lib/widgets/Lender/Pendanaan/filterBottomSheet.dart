import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/widgets/Lender/Pendanaan/durasiSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({
    super.key,
    required this.height,
  });
  final double height;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int startValue = 0;
  int endValue = 12;
  TextEditingController _minImbalController = TextEditingController();
  TextEditingController _maxImbalController = TextEditingController();
  //create variable named 'formKey' with type GlobalKey<FormState>
  final _formKey = GlobalKey<FormState>();

  void _handleRangeChanged(RangeValues values) {
    setState(() {
      startValue = values.start.toInt();
      endValue = values.end.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text("Filter Pendanaan",
                  style: titleTextStyle.copyWith(fontSize: 18)),
            ),
            vSpace(
              height: widget.height * 0.02,
            ),
            ListTile(
              minLeadingWidth: 10,
              contentPadding: EdgeInsets.zero,
              leading: new Icon(
                Icons.attach_money_rounded,
                color: primaryColor,
              ),
              title: new Text(
                'Imbal Hasil',
                style: titleTextStyle.copyWith(fontSize: 16),
              ),
            ),
            TextFormField(
              controller: _minImbalController,
              validator: (value) {
                if (value!.isEmpty) {
                  _minImbalController.text = "0";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Min"),
                labelStyle: titleTextStyle.copyWith(fontSize: 12),
                hintText: "Rp. 0",
                filled: true,
                fillColor: Color.fromARGB(255, 238, 238, 238),
                hintStyle:
                    bodyTextStyle.copyWith(fontSize: 12, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: widget.height * 0.02),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _maxImbalController,
              validator: (value) {
                if (value!.isEmpty) {
                  _maxImbalController.text = "10000000000";
                } else {
                  if (int.parse(value) < int.parse(_minImbalController.text)) {
                    return 'Maximal imbal hasil harus lebih besar dari minimal imbal hasil';
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("Max"),
                labelStyle: titleTextStyle.copyWith(fontSize: 12),
                filled: true,
                fillColor: Color.fromARGB(255, 238, 238, 238),
                hintText: "Rp. 100.000",
                hintStyle:
                    bodyTextStyle.copyWith(fontSize: 12, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 10,
              leading: new Icon(Icons.access_time_rounded, color: primaryColor),
              title: new Text('Durasi Pengembalian',
                  style: titleTextStyle.copyWith(fontSize: 16)),
            ),
            DurasiSlider(
              startValue: 0,
              endValue: 12,
              onChanged: _handleRangeChanged,
            ),
            vSpace(height: widget.height * 0.05),
            SizedBox(
              width: double.infinity,
              height: widget.height * 0.06,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // print(_minImbalController.text +
                    //     _maxImbalController.text +
                    //     "$startValue" +
                    //     "$endValue");
                    await Provider.of<LoanProvider>(context, listen: false)
                        .getLoan(
                            yieldMin: int.parse(_minImbalController.text),
                            yieldMax: int.parse(_maxImbalController.text),
                            tenorMin: startValue,
                            tenorMax: endValue);
                  }
                  Navigator.pop(context);
                },
                child: Text("Terapkan"),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            vSpace(height: widget.height * 0.04),
          ],
        ),
      ),
    );
  }
}
