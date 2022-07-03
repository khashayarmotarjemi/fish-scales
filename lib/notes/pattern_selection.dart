import 'package:flutter/material.dart';

class KeySelectorWidget extends StatelessWidget {
  const KeySelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChangeKeyButtonWidget extends StatelessWidget {
  final String name;
  final bool active;

  const ChangeKeyButtonWidget(
      {Key? key, required this.name, this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: active ? Colors.greenAccent : Colors.grey[50],
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
        child: Text(name),
      ),
    );
  }
}
