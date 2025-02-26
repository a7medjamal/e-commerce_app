// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';

class UserAlertDialog extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String content;
  final String buttonText;
  final Function() onPressed;
  const UserAlertDialog({
    super.key,
    required this.context,
    required this.title,
    required this.content,
    required this.buttonText, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  TextButton(
                    onPressed: onPressed,
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        });
        return Container();
      },
    );
  }
}
