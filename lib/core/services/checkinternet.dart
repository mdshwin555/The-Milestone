import 'dart:io';

class InternetService {
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup("darkred-wombat-762943.hostingersite.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
