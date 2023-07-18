//import material.dart from flutter
import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/kyc_provider.dart';
import 'package:amanah/screens/Verification/relative_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

//create stateless widget named 'PersonalInformationScreen'
class PersonalFinancialInformationScreen extends StatefulWidget {
  const PersonalFinancialInformationScreen({super.key});

  @override
  State<PersonalFinancialInformationScreen> createState() =>
      _PersonalFinancialInformationScreenState();
}

class _PersonalFinancialInformationScreenState
    extends State<PersonalFinancialInformationScreen> {
  //create variable named 'formKey' with type GlobalKey<FormState>
  final _formKey = GlobalKey<FormState>();

  final annualIncomeController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");

  final ownerShipType = {
    "Rumah Kredit": "Mortgage",
    "Rumah Sewa": "Rent",
    "Rumah Pribadi": "Own"
  };

  final totalMonthlyDebtController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  String? selectedOwnerShipType;

  @override
  Widget build(BuildContext context) {
    final kycProvider = Provider.of<KycProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: whiteColor,
        appBar: AppBar(
          //create title widget
          title: Text("Informasi Personal",
              style: bodyTextStyle.copyWith(fontSize: 18)),
          centerTitle: true,
          backgroundColor: whiteColor,
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
                  PersonalTextFormField(
                    label: "Pendapatan Tahunan",
                    controller: annualIncomeController,
                    textInputType: TextInputType.number,
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
                    items: ownerShipType.keys.toList(),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Jenis Kepemilikan Rumah",
                      hintText: "Pilih Jenis Kepemilikan Rumah",
                    )),
                    onChanged: (value) {
                      setState(() {
                        selectedOwnerShipType = ownerShipType[value!];
                      });
                    },
                  ),
                  vSpace(
                    height: height * 0.02,
                  ),
                  PersonalTextFormField(
                    label: "Hutang Bulanan",
                    controller: totalMonthlyDebtController,
                    textInputType: TextInputType.number,
                  ),
                  vSpace(
                    height: height * 0.1,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await kycProvider.setAnnualIncome(
                                annualIncomeController.numberValue.toInt());
                            await kycProvider
                                .setHomeOwnershipType(selectedOwnerShipType!);
                            await kycProvider.setTotalMonthlyDebt(
                                totalMonthlyDebtController.numberValue.toInt());

                            Navigator.push((context),
                                MaterialPageRoute(builder: (context) {
                              return RelativeInformationScreen();
                            }));
                          }
                        },
                        child: const Text("Selanjutnya")),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class PersonalTextFormField extends StatelessWidget {
  const PersonalTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType = TextInputType.text,
  });
  final TextInputType textInputType;
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: textInputType,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a value';
        } else
          return null;
      },
    );
  }
}
//
