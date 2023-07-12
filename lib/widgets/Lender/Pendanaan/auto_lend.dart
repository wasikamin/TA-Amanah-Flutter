import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:amanah/widgets/sweat_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import "package:flutter/material.dart";

import 'package:amanah/constants/app_theme.dart';
// import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/widgets/Lender/Pendanaan/durasiSlider.dart';
// import 'package:provider/provider.dart';

class AutoLend extends StatefulWidget {
  const AutoLend({
    super.key,
    required this.height,
  });
  final double height;

  @override
  State<AutoLend> createState() => _AutoLendState();
}

class _AutoLendState extends State<AutoLend> {
  int startValue = 0;
  int endValue = 12;
  final loanService = LoanService();
  final _minImbalController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  final _maxImbalController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  final _amountController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");

  List<String> _selectedKategori = [];
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text("Auto Lend",
                    style: titleTextStyle.copyWith(fontSize: 18)),
              ),
              vSpace(
                height: widget.height * 0.02,
              ),
              ListTile(
                minLeadingWidth: 10,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.moving_outlined,
                  color: primaryColor,
                ),
                title: Text(
                  'Imbal Hasil',
                  style: titleTextStyle.copyWith(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: _minImbalController,
                validator: (value) {
                  if (_maxImbalController.numberValue == 0) {
                    return 'Maximal imbal hasil tidak boleh 0';
                  } else {
                    if (_maxImbalController.numberValue <
                        _minImbalController.numberValue) {
                      return 'Maximal imbal hasil harus lebih besar dari minimal imbal hasil';
                    }
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
                  if (_maxImbalController.numberValue == 0) {
                    return 'Maximal imbal hasil tidak boleh 0';
                  } else {
                    if (_maxImbalController.numberValue <
                        _minImbalController.numberValue) {
                      return 'Maximal imbal hasil harus lebih besar dari minimal imbal hasil';
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Max"),
                  labelStyle: titleTextStyle.copyWith(fontSize: 12),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 238, 238),
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
                leading: Icon(Icons.access_time_rounded, color: primaryColor),
                title: Text('Durasi Pengembalian',
                    style: titleTextStyle.copyWith(fontSize: 16)),
              ),
              DurasiSlider(
                startValue: 0,
                endValue: 12,
                onChanged: _handleRangeChanged,
              ),
              // vSpace(height: widget.height * 0.05),
              ListTile(
                minLeadingWidth: 10,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.category_rounded,
                  color: primaryColor,
                ),
                title: Text(
                  'Kategori Pinjaman',
                  style: titleTextStyle.copyWith(fontSize: 16),
                ),
              ),
              DropdownSearch<String>.multiSelection(
                items: const ["Pendidikan", "Hiburan", "Pribadi", "Usaha"],
                dropdownButtonProps: DropdownButtonProps(
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  color: primaryColor,
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: primaryColor)),
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: primaryColor, width: 2)),
                    labelText: "Kategori",
                    hintText: "Pilih minimal 1 kategori",
                    filled: true,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Pilih minimal 1 kategori';
                  }
                  return null;
                },
                popupProps: const PopupPropsMultiSelection.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    elevation: 10,
                  ),
                ),
                onChanged: (value) {
                  _selectedKategori = value;
                },
              ),

              ListTile(
                minLeadingWidth: 10,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.attach_money_rounded,
                  color: primaryColor,
                ),
                title: Text(
                  'Imbal Hasil',
                  style: titleTextStyle.copyWith(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: _amountController,
                validator: (value) {
                  if (_amountController.numberValue == 0) {
                    return "Jumlah pendanaan tidak boleh 0";
                  } else if (_amountController.numberValue < 100000) {
                    return "Jumlah pendanaan minimal Rp. 100.000";
                  } else if (_amountController.numberValue % 50000 != 0) {
                    return "Jumlah pendanaan harus kelipatan Rp. 50.000";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text("Jumah Pendanaan"),
                  labelStyle: titleTextStyle.copyWith(fontSize: 12),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 238, 238),
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
              SizedBox(
                height: widget.height * 0.05,
              ),
              SizedBox(
                width: double.infinity,
                height: widget.height * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // print(_minImbalController.numberValue.toString() +
                      //     _maxImbalController.numberValue.toString() +
                      //     "$startValue" +
                      //     "$endValue" +
                      //     _amountController.numberValue.toString() +
                      //     _selectedKategori.toString());
                      try {
                        await loanService
                            .autoLend(
                                startValue.toInt(),
                                endValue.toInt(),
                                _minImbalController.numberValue.toInt(),
                                _maxImbalController.numberValue.toInt(),
                                _amountController.numberValue.toInt(),
                                _selectedKategori)
                            .then((value) {
                          return successAlert(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              "Berhasil Memasang Auto Lend",
                              "Pendanaan anda akan otomatis berjalan jika ada pinjaman yang sesuai.");
                        });
                      } catch (e) {
                        failedAlert(context, "Gagal Melakukan Auto Lend", "$e");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Auto Lend"),
                ),
              ),
              vSpace(height: widget.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
