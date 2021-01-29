import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Made in Futter',
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(width: 8),
        Image.network(
          'https://media-exp1.licdn.com/dms/image/C4E0BAQGE244-Y7aXhw/company-logo_200_200/0/1519895049833?e=2159024400&v=beta&t=6Qwqh3QJxxqp7Blh82o0yyjI0HO3B7kzMQKqwNZh1bU',
          width: 25,
        )
      ],
    );
  }
}
