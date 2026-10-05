import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';

class WebRTCService {
  RTCVideoRenderer? localRenderer;
  RTCPeerConnection? peerConnection;

  // Initialize Renderers for zero latency streaming
  Future<void> initRenderers() async {
    localRenderer = RTCVideoRenderer();
    await localRenderer?.initialize();
  }

  // Request camera, microphone, and system permissions for low-light & audio
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted;
  }

  // Dispose renderers
  void dispose() {
    localRenderer?.dispose();
    peerConnection?.dispose();
  }
}
