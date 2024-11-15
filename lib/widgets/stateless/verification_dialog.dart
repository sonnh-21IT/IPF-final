import 'package:flutter/material.dart';

class VerificationDialog extends StatelessWidget {
  final Function onTranslatorSelected;
  final Function onCustomerSelected;

  const VerificationDialog({
    super.key,
    required this.onTranslatorSelected,
    required this.onCustomerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Chúng tôi cần xác minh danh tính.\nBạn là?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Inter', fontSize: 20),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onTranslatorSelected();
                },
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green)),
                label: const Text(
                  "Phiên Dịch Viên",
                  style: TextStyle(color: Colors.black),
                ),
                icon: const Icon(
                  Icons.translate_rounded,
                  color: Colors.black,
                ),
                iconAlignment: IconAlignment.end,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCustomerSelected();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                label: const Text(
                  "Khách Hàng",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.supervisor_account_rounded,
                  color: Colors.white,
                ),
                iconAlignment: IconAlignment.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
