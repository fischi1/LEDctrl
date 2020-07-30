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

class ResetSettings extends SettingsEvent {}

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  static final _initialData =
      SettingsState(address: "192.168.0.212", port: "3000");

  SettingsBloc() : super(_initialData);

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
    } else if (event is ResetSettings) {
      yield _initialData;
    }
  }
}
