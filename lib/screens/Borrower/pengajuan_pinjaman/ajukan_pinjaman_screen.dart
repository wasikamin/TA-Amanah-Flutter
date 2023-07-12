import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/providers/user_profile_provider.dart';
import 'package:amanah/screens/Borrower/pengajuan_pinjaman/konfirmasi_pinjaman_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AjukanPinjamanScreen extends StatefulWidget {
  const AjukanPinjamanScreen({super.key});

  @override
  State<AjukanPinjamanScreen> createState() => _AjukanPinjamanScreenState();
}

enum PaymentScheme { Lunas, Cicilan }

class _AjukanPinjamanScreenState extends State<AjukanPinjamanScreen> {
  String durasi = "";
  String kategori = "";
  // final amountController = TextEditingController();
  final amountController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  final yieldController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  final tujuanController = TextEditingController();
  PaymentScheme scheme = PaymentScheme.Lunas;
  final _formKey = GlobalKey<FormState>();
  String formatCurrency(int? amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final pengajuanLoanProvider = Provider.of<PengajuanLoanProvider>(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      resizeToAvoidBottomInset: true,
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Jumlah Pinjaman"),
                            hintText: "Masukkan Jumlah Pinjaman",
                            helperText: 'Kelipatan 50.000 dan minimal 500.000',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a value';
                            }
                            int? parsedValue =
                                amountController.numberValue.toInt();

                            if (parsedValue % 50000 != 0) {
                              return 'Pinjaman harus kelipatan Rp. 50.000';
                            }
                            if (parsedValue < 500000) {
                              return 'Minimal pinjaman Rp. 500.000';
                            }
                            if (parsedValue >
                                int.parse(userProfileProvider.loanLimit)) {
                              return 'Limit pinjaman anda: ${formatCurrency(int.parse(userProfileProvider.loanLimit))}';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            fit: FlexFit.loose,
                            menuProps: MenuProps(
                              elevation: 10,
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Pilih durasi pinjaman';
                            }
                            return null; // Return null if the input is valid
                          },
                          items: ["3 Bulan", "6 Bulan", "12 Bulan"],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Imbal Hasil"),
                            hintText: "Masukkan Imbal Hasil",
                            helperText: 'Minimal Rp. 50.000',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Masukkan imbal hasil';
                            }
                            int? yield = yieldController.numberValue.toInt();
                            if (yield < 50000) {
                              return 'Minimum: Rp. 50.000';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                        vSpace(
                          height: height * 0.02,
                        ),
                        DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            fit: FlexFit.loose,
                            menuProps: MenuProps(
                              elevation: 10,
                            ),
                          ),
                          items: ["Pribadi", "Usaha", "Hiburan", "Pendidikan"],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Kategori",
                            hintText: "Pilih Kategori Pinjaman",
                          )),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Masukkan kategori pinjaman';
                            }
                            return null; // Return null if the input is valid
                          },
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Tujuan Pinjaman"),
                            hintText: "Masukkan Tujuan Pinjaman",
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
                        const Text(
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
                                  await pengajuanLoanProvider.setBorrowing(
                                      kategori,
                                      tujuanController.text,
                                      scheme.name,
                                      durasi,
                                      amountController.numberValue.toInt(),
                                      yieldController.numberValue.toInt());
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
                                              const KonfirmasiPinjaman()));
                                }
                              },
                              child: const Text("Selanjutnya")),
                        ),
                      ]),
                ),
              ),
            )),
      ),
    );
  }
}
