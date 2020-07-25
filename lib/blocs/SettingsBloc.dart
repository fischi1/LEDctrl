import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsState {
  final String address;
  final String port;

  SettingsState({
    this.address = "",
    this.port = "",
  });

  String getUrl() => "http://$address" + (port.length > 0 ? ":$port" : "");
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

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(address: "192.168.0.213", port: "3000"));

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState(
      address: json["address"] as String,
      port: json["port"] as String,
    );
  }

  @override
  Map<String, String> toJson(SettingsState state) {
    return {
      "address": state.address,
      "port": state.port,
    };
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is AddressChanged) {
      yield SettingsState(address: event.newAddress, port: state.port);
    } else if (event is PortChanged) {
      yield SettingsState(address: state.address, port: event.newPort);
    }
  }
}
