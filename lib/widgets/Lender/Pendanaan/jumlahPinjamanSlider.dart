import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/Lender/Pendanaan/InformationRow.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class JumlahPinjamanSlider extends StatefulWidget {
  const JumlahPinjamanSlider(
      {super.key,
      required this.endValue,
      required this.onChanged,
      required this.yield
      // required this.startValue,
      });

  final double yield;
  final double endValue;
  // final double startValue;
  final ValueChanged<int> onChanged;

  @override
  JumlahPinjamanSliderState createState() => JumlahPinjamanSliderState();
}

class JumlahPinjamanSliderState extends State<JumlahPinjamanSlider> {
  // final amountController = TextEditingController();
  final amountController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  final sharedValue = ValueNotifier<double>(0.0);
  @override
  void initState() {
    super.initState();
  }

  String formatCurrency(int amount) {
    final formatCurrency = new NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: amountController,
          onChanged: (value) {
            if (amountController.numberValue > widget.endValue) {
              setState(() {
                sharedValue.value = widget.endValue;
                amountController.updateValue(widget.endValue);
              });
              widget.onChanged.call(sharedValue.value.round());
            } else {
              setState(() {
                sharedValue.value = amountController.numberValue;
              });
              widget.onChanged(sharedValue.value.round());
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Masukkan nominal pinjaman",
            helperText: "Harus Kelipatan Rp. 50.000 dan Minimal Rp.100.000",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Slider(
          min: 0,
          max: widget.endValue,
          divisions: (widget.endValue.round() / 50000).round(),
          activeColor: primaryColor,
          inactiveColor: Colors.grey[300],
          value: sharedValue.value,
          onChanged: (value) {
            setState(() {
              sharedValue.value = value;
              amountController.updateValue(sharedValue.value);
            });
            widget.onChanged(sharedValue.value.round());
          },
        ),
        Row(
          children: [
            Icon(
              Icons.summarize_rounded,
              color: primaryColor,
            ),
            SizedBox(width: width * 0.02),
            Text(
              "Ringkasan",
              style: bodyTextStyle.copyWith(color: primaryColor),
            ),
          ],
        ),
        vSpace(height: height * 0.02),
        InformationRow(
            left: "Est. Imbal Hasil",
            right: formatCurrency((sharedValue.value * widget.yield).toInt())),
        vSpace(height: height * 0.01),
        InformationRow(
            left: "Est. Total Dana Kembali",
            right: formatCurrency(sharedValue.value.toInt() +
                (sharedValue.value * widget.yield).toInt())),
      ],
    );
  }
}
