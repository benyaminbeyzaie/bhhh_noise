import 'package:flutter/material.dart';

Future<String?> showTextInputModal(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  return await showModalBottomSheet<String>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Save"),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context, controller.text),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
