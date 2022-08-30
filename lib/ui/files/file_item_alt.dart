import 'package:flutter/material.dart';

class FileItemAlt extends StatelessWidget {
  final String file;
  final void Function(String) onClear;

  const FileItemAlt({Key? key, required this.file, required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: null,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/files/${file.split('.').last}.png',
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    file.split('/').last.split('.').first,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Expanded(
                  child: Text(
                    file.split('.').last,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                IconButton(onPressed: () => onClear(file), icon: const Icon(Icons.close))
              ],
            ),
          )),
    );
  }
}
