import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';

class WebRTCService {
  RTCVideoRenderer? localRenderer;
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;

  // Initialize Renderers
  Future<void> initRenderers() async {
    localRenderer = RTCVideoRenderer();
    await localRenderer?.initialize();
  }

  // Request system permissions for camera and microphone
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted;
  }

  // Start Media Stream with Low-Light Camera Optimization & Noise-Canceled Audio
  Future<MediaStream?> startOptimizedMediaStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': {
        'echoCancellation': true,
        'noiseSuppression': true,
        'autoGainControl': true,
      },
      'video': {
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
        'frameRate': {'ideal': 30},
        // Low light / Night exposure adjustments
        'advanced': [
          {'exposureMode': 'continuous'},
          {'brightness': {'ideal': 100}},
        ]
      }
    };

    try {
      localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      if (localRenderer != null && localStream != null) {
        localRenderer!.srcObject = localStream;
      }
      return localStream;
    } catch (e) {
      print('Error capturing media stream: $e');
      return null;
    }
  }

  // Dispose renderers and streams
  void dispose() {
    localStream?.dispose();
    localRenderer?.dispose();
    peerConnection?.dispose();
  }
}
