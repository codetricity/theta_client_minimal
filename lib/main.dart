import 'package:flutter/material.dart';
import 'package:theta_client_flutter/theta_client_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('theta-client minimal'),
        ),
        body: const MiniApp(),
      ),
    ),
  );
}

class MiniApp extends StatefulWidget {
  const MiniApp({Key? key}) : super(key: key);

  @override
  State<MiniApp> createState() => _MiniAppState();
}

class _MiniAppState extends State<MiniApp> {
  final _thetaClient = ThetaClientFlutter();
  String _mobilePlatform = 'device unknown';
  String _cameraInfo = 'unable to get camera info';

  @override
  void initState() {
    super.initState();
    _initializeTheta();
  }

  void _initializeTheta() async {
    try {
      var mobilePlatform = await _thetaClient.getPlatformVersion();
      await _thetaClient.initialize();
      var thetaInfo = await _thetaClient.getThetaInfo();
      setState(() {
        _mobilePlatform = mobilePlatform ?? 'device unknown';
        _cameraInfo = '${thetaInfo.model}, FW ${thetaInfo.firmwareVersion},'
            'SN: ${thetaInfo.serialNumber}';
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Mobile Platform: $_mobilePlatform',
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            _cameraInfo,
            style: const TextStyle(fontSize: 36),
          )
        ],
      ),
    );
  }
}
