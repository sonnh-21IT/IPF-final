import 'package:flutter/material.dart';

class SearchingDialog extends StatelessWidget {
  final Function onCancel;

  const SearchingDialog({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Vị trí của bạn đang được đánh dấu và mọi người có thể xác định được vị trí của bạn',
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancel();
                      },
                      icon: const Icon(Icons.info_rounded),
                      label: const Text('Hủy đánh dấu vị trí'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 22, bottom: 22),
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
