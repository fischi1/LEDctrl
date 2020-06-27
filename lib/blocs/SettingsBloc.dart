import 'package:bloc/bloc.dart';

class SettingsState {
  final String address;
  final String port;

  SettingsState({
    this.address = "",
    this.port = "",
  });
}

abstract class SettingsEvent {}

class AddressChanged extends SettingsEvent {
  final String newAddress;

  AddressChanged(this.newAddress);
}

class PortChanged extends SettingsEvent {
  final String newPort;

  PortChanged(this.newPort);
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState => SettingsState(address: "192.168.0.212", port: "3000");

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if(event is AddressChanged) {
      yield SettingsState(address: event.newAddress, port: state.port);
    } else if(event is PortChanged) {
      yield SettingsState(address: state.address, port: event.newPort);
    }
  }
}
