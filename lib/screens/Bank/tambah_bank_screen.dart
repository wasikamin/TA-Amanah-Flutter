import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/availableBank.dart';
import 'package:amanah/screens/Bank/pilih_bank_screen.dart';
import 'package:amanah/services/balance_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class TambahBankScreen extends StatefulWidget {
  const TambahBankScreen({super.key});

  @override
  State<TambahBankScreen> createState() => _TambahBankScreenState();
}

class _TambahBankScreenState extends State<TambahBankScreen> {
  var formKey;
  final balanceService = BalanceService();
  // List<AvailableBank> availableBank = [];
  AvailableBank? bank;
  TextEditingController noRekeningController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Tambah Akun Bank",
            style: bodyTextStyle.copyWith(fontSize: 20)),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownSearch(
                    itemAsString: (item) => item.name,
                    asyncItems: (dynamic text) async {
                      try {
                        List response = await balanceService.getAvailableBank();
                        // print(response[1].bank_code);
                        List<AvailableBank> allBank = [];

                        for (var element in response) {
                          allBank.add(AvailableBank(
                            bank_code: element.bank_code,
                            name: element.name,
                            fee: element.fee,
                            queue: element.queue,
                            status: element.status,
                          ));
                        }

                        return allBank as List<dynamic>;
                      } catch (e) {
                        print(e);
                        return [];
                      }
                    },
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: "Cari Bank",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      fit: FlexFit.loose,
                      menuProps: MenuProps(
                        elevation: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Bank tidak boleh kosong";
                      }
                      return null;
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bank",
                      hintText: "Bank",
                    )),
                    onChanged: (value) {
                      setState(() {
                        bank = value!;
                      });
                    },
                  ),
                  vSpace(height: height * 0.02),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "No. Rekening tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: noRekeningController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "No. Rekening/VA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: height * 0.05),
            width: double.infinity,
            height: height * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await balanceService.addBankAccount(bank!.bank_code,
                          int.parse(noRekeningController.text), bank!.name);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PilihBankScreen();
                      }));
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color.fromARGB(
                            255, 211, 59, 59), // Customize the background color
                        duration:
                            Duration(seconds: 2), // Customize the duration
                        behavior:
                            SnackBarBehavior.floating, // Customize the behavior
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Customize the border radius
                        ),
                        content: Text(
                            "Pilih Bank dan Isi Nomor Rekening terlebih dahulu")));
                  }
                },
                child: Text("Selanjutnya")),
          ),
        ]),
      ),
    );
  }
}
