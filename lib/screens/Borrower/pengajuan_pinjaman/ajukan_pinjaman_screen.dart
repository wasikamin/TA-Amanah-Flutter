import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Bank/pilih_bank_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AjukanPinjamanScreen extends StatefulWidget {
  const AjukanPinjamanScreen({super.key});

  @override
  State<AjukanPinjamanScreen> createState() => _AjukanPinjamanScreenState();
}

enum PaymentScheme { Lunas, Cicilan }

class _AjukanPinjamanScreenState extends State<AjukanPinjamanScreen> {
  String durasi = "";
  String kategori = "";
  final amountController = TextEditingController();
  final yieldController = TextEditingController();
  final tujuanController = TextEditingController();
  PaymentScheme scheme = PaymentScheme.Lunas;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text("Ajukan Pinjaman",
            style: bodyTextStyle.copyWith(fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.03),
                  child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 15,
                      children: [
                        TextFormField(
                          controller: amountController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Jumlah Pinjaman"),
                            hintText: "Masukkan Jumlah Pinjaman",
                            helperText: 'Pinjaman harus kelipatan Rp. 50.0000',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a value';
                            }
                            int? parsedValue = int.tryParse(value);
                            if (parsedValue == null) {
                              return 'Invalid number';
                            }
                            if (parsedValue % 50000 != 0) {
                              return 'Pinjaman harus kelipatan 50.000';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            fit: FlexFit.loose,
                            menuProps: MenuProps(
                              elevation: 10,
                            ),
                          ),
                          items: ["3 Bulan", "6 Bulan", "12 Bulan"],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Durasi Pinjaman",
                            hintText: "Pilih Durasi Pinjaman",
                          )),
                          onChanged: (value) {
                            setState(() {
                              durasi = value!;
                            });
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          controller: yieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Imbal Hasil"),
                            hintText: "Masukkan Imbal Hasil",
                            helperText: 'Minimal 10% dari jumlah pinjaman',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            double? loanAmount =
                                double.tryParse(amountController.text);
                            double minimumYield = 0.1 * loanAmount!;
                            if (value!.isEmpty) {
                              return 'Masukkan imbal hasil';
                            }
                            int? yield = int.tryParse(value);
                            if (yield == null) {
                              return 'Invalid number';
                            }
                            if (yield < minimumYield) {
                              return 'Minimum (10%): Rp. ' +
                                  minimumYield.toString();
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            fit: FlexFit.loose,
                            menuProps: MenuProps(
                              elevation: 10,
                            ),
                          ),
                          items: ["Personal", "Pendidikan"],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Kategori",
                            hintText: "Pilih Kategori Pinjaman",
                          )),
                          onChanged: (value) {
                            setState(() {
                              kategori = value!;
                            });
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          controller: tujuanController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Tujuan Pinjaman"),
                            hintText: "Masukkan Imbal Hasil",
                            helperText: 'Tuliskan detail tujuan pinjaman',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Masukkan tujuan pinjaman';
                            }

                            return null; // Return null if the input is valid
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        Text(
                          "Skema Pembayaran",
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio<PaymentScheme>(
                                value: PaymentScheme.Lunas,
                                groupValue: scheme,
                                onChanged: (PaymentScheme? value) {
                                  setState(() {
                                    scheme = value!;
                                  });
                                },
                              ),
                              const Text('Lunas'),
                              Radio<PaymentScheme>(
                                value: PaymentScheme.Cicilan,
                                groupValue: scheme,
                                onChanged: (PaymentScheme? value) {
                                  setState(() {
                                    scheme = value!;
                                  });
                                },
                              ),
                              const Text('Cicilan'),
                            ]),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // print(amountController.text +
                                  //     durasi +
                                  //     yieldController.text +
                                  //     scheme.name +
                                  //     kategori +
                                  //     tujuanController.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PilihBankScreen()));
                                }
                              },
                              child: Text("Selanjutnya")),
                        ),
                      ]),
                ),
              ),
            )),
      ),
    );
  }
}