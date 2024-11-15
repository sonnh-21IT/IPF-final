import 'package:config/utils/components/component.dart';
import 'package:flutter/material.dart';

class Usertile extends StatelessWidget {
  final String text;
  final String imgavata;
  final void Function()? onTap;

  const Usertile({super.key, required this.text, required this.onTap, required this.imgavata});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: GestureDetector(
            onTap: onTap,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    // Avata
                    Container(
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                                  imgavata)
                              as ImageProvider,
                          child: Container()),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    //  Name user
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data: text,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          const CustomText(
                            data: "hoạt động 30p trước",
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 20, right: 20),
                child: const Divider(
                  color: Colors.grey, // Đặt màu sắc cho thanh ngang
                  thickness: 1, // Đặt độ dày của thanh ngang
                ),
              ),
            ])));
  }
}
