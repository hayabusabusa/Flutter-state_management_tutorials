import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text input tutorial"),
      ),
      body: Center(
        child: Form(),
      ),
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  final textEditingController = TextEditingController();
  final anotherTextEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: textEditingController,
            // テキストフィールドの装飾
            // hintText, labelText, helperText はなかなか
            decoration: InputDecoration(
              hintText: "Hint text",
              labelText: "Label text",
              helperText: "Help text"
            ),
          ),
          TextField(
            // 同じ TextEditnigController を指定: 
            // 同じ TextEditingController を指定すると、
            // 片方のテキストフィールドが入力されるともう片方も同じ文字が入力されてしまうので
            // １つのテキストフィールドには１つの TextEditingContoller を指定?
            // Swift の tag みたいなのはないのか?
            //controller: textEditingController,
            controller: anotherTextEditingController,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text("Show text", style: TextStyle(color: Colors.white)),
            onPressed: () {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // TextEditingController の text プロパティに値が入っている
                    content: Text("Text is [${textEditingController.text}]"),
                  );
                }
              );
            },
          )
        ],
      ),
    );
  }
}