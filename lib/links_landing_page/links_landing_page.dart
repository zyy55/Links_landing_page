import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/link_data.dart';
import 'package:provider/provider.dart';
import 'button_link.dart';
import '../constant.dart';
import 'foot.dart';

class LinksLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we use it in provider
    // return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection('links').snapshots(),
    //     builder: (context, snapshot) {
    //     });

    final _documents = Provider.of<List<LinkData>>(context);
    if (_documents == null) {
      //when this finish it will display Material
      return Center(child: CircularProgressIndicator());
    }
    //doc.data contain the data we are interested in
    // final _documents = snapshot.data.docs.map((doc) {
    //   return LinkData.fromMap(doc.data());
    // }).toList();
    return Material(
      child: Column(
        children: [
          SizedBox(height: 35),
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.white,
            radius: 48,
          ),
          SizedBox(height: 12),
          Text(
            '@socialhandle',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          if (_documents.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: Text('Whoops, have not added some links'),
            ),
          for (var document in _documents)
            ButtonLink(
              title: document.title,
              url: document.url,
            ),
          Spacer(),
          Footer(),
          SizedBox(height: 23),
        ],
      ),
    );
  }
}
