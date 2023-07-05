import 'package:bhhh_noise/gallery_modal.dart';
import 'package:flutter/material.dart';

class BhhhDrawer extends StatelessWidget {
  const BhhhDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('My Saved Noises'),
            onTap: () async {
              Navigator.pop(context);
              await showGallery(context);
            },
          ),
        ],
      ),
    );
  }
}
