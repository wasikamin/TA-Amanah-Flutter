import 'package:flutter/material.dart';

class StatusPinjaman extends StatefulWidget {
  const StatusPinjaman({super.key, required this.status});
  final String status;
  @override
  State<StatusPinjaman> createState() => _StatusPinjamanState();
}

class _StatusPinjamanState extends State<StatusPinjaman> {
  @override
  Widget build(BuildContext context) {
    String statusLoan = "";
    if (widget.status == "on request" || widget.status == "on process") {
      setState(() {
        statusLoan = "Menunggu Persetujuan";
      });
    } else if (widget.status == "pending") {
      setState(() {
        statusLoan = "Pending";
      });
    } else if (widget.status == "in borrowing" ||
        widget.status == "Belum dicairkan") {
      setState(() {
        statusLoan = "Dana Terkumpul";
      });
    } else if (widget.status == "disbursement") {
      setState(() {
        statusLoan = "Sudah dicairkan";
      });
    } else if (widget.status == "repayment") {
      setState(() {
        statusLoan = "Sudah Dibayar";
      });
    } else if (widget.status == "late repayment") {
      setState(() {
        statusLoan = "Dibayar Terlambat";
      });
    }

    return Text(statusLoan);
  }
}
