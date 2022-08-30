import 'package:cipers_cluster/ui/files/file_item_alt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../files/file_item.dart';

class DialogFiles extends StatelessWidget {
  DialogFiles({Key? key, required this.callback, required this.paths, required this.onClear}) : super(key: key);

  final VoidCallback? callback;
  final void Function(String) onClear;
  RxList<String> paths;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9, minWidth: 10, minHeight: 10, maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: Card(
            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const Text('Files For Note'), IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))],
                ),
                ElevatedButton.icon(icon: const Icon(Icons.add), onPressed: callback, label: const Text('Add Files')),
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7, minWidth: 10, minHeight: 10, maxHeight: MediaQuery.of(context).size.height * 0.3),
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Obx(() => ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: paths.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => FileItemAlt(
                          file: paths[index],
                          onClear: onClear,
                        ),
                      )),
                ),
              ]),
            ),
          )),
    );
  }
}
