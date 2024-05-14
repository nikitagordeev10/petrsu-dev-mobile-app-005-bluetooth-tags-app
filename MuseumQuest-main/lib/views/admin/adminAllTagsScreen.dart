// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class BleController extends GetxController {
//   FlutterBlue ble = FlutterBlue.instance;
//
//   // This Function will help users to scan near by BLE devices and get the list of Bluetooth devices.
//   Future scanDevices() async {
//     if (await Permission.bluetoothScan.request().isGranted) {
//       if (await Permission.bluetoothConnect.request().isGranted) {
//         ble.startScan(timeout: Duration(seconds: 15));
//         Future.delayed(Duration(seconds: 15), () => ble.stopScan());
//       }
//     }
//   }
//
//   // This function will help user to connect to BLE devices.
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     await device?.connect(timeout: Duration(seconds: 15));
//     device?.state.listen((isConnected) {
//       if (isConnected == BluetoothDeviceState.connecting) {
//         print("Device connecting to: ${device.name}");
//       } else if (isConnected == BluetoothDeviceState.connected) {
//         print("Device connected: ${device.name}");
//       } else {
//         print("Device Disconnected");
//       }
//     });
//   }
//
//   Stream<List<ScanResult>> get scanResults => ble.scanResults;
// }
//
// class AdminTagsScreen extends StatefulWidget {
//   const AdminTagsScreen({Key? key}) : super(key: key);
//
//   @override
//   _AdminTagsScreenState createState() => _AdminTagsScreenState();
// }
//
// class _AdminTagsScreenState extends State<AdminTagsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("BLE SCANNER"),
//       ),
//       body: GetBuilder<BleController>(
//         init: BleController(),
//         builder: (BleController controller) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 StreamBuilder<List<ScanResult>>(
//                   stream: controller.scanResults,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return Expanded(
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final data = snapshot.data![index];
//                             String deviceName =
//                             data.device.name.isNotEmpty
//                                 ? data.device.name
//                                 : data.device.id.id;
//                             return Card(
//                               elevation: 2,
//                               child: ListTile(
//                                 title: Text(deviceName),
//                                 subtitle: Text(data.device.id.id),
//                                 trailing: Text(data.rssi.toString()),
//                                 onTap: () =>
//                                     controller.connectToDevice(data.device),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     } else {
//                       return Center(child: Text("No Device Found"));
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     controller.scanDevices();
//                     // await controller.disconnectDevice();
//                   },
//                   child: Text("SCAN"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
