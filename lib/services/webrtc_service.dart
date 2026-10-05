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

  // Request Permissions
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted;
  }

  // 1. Separate Function: Low-Light Camera Monitoring
  Future<MediaStream?> startCameraMonitoring() async {
    final Map<String, dynamic> cameraConstraints = {
      'audio': false, // Audio handled separately
      'video': {
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
        'frameRate': {'ideal': 30},
        'advanced': [
          {'exposureMode': 'continuous'},
          {'brightness': {'ideal': 300}}, // Low-light boost
        ]
      }
    };

    try {
      localStream = await navigator.mediaDevices.getUserMedia(cameraConstraints);
      if (localRenderer != null && localStream != null) {
        localRenderer!.srcObject = localStream;
      }
      return localStream;
    } catch (e) {
      print('Camera monitoring error: $e');
      return null;
    }
  }

  // 2. Separate Function: Noise-Canceled One-Way Audio
  Future<MediaStream?> startNoiseCanceledAudio() async {
    final Map<String, dynamic> audioConstraints = {
      'audio': {
        'echoCancellation': true,
        'noiseSuppression': true,
        'autoGainControl': true,
      },
      'video': false,
    };

    try {
      localStream = await navigator.mediaDevices.getUserMedia(audioConstraints);
      return localStream;
    } catch (e) {
      print('Audio streaming error: $e');
      return null;
    }
  }

  // 3. Separate Function: Zero-Latency Screen Mirroring
  Future<MediaStream?> startScreenMirroring() async {
    final Map<String, dynamic> screenConstraints = {
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth': '1280',
          'minHeight': '720',
          'minFrameRate': '30',
        },
        'optional': [],
      }
    };

    try {
      localStream = await navigator.mediaDevices.getDisplayMedia(screenConstraints);
      if (localRenderer != null && localStream != null) {
        localRenderer!.srcObject = localStream;
      }
      return localStream;
    } catch (e) {
      print('Screen mirroring error: $e');
      return null;
    }
  }

  // Stop current stream & dispose
  void dispose() {
    localStream?.dispose();
    localRenderer?.dispose();
    peerConnection?.dispose();
  }
}
