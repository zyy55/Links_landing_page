import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/login_page/login_page.dart';
import 'package:flutter_app_1/settings_page/settings_page.dart';
import 'package:provider/provider.dart';

import 'links_landing_page/links_landing_page.dart';
import 'models/link_data.dart';
import 'not_found_page.dart';

void main() {
  //initialize the glue that binds the framework to the flutter
  WidgetsFlutterBinding.ensureInitialized();
  //this is the setUp for FirebaseEmulator, now we are not going to use that
  // FirebaseFirestore.instance.settings = Settings(
  //   host: 'localhost:8188',
  //   sslEnabled: false,
  //   persistenceEnabled: false,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final linksCollection = FirebaseFirestore.instance.collection('links');
    //ordered the links
    final userLinkDataStream =
        linksCollection.orderBy('position').snapshots().map((snapshot) {
      //convert list query snapshot to the linkdata
      return snapshot.docs.map((doc) {
        return LinkData.fromDocument(doc);
      }).toList();
    });

    return MultiProvider(
      providers: [
        //to now when the user is log in.
        //now our whole widget tree now when the user is sign in and out
        StreamProvider<User>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
        Provider<CollectionReference>(
          create: (context) => linksCollection,
        ),
        StreamProvider<List<LinkData>>(
          //contents that we want to pass to our provoider is _documents
          create: (context) => userLinkDataStream,
        ),
      ],
      child: MaterialApp(
        //delete debug label on the topRight side.
        debugShowCheckedModeBanner: false,
        title: 'Links Landing Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          // print(settings.name);
          return MaterialPageRoute(
            builder: (context) {
              return RoutController(settingsName: settings.name);
            },
          );
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return NotFoundPage();
            },
          );
        },
      ),
    );
  }
}

class RoutController extends StatelessWidget {
  final String settingsName;
  const RoutController({
    Key key,
    @required this.settingsName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //use of streamBuilder to now if someone is sign in
    final userSignedIn = Provider.of<User>(context) != null;
    final notSignedInGoSettings = !userSignedIn && settingsName == '/settings';
    final signedInGoSettings = userSignedIn && settingsName == '/settings';
    if (settingsName == '/') {
      return LinksLandingPage();
    } else if (notSignedInGoSettings || settingsName == '/login') {
      return LoginPage();
    } else if (signedInGoSettings) {
      return SettingsPage();
    } else {
      return NotFoundPage();
    }
  }
}
