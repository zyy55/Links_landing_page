import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/link_data.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    Key key,
    @required this.document,
  }) : super(key: key);

  final LinkData document;

  @override
  Widget build(BuildContext context) {
    final _linksCollection = Provider.of<CollectionReference>(context);
    final _formkey = GlobalKey<FormState>();
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            //we want to reset the dialog every time we close the dialog
            TextEditingController _titleTextController = TextEditingController(
              text: document.title,
            );
            TextEditingController _urlTextController = TextEditingController(
              text: document.url,
            );
            return AlertDialog(
              title: Text('Edit ${document.title} button'),
              content: Form(
                //to validad the camp
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Please add in a title' : null;
                      },
                      controller: _titleTextController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Facebook',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Please add in a url' : null;
                      },
                      controller: _urlTextController,
                      decoration: InputDecoration(
                        labelText: 'Link',
                        hintText: 'facebook.com/my-user-name',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      final userChangeTitle =
                          document.title != _titleTextController.text;
                      final userChangeUrl =
                          document.url != _urlTextController.text;
                      if (_formkey.currentState.validate()) {
                        //before without provider we was using FirebaseFirestore.instance.collection('links').add
                        if (userChangeTitle || userChangeUrl) {
                          final newLinkData = LinkData(
                            title: _titleTextController.text,
                            url: _urlTextController.text,
                          );
                          _linksCollection.doc(document.id).update(
                                newLinkData.toMap(),
                              );
                          print('Updates');
                        }
                        Navigator.of(context).pop();
                        _formkey.currentState.reset();
                      }
                    },
                    child: Text('Edit')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'))
              ],
            );
          },
        );
      },
    );
  }
}
