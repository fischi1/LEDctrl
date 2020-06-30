import 'package:fischi/blocs/UserMessagesBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserMessagesToSnackbarListener extends StatelessWidget {
  final Widget child;

  const UserMessagesToSnackbarListener({Key key, this.child}) : super(key: key);

  void _showSnackbar(BuildContext context, UserMessage userMessage) {
    Color backgroundColor;

    switch (userMessage.type) {
      case UserMessageType.error:
        backgroundColor = Theme.of(context).errorColor;
        break;
      case UserMessageType.success:
        backgroundColor = Theme.of(context).buttonColor;
        break;
      default:
        backgroundColor = Theme.of(context).dialogBackgroundColor;
    }

    final snackBar = SnackBar(
      content: Text(
        userMessage.message,
        style: Theme.of(context).primaryTextTheme.body1,
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserMessagesBloc, List<UserMessage>>(
      listener: (context, messages) {
        print(messages);

        if (messages.isNotEmpty) {
          _showSnackbar(context, messages[0]);
          context.bloc<UserMessagesBloc>().add(RemoveUserMessage(messages[0]));
        }
      },
      child: child,
    );
  }
}
