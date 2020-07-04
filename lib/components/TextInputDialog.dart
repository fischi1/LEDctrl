import 'package:flutter/material.dart';

class TextInputDialog extends StatefulWidget {
  final String label;
  final String initialValue;

  const TextInputDialog({Key key, this.label, this.initialValue})
      : super(key: key);

  @override
  _TextInputDialogState createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  TextEditingController _valueController;

  @override
  void initState() {
    _valueController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          Expanded(
            child: new TextField(
              maxLength: 32,
              maxLengthEnforced: true,
              controller: _valueController,
              autofocus: true,
              onSubmitted: (value) => Navigator.pop(context, value),
              decoration: new InputDecoration(
                labelText: widget.label,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text('SAVE'),
          onPressed: () {
            Navigator.pop(context, _valueController.text);
          },
        )
      ],
    );
  }
}
