import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/bank.dart';
import 'package:amanah/providers/authentication_provider.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Bank/tambah_bank_screen.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/screens/Lenders/Balance/transaction_history_screen.dart';
import 'package:amanah/screens/Lenders/Balance/withdraw_screen.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:amanah/widgets/CustomAppBar.dart';
import 'package:amanah/widgets/ToolTip.dart';
import 'package:amanah/widgets/sweat_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PilihBankScreen extends StatefulWidget {
  const PilihBankScreen({super.key});

  @override
  State<PilihBankScreen> createState() => _PilihBankScreenState();
}

class _PilihBankScreenState extends State<PilihBankScreen> {
  int? selectedRowIndex;
  Bank? selectedBank;

  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
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
    final pengajuanLoanProvider = Provider.of<PengajuanLoanProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      appBar: CustomAppBar(
        title: "Pilih Akun Bank",
        actions: [
          authProvider.role == "lender"
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TransactionHistoryScreen()));
                  },
                  child: const Text(
                    "Riwayat",
                    style: TextStyle(fontSize: 16),
                  ))
              : const SizedBox.shrink(),
        ],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          // print("refresh");
          await Provider.of<UserProvider>(context, listen: false).getBank();
        },
        child: ListView(children: [
          Padding(
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
                        style: titleTextStyle.copyWith(fontSize: 14),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TambahBankScreen()));
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
                Text("Pilih salah satu akun bank yang terdaftar",
                    style: bodyTextStyle.copyWith(fontSize: 12)),
                vSpace(height: height * 0.02),
                Card(
                  elevation: 0,
                  child: Consumer<UserProvider>(
                      builder: (context, userProvider, _) {
                    // print(userProvider.banks.length);
                    return Column(
                      children: [
                        DataTable(
                          columnSpacing: 40,
                          headingRowHeight: 50, // Height of the header row
                          columns: const [
                            DataColumn(label: Text('Terpilih')),
                            DataColumn(label: Text('Bank')),
                            DataColumn(label: Text('Nomor')),
                          ],
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => accentColor),
                          headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                          rows: userProvider.banks.isEmpty
                              ? [
                                  DataRow(cells: [
                                    DataCell(SizedBox(
                                      width: width * 0.22,
                                      child: Text(
                                        "",
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 12),
                                      ),
                                    )),
                                    const DataCell(Text("")),
                                    const DataCell(Text("")),
                                  ]),
                                ]
                              : userProvider.banks.asMap().entries.map(
                                  (entry) {
                                    final index = entry.key;
                                    final bank = entry.value;
                                    final isSelected =
                                        index == selectedRowIndex;
                                    return DataRow(
                                        color: MaterialStateColor.resolveWith(
                                            (states) => isSelected
                                                ? Colors.grey.withOpacity(0.3)
                                                : Colors.white),
                                        cells: [
                                          DataCell(SizedBox(
                                            width: 30,
                                            child: Radio(
                                              value: index,
                                              groupValue: selectedRowIndex,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRowIndex = index;
                                                  selectedBank = bank;
                                                  // print(selectedBank?.bankCode);
                                                });
                                              },
                                            ),
                                          )),
                                          DataCell(
                                            bank.bankName.length < 8
                                                ? Text(
                                                    bank.bankName,
                                                    style: bodyTextStyle,
                                                  )
                                                : CustomToolTip(
                                                    text: bank.bankName,
                                                    textStyle: bodyTextStyle,
                                                  ),
                                            onTap: () {
                                              setState(
                                                () {
                                                  if (isSelected) {
                                                    selectedRowIndex = index;
                                                    selectedBank = bank;
                                                    // print(selectedBank?.bankCode);
                                                  } else {
                                                    selectedRowIndex = index;
                                                    selectedBank = bank;
                                                    // print(selectedBank?.bankCode);
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                          DataCell(
                                              SizedBox(
                                                width: width * 0.22,
                                                child: Text(
                                                  bank.accountNumber,
                                                  style: bodyTextStyle.copyWith(
                                                      fontSize: 12),
                                                ),
                                              ), onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                selectedRowIndex = index;
                                                selectedBank = bank;
                                              } else {
                                                selectedRowIndex = index;
                                                selectedBank = bank;
                                                // print(bank.bankCode);
                                              }
                                            });
                                          }),
                                        ]);
                                  },
                                ).toList(),
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
                Container(
                    margin: EdgeInsets.only(top: height * 0.1),
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedBank?.bankCode == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: const Color.fromARGB(255, 211, 59,
                                59), // Customize the background color
                            duration: const Duration(
                                seconds: 2), // Customize the duration
                            behavior: SnackBarBehavior
                                .floating, // Customize the behavior
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Customize the border radius
                            ),
                            content: const Text("Pilih Bank terlebih dahulu"),
                          ));
                        } else {
                          if (authProvider.role == "lender") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WithdrawScreen(
                                          accountNumber: int.parse(
                                              selectedBank!.accountNumber),
                                          bankCode: selectedBank!.bankCode,
                                        )));
                          } else {
                            try {
                              final loanService = LoanService();
                              await pengajuanLoanProvider.setDisbursementData(
                                  selectedBank!,
                                  userProvider.disbursement["loanId"]);
                              loanService
                                  .postDisbursement(pengajuanLoanProvider)
                                  .then((value) {
                                return successAlert(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BorrowerHomePage()),
                                    "Penarikan Anda Sedang Diproses",
                                    "Harap Menunggu Pencairan Pinjaman Anda");
                              });
                            } catch (e) {
                              return failedAlert(context,
                                  "Penarikan Anda Gagal Diproses", "$e");
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("Konfirmasi"),
                    )),
                Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedBank?.bankCode == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: const Color.fromARGB(255, 211, 59,
                                59), // Customize the background color
                            duration: const Duration(
                                seconds: 2), // Customize the duration
                            behavior: SnackBarBehavior
                                .floating, // Customize the behavior
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Customize the border radius
                            ),
                            content: const Text("Pilih Bank terlebih dahulu"),
                          ));
                        } else {
                          try {
                            userProvider
                                .deleteBank(selectedBank!)
                                .then((value) {
                              return succesAlertinSamePage(
                                  context,
                                  "Berhasil Menghapus Bank",
                                  "Akun Bank Anda Berhasil Dihapus");
                            });
                          } catch (e) {
                            return failedAlert(
                                context, "Gagal Menghapus Bank", "$e");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("Hapus Akun Bank"),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
