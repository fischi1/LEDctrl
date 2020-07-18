import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum UserMessageType {
  normal,
  success,
  error,
}

@immutable
class UserMessage extends Equatable {
  final UserMessageType type;
  final String message;

  UserMessage({this.type, this.message});

  @override
  List<Object> get props => [message, type];

  @override
  String toString() {
    return 'UserMessage{type: $type, message: $message}';
  }
}

@immutable
abstract class UserMessagesEvent {}

class AddUserMessage extends UserMessagesEvent {
  final UserMessage userMessage;

  AddUserMessage(this.userMessage);
}

class RemoveUserMessage extends UserMessagesEvent {
  final UserMessage userMessage;

  RemoveUserMessage(this.userMessage);
}

class UserMessagesBloc extends Bloc<UserMessagesEvent, List<UserMessage>> {
  UserMessagesBloc() : super([]);

  @override
  Stream<List<UserMessage>> mapEventToState(UserMessagesEvent event) async* {
    if (event is AddUserMessage) {
      yield [...state, event.userMessage];
    } else if (event is RemoveUserMessage) {
      final newList = [...state];
      newList.remove(event.userMessage);
      yield newList;
    }
  }
}
