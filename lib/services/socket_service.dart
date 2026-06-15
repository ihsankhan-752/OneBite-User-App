import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? _socket;

  static void connect(String userId) {
    _socket = IO.io(
      'http://10.0.2.2:8000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      print('User socket connected');
      _socket!.emit('join', userId);
    });

    _socket!.onDisconnect((_) {
      print('User socket disconnected');
    });
  }

  static void onOrderStatusUpdate(Function(dynamic) callback) {
    _socket?.on('order_status_update', callback);
  }

  static void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }
}
