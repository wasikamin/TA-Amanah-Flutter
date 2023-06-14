//import material.dart from flutter
import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/kyc_provider.dart';
import 'package:amanah/screens/Verification/relative_information_screen.dart';
import 'package:amanah/widgets/Verification/datePicker.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

//create stateless widget named 'PersonalInformationScreen'
class PersonalInformationScreen extends StatefulWidget {
  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  String gender = "";

  String work = "";

  String salary = "";

  //create variable named 'formKey' with type GlobalKey<FormState>
  final _formKey = GlobalKey<FormState>();

  //create variable named 'nameController' with type TextEditingController
  final nameController = TextEditingController();

  //create variable named 'birthDateController' with type TextEditingController
  final birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kycProvider = Provider.of<KycProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          //create title widget
          title: Text("Informasi Personal",
              style: bodyTextStyle.copyWith(fontSize: 18)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),

        //create body widget
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.08, vertical: height * 0.03),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nama Lengkap"),
                    controller: nameController,
                  ),
                  vSpace(
                    height: height * 0.02,
                  ),
                  DropdownSearch<String>(
                    items: ["Laki-laki", "Perempuan"],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Jenis Kelamin",
                      hintText: "Pilih Jenis Kelamin",
                    )),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  vSpace(
                    height: height * 0.02,
                  ),
                  MyDatePicker(
                      hint: "Tanggal Lahir", controller: birthDateController),
                  vSpace(
                    height: height * 0.02,
                  ),
                  DropdownSearch<String>(
                    items: [
                      "Wiraswasta",
                      "Wirausaha",
                      "PNS",
                      "Dosen",
                      "Mahasiswa",
                      "Honorer",
                      "Lainnya"
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Pekerjaan",
                      hintText: "Pilih Pekerjaan",
                    )),
                    onChanged: (value) {
                      setState(() {
                        work = value!;
                      });
                    },
                  ),
                  vSpace(
                    height: height * 0.02,
                  ),
                  DropdownSearch<String>(
                    items: [
                      "< 1.000.000",
                      "1.000.000-5.000.000",
                      "5.000.000-10.000.000",
                      "10.000.000-20.000.000",
                      "20.000.000-50.000.000",
                      "> 50.000.000"
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Pendapatan",
                      hintText: "Pilih Pendapatan",
                    )),
                    onChanged: (value) {
                      setState(() {
                        salary = value!;
                      });
                    },
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
                            await kycProvider.personal(nameController.text,
                                gender, birthDateController.text, work, salary);
                            Navigator.push((context),
                                MaterialPageRoute(builder: (context) {
                              return RelativeInformationScreen();
                            }));
                          }
                        },
                        child: Text("Selanjutnya")),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
//
