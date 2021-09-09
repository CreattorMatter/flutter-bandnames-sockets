import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Conecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Conecting;

  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io('http://192.168.0.81:7000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    this._socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    //socket.on('nuevo-mensaje', (payload) {
    //  print('nuevo-mensaje: ${payload}');
    //});
  }
}
