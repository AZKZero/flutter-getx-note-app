import 'package:flutter/material.dart';

class FileItem extends StatelessWidget {
  final String file;
  final void Function(String) onClear;

  const FileItem({Key? key, required this.file, required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: null,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/files/${file.split('.').last}.png',
                        height: MediaQuery.of(context).size.height * 0.031,
                      ),
                      Text(
                        file.split('/').last,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
                IconButton(onPressed: () => onClear(file), icon: const Icon(Icons.close))
              ],
            ),
          )),
    );
  }
}
