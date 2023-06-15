import 'package:amanah/constants/app_theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class TambahBankScreen extends StatefulWidget {
  const TambahBankScreen({super.key});

  @override
  State<TambahBankScreen> createState() => _TambahBankScreenState();
}

class _TambahBankScreenState extends State<TambahBankScreen> {
  var formKey;
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

    var namaBank = "";
    final noRekeningController = TextEditingController();
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
                    items: [
                      'BCA',
                      'CIMB Niaga',
                      'Mandiri',
                      'BNI',
                      'Permata',
                      'BRI',
                      'BSI'
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bank",
                      hintText: "Bank",
                    )),
                    onChanged: (value) {
                      setState(() {
                        namaBank = value!;
                      });
                    },
                  ),
                  vSpace(height: height * 0.02),
                  TextFormField(
                    controller: noRekeningController,
                    decoration: InputDecoration(
                      hintText: "No. Rekening/VA",
                      hintStyle: bodyTextStyle,
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
                    print(namaBank);
                  }
                },
                child: Text("Selanjutnya")),
          ),
        ]),
      ),
    );
  }
}
