import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogConfirmation extends StatelessWidget {
  String? text;
  String? confirm;

  DialogConfirmation({Key? key, this.text, this.confirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9, minWidth: 10, minHeight: 10, maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: Card(
            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text ?? 'Confirm Action?'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          child: Text(confirm ?? 'Confirm'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text("Cancel"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
