import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Lenders/Balance/transaction_history_screen.dart';
import 'package:amanah/screens/web/web_view_screen.dart';
import 'package:amanah/services/balance_service.dart';
import 'package:amanah/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _balanceservice = BalanceService();
  final _amountController = MoneyMaskedTextController(
      thousandSeparator: '.',
      leftSymbol: 'Rp. ',
      precision: 0,
      decimalSeparator: "");
  @override
  Widget build(BuildContext context) {
    final listAmount = [50000, 100000, 200000, 300000, 400000, 500000];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff2f7fa),
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: "Top Up",
        actions: [
          TextButton(
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
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpace(height: height * 0.03),
            Text(
              "Pilih Nominal Top Up",
              style: titleTextStyle.copyWith(fontSize: 20),
            ),
            vSpace(height: height * 0.03),
            Container(
              child: Text(
                "Pilih nominal top up atau ketik jumlah top up",
                style: bodyTextStyle.copyWith(fontSize: 15),
              ),
            ),
            vSpace(
              height: height * 0.05,
            ),
            GridNominal(
              listAmount: listAmount,
              width: width,
              amountController: _amountController,
            ),
            vSpace(
              height: height * 0.05,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                  left: width * 0.05,
                                  right: width * 0.05,
                                  top: height * 0.02,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          height * 0.02,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        'Masukkan Nominal Top Up',
                                        style: bodyTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _amountController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration:
                                          InputDecoration(hintText: 'RP.'),
                                      autofocus: true,
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    vSpace(height: height * 0.1),
                                    SizedBox(
                                      width: double.infinity,
                                      height: height * 0.07,
                                      child: ElevatedButton(
                                        child: const Text('Konfirmasi'),
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                            primary: primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: TextField(
                      enabled: false,
                      controller: _amountController,
                      textAlign: TextAlign.center,
                      style: bodyTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        hintText: "Masukkan Nominal Top Up",
                        hintStyle: bodyTextStyle.copyWith(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  vSpace(height: height * 0.02),
                  SizedBox(
                      width: double.infinity,
                      height: height * 0.07,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              if (_amountController.numberValue.toInt() <
                                  50000) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Color.fromARGB(
                                            255,
                                            211,
                                            59,
                                            59), // Customize the background color
                                        duration: Duration(
                                            seconds:
                                                2), // Customize the duration
                                        behavior: SnackBarBehavior
                                            .floating, // Customize the behavior
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Customize the border radius
                                        ),
                                        content:
                                            Text("Minimal Top Up Rp. 50.000")));
                                return;
                              } else {
                                var respose = await _balanceservice.deposit(
                                    _amountController.numberValue.toInt());
                                print(respose['paymentLink']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebViewScreen(
                                              url: respose['paymentLink'],
                                            )));
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text("Top Up"),
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//widget grid
class GridNominal extends StatelessWidget {
  const GridNominal({
    super.key,
    required this.listAmount,
    required this.width,
    required this.amountController,
  });

  final List<int> listAmount;
  final double width;
  final MoneyMaskedTextController amountController;

  @override
  Widget build(BuildContext context) {
    String formatCurrency(int amount) {
      final formatCurrency = new NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
      return formatCurrency.format(amount);
    }

    return Expanded(
      flex: 1,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          listAmount.length,
          (index) => GestureDetector(
            onTap: () {
              amountController.text = formatCurrency(listAmount[index]);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: width * 0.01),
              child: Card(
                color: const Color(0xfff2f7fa),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.grey, width: 1),
                ),
                elevation: 1,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.17,
                        child:
                            Image.asset("assets/images/Illustration/cash.png"),
                      ),
                      Text(
                        formatCurrency(listAmount[index]),
                        style: bodyTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
