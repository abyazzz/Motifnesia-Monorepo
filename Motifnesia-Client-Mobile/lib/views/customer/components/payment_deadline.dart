import 'dart:async';
import 'package:flutter/material.dart';

class PaymentDeadline extends StatefulWidget {
  const PaymentDeadline(this.deadline);
  final String deadline;
  @override
  State<PaymentDeadline> createState() => _PaymentDeadlineState();
}

class _PaymentDeadlineState extends State<PaymentDeadline> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    if (DateTime.tryParse(widget.deadline) != null)
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() {}),
      );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deadline = DateTime.tryParse(widget.deadline);
    if (deadline == null) return const SizedBox.shrink();
    final remaining = deadline.difference(DateTime.now());
    if (remaining.isNegative)
      return const Text('Batas waktu pembayaran telah lewat.');
    return Text(
      'Waktu tersisa ${remaining.inHours} jam ${remaining.inMinutes % 60} menit ${remaining.inSeconds % 60} detik',
    );
  }
}
