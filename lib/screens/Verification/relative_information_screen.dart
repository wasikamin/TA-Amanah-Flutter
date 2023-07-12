//import material.dart from flutter
import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/kyc_provider.dart';
import 'package:amanah/screens/Verification/take_ktp_screen.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

//create stateless widget named 'RelativeInformationScreen'
class RelativeInformationScreen extends StatefulWidget {
  @override
  State<RelativeInformationScreen> createState() =>
      _RelativeInformationScreenState();
}

class _RelativeInformationScreenState extends State<RelativeInformationScreen> {
  String relativeContactRelation1 = "";

  String relativeContactRelation2 = "";

  final _formKey = GlobalKey<FormState>();

  final relativeContactName1 = TextEditingController();
  final relativeContactName2 = TextEditingController();

  final relativeContactPhone1 = TextEditingController();
  final relativeContactPhone2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kycProvider = Provider.of<KycProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: whiteColor,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          //create title widget
          title: const Text("Informasi Kontak"),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0,
          foregroundColor: Colors.black,
        ),

        //create body widget
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08, vertical: height * 0.03),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kerabat 1",
                      style: bodyTextStyle.copyWith(fontSize: 16),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Nama Lengkap Kerabat"),
                      controller: relativeContactName1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Lengkap Kerabat tidak boleh kosong';
                        }
                        return null;
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
                      items: const [
                        "Ayah Kandung",
                        "Ibu Kandung",
                        "Kakak Kandung",
                        "Adik Kandung",
                        "Suami",
                        "Istri",
                        "Anak Kandung",
                        "Saudara"
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "Hubungan Dengan Kerabat",
                        hintText: "Pilih Hubungan Dengan Kerabat",
                      )),
                      onChanged: (value) {
                        setState(() {
                          relativeContactRelation1 = value!;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Nomor Handphone Kerabat"),
                      keyboardType: TextInputType.number,
                      controller: relativeContactPhone1,
                    ),
                    vSpace(
                      height: height * 0.04,
                    ),
                    Text(
                      "Kerabat 2",
                      style: bodyTextStyle.copyWith(fontSize: 16),
                    ),
                    vSpace(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Nama Lengkap Kerabat"),
                      controller: relativeContactName2,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Lengkap Kerabat tidak boleh kosong';
                        }
                        return null;
                      }),
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
                        if (value == null || value.isEmpty) {
                          return 'Hubungan Dengan Kerabat tidak boleh kosong';
                        }
                        return null;
                      },
                      items: const [
                        "Ayah Kandung",
                        "Ibu Kandung",
                        "Kakak Kandung",
                        "Adik Kandung",
                        "Suami",
                        "Istri",
                        "Anak Kandung",
                        "Saudara"
                      ],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "Hubungan Dengan Kerabat",
                        hintText: "Pilih Hubungan Dengan Kerabat",
                      )),
                      onChanged: (value) {
                        setState(() {
                          relativeContactRelation2 = value!;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Nomor Handphone Kerabat"),
                      keyboardType: TextInputType.number,
                      controller: relativeContactPhone2,
                    ),
                    vSpace(
                      height: height * 0.1,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await kycProvider.setRelative1(
                                  relativeContactName1.text,
                                  relativeContactRelation1,
                                  relativeContactPhone1.text);
                              await kycProvider.setRelative2(
                                  relativeContactName2.text,
                                  relativeContactRelation2,
                                  relativeContactPhone2.text);
                              Navigator.push((context),
                                  MaterialPageRoute(builder: (context) {
                                return const KtpScreen();
                              }));
                            }
                          },
                          child: const Text("Selanjutnya")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
//
