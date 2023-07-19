// import 'dart:io';

// import 'dart:io';

import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/models/availableBank.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/services/balance_service.dart';
import 'package:amanah/services/loan_service.dart';
import 'package:amanah/widgets/sweat_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

class PencairanPinjamanScreen extends StatefulWidget {
  const PencairanPinjamanScreen({super.key});

  @override
  State<PencairanPinjamanScreen> createState() =>
      _PencairanPinjamanScreenState();
}

class _PencairanPinjamanScreenState extends State<PencairanPinjamanScreen> {
  dynamic formKey;
  final balanceService = BalanceService();
  XFile? _pickedImage;
  bool isLoading = false;
  // List<AvailableBank> availableBank = [];
  AvailableBank? bank;
  TextEditingController noRekeningController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  Future<void> _pickImage() async {
    try {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _pickedImage = pickedImage;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pengajuanLoanProvider = Provider.of<PengajuanLoanProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff2f7fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Rekening Tujuan Pembayaran",
            style: bodyTextStyle.copyWith(fontSize: 16)),
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Padding(
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
                            List response =
                                await balanceService.getAvailableBank();
                            // print(response[1].bank_code);
                            List<AvailableBank> allBank = [];

                            for (var element in response) {
                              allBank.add(AvailableBank(
                                bankCode: element.bankCode,
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
                          menuProps: const MenuProps(
                            elevation: 10,
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Bank tidak boleh kosong";
                          }
                          return null;
                        },
                        dropdownDecoratorProps: const DropDownDecoratorProps(
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
                      vSpace(height: height * 0.02),
                      Text(
                        "Upload Bukti Rekening Pembayaran",
                        style: bodyTextStyle.copyWith(fontSize: 12),
                      ),
                      vSpace(height: height * 0.02),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                _pickImage();
                              },
                              child: const Text("Pilih"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (_pickedImage != null)
                              Text(_pickedImage!.name)
                            // Image.file(File(result!.files[0].path!))
                            else
                              const Text("Pilih File Bukti Rekening"),
                          ],
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            isLoading = true;
                          });

                          final loanService = LoanService();
                          await pengajuanLoanProvider.setDisbursementData(
                            bank!,
                            userProvider.disbursement["loanId"],
                            noRekeningController.text,
                          );

                          await loanService
                              .postDisbursement(
                                  pengajuanLoanProvider, _pickedImage!)
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            return successAlert(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BorrowerHomePage()),
                                "Penarikan Anda Sedang Diproses",
                                "Harap Menunggu Pencairan Pinjaman Anda");
                          });
                        } catch (e) {
                          failedAlert(context, "Gagal Mengajukan Pembayaran",
                              e.toString());
                        }
                      } else {
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
                            content: const Text(
                                "Pilih Bank dan Isi Nomor Rekening terlebih dahulu")));
                      }
                    },
                    child: const Text("Selanjutnya")),
              ),
            ]),
          ),
          isLoading == true
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white60,
                  child: Center(
                      child: Image.asset(
                    "assets/images/Logo/amanah.gif",
                    width: 100,
                    height: 100,
                  )),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
