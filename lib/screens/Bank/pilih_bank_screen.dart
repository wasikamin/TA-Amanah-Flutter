import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Bank/tambah_bank_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PilihBankScreen extends StatefulWidget {
  const PilihBankScreen({super.key});

  @override
  State<PilihBankScreen> createState() => _PilihBankScreenState();
}

class _PilihBankScreenState extends State<PilihBankScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBank();
  }

  checkBank() async {
    await Provider.of<UserProvider>(context, listen: false).getBank();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text("Pilih Rekening", style: bodyTextStyle.copyWith(fontSize: 20)),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    "Pilih Akun Bank",
                    style: bodyTextStyle,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TambahBankScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                        Text(
                          "Tambah",
                          style: titleTextStyle.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            vSpace(height: height * 0.02),
            SingleChildScrollView(
              child: Card(
                elevation: 0,
                child:
                    Consumer<UserProvider>(builder: (context, userProvider, _) {
                  // print(userProvider.banks.length);
                  return Column(
                    children: [
                      DataTable(
                        headingRowHeight: 50, // Height of the header row
                        columns: const [
                          DataColumn(label: Text('Nomor')),
                          DataColumn(label: Text('Bank')),
                          DataColumn(label: Text('Action')),
                        ],
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => accentColor),
                        headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                        rows: userProvider.banks.isEmpty
                            ? [
                                DataRow(cells: [
                                  DataCell(Container(
                                    width: width * 0.22,
                                    child: Text(
                                      "",
                                      style:
                                          bodyTextStyle.copyWith(fontSize: 12),
                                    ),
                                  )),
                                  DataCell(Text("")),
                                  DataCell(Text("")),
                                ]),
                              ]
                            : userProvider.banks
                                .map(
                                  (bank) => DataRow(cells: [
                                    DataCell(Container(
                                      width: width * 0.22,
                                      child: Text(bank.accountNumber,
                                          style: bodyTextStyle.copyWith(
                                              fontSize: 12)),
                                    )),
                                    DataCell(Text(bank.bankCode,
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 12))),
                                    const DataCell(Icon(
                                      Icons.edit,
                                      size: 12,
                                    ))
                                  ]),
                                )
                                .toList(),
                      ),
                      if (userProvider.banks.isEmpty)
                        Container(
                            margin: EdgeInsets.only(bottom: height * 0.05),
                            child: Text("Belum ada Akun Bank",
                                style: bodyTextStyle.copyWith(fontSize: 16))),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
