import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VPNPage(),
    );
  }
}

class VPNPage extends StatefulWidget {
  @override
  _VPNPageState createState() => _VPNPageState();
}

class _VPNPageState extends State<VPNPage> {
  final OpenVPN openvpn = OpenVPN();
  VpnStatus? currentState;
   String isConnected = "";
  late OpenVPN engine;
//VpnStatus? vpnStatus;
  String? stage;
  bool granted = false;

  // Replace these with your VPN configuration
  final String config = '''
  client
  dev tun
  proto udp
  remote 3.113.44.172 443  # Replace with your server's IP address
  resolv-retry infinite
  nobind
  persist-key
  persist-tun
  remote-cert-tls server
  cipher AES-256-CBC
  verb 3

  <ca>
  -----BEGIN CERTIFICATE-----
  MIIBwzCCAWigAwIBAgIUdhuVqzDRz9FWfGiBnRQdIGiSxNcwCgYIKoZIzj0EAwIw
  FzEVMBMGA1UEAwwMQ2lwaGVyLUhhdmVuMB4XDTI0MTExOTA2MjEwMVoXDTM0MTEx
  NzA2MjEwMVowFzEVMBMGA1UEAwwMQ2lwaGVyLUhhdmVuMFkwEwYHKoZIzj0CAQYI
  KoZIzj0DAQcDQgAERW0KgJXE+gwvx6+nnGWyG2Dxa1K79YnTu7HJr5bhpFYu5IRB
  MX+Zv3wKhfzT9JyvF49hU0nJ19NabigELPVIgKOBkTCBjjAMBgNVHRMEBTADAQH/
  MB0GA1UdDgQWBBRROOhJ/fdoGsg6E3juIIBryy+FTjBSBgNVHSMESzBJgBRROOhJ
  /fdoGsg6E3juIIBryy+FTqEbpBkwFzEVMBMGA1UEAwwMQ2lwaGVyLUhhdmVughR2
  G5WrMNHP0VZ8aIGdFB0gaJLE1zALBgNVHQ8EBAMCAQYwCgYIKoZIzj0EAwIDSQAw
  RgIhAJiq/8fS7lh/xkSg6h1gekt/L1Ie2RJu09KY96/jVB36AiEAoqe5Wu23IYj4
  qJJj91yiB74yDvfblw4UrS/YsUsN0I8=
  -----END CERTIFICATE-----
  </ca>
  <cert>
  -----BEGIN CERTIFICATE-----
  MIIByTCCAW+gAwIBAgIQBiLggSvmakscc6MfdD3LcDAKBggqhkjOPQQDAjAXMRUw
  EwYDVQQDDAxDaXBoZXItSGF2ZW4wHhcNMjQxMjAyMDY1MzI1WhcNMjcwMzA3MDY1
  MzI1WjAQMQ4wDAYDVQQDDAVyYWhpbTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IA
  BCWBL5XVOsY4SOQpESbbceWhKmPjwJXzdZxLXMnG+lvUDG5c+co1rgI/kE3Jx99I
  LSafubUTtDxd5vJ6k2mFLpejgaMwgaAwCQYDVR0TBAIwADAdBgNVHQ4EFgQUM2Od
  zNclGtDD79Fhnpl3rJnEV9EwUgYDVR0jBEswSYAUUTjoSf33aBrIOhN47iCAa8sv
  hU6hG6QZMBcxFTATBgNVBAMMDENpcGhlci1IYXZlboIUdhuVqzDRz9FWfGiBnRQd
  IGiSxNcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMAoGCCqGSM49
  BAMCA0gAMEUCIQCkKS1mcZBiJJdJNPfJIUEzuDviAh1SNjI1OStuuqiR9wIgVsXZ
  7nr8ycVuijQKZ4m5J4z90O1posGNEm/GST4Pq8s=
  -----END CERTIFICATE-----
  </cert>
  <key>
  -----BEGIN PRIVATE KEY-----
  MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgIytCYtqfMholraD8
  hs1cLd8leqEtxSOl8jv+CvYWGYChRANCAAQlgS+V1TrGOEjkKREm23HloSpj48CV
  83WcS1zJxvpb1AxuXPnKNa4CP5BNycffSC0mn7m1E7Q8XebyepNphS6X
  -----END PRIVATE KEY-----
  </key>
  <tls-crypt>
  #
  # 2048 bit OpenVPN static key
  #
  -----BEGIN OpenVPN Static key V1-----
  584cff85f0db365d3e49a659522bd9f2
  3e7f35fa96ecf65d9c65de797f26af4f
  42a3a37fc04f404e43a37a4b68066f41
  c947126cf10704bdfe4ba6be1f0bc9dd
  6972076d8c48ea6b9ca3c321118e1211
  07c149d3ef9267048f1799c96a01570a
  291fa05e08b4887e75755c7f759066c9
  3fe7e811e6656ac1ee7c713a1b736bb8
  d06079866c59072df46404e28cdfbe5f
  8d282457c1af65dd4efb00f1d6cfdb31
  1518531056dfde332a672a08e3c290ac
  9b25e5f0cefbe99cb20bd70669eb838c
  89e8ce9aabd07b2acfccb2d9c87929d8
  2b9ceeb6b16ec56be6195fbe254d38ba
  c8e7d3391a6afb7a49cf06c4a4bfbd6e
  9644940cbaf474f323aa287f1d4dce7f
  -----END OpenVPN Static key V1-----

  </tls-crypt>
    ''';

  final String username = '';
  final String password = '';

  @override
  void initState() {
    super.initState();
    initOpenVpn();
  }


  void initOpenVpn(){
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
      },
      onVpnStageChanged: (data, raw) {
        isConnected = raw;
        stage = raw;
      },
    );

    engine.initialize(
      groupIdentifier: "group.net.cipherhaven.vpn.main",
      providerBundleIdentifier:
      "net.cipherhaven.vpn.main.VPNExtension",
      localizedDescription: "Test VPN",
      lastStage: (stage) {
        this.stage = stage.name;
      },
      lastStatus: (status) {
        // vpnStatus = status;
      },
    );
  }


  Future<void> connectToVpn() async {
    // Ensure Android permission is granted
    if (Platform.isAndroid && !granted) {
      bool permissionGranted = await engine.requestPermissionAndroid();
      granted = permissionGranted;
      if (!permissionGranted) return; // Exit if permission not granted
    }
    await engine.connect(
      config,
      "Test VPN",
      username: username,
      password: password,
      certIsRequired: true,
    );
  }

  Future<void> disconnectVpn() async {
    engine.disconnect();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN Client'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'VPN Status: ${currentState?.toString() ?? 'Not connected'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              onPressed: (){
                isConnected != "connected" ? null : connectToVpn();
              },
              child: Text(
                'CONNECT',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              onPressed:(){
                isConnected == "connected" ? disconnectVpn() : null;
              },
              child: Text(
                'DISCONNECT',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}