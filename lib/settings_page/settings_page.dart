import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/settings_page/preview_section.dart';

import 'button_settings_section.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.logout),
            label: Text('Sign out'),
            onPressed: () => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: Container(
        child: LayoutBuilder(
          builder: (context, size) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ButtonSettingsSection(), PreviewSection()],
            );
          },
        ),
      ),
    );
  }
}
