// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../constants/colors.dart';
// import '../controllers/ble_controller.dart';
// import 'package:flutter_blue/flutter_blue.dart';

// class FindDeviceButton extends StatelessWidget {
//   final BleController controller = Get.put(BleController());

//   FindDeviceButton({Key? key}) : super(key: key);

//   void _showDeviceList(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.6,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("주변 기기",
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               ),
//               Expanded(
//                 child: GetBuilder<BleController>(
//                   builder: (controller) {
//                     return StreamBuilder<List<ScanResult>>(
//                       stream: controller.scanResults,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return ListView.builder(
//                             itemCount: snapshot.data!.length,
//                             itemBuilder: (context, index) {
//                               final data = snapshot.data![index];
//                               return Card(
//                                 elevation: 2,
//                                 child: ListTile(
//                                   title: Text(data.device.name.isEmpty
//                                       ? 'Unknown Device'
//                                       : data.device.name),
//                                   subtitle: Text(data.device.id.id),
//                                   trailing: Text(data.rssi.toString()),
//                                   onTap: () =>
//                                       controller.connectToDevice(data.device),
//                                 ),
//                               );
//                             },
//                           );
//                         } else {
//                           return Center(child: Text("기기를 찾고 있습니다..."));
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFFFFCEBF),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         padding: EdgeInsets.symmetric(vertical: 12),
//       ),
//       onPressed: () {
//         controller.scanDevices();
//         _showDeviceList(context);
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset('assets/images/running_dog.png', width: 24, height: 24),
//           SizedBox(width: 8),
//           Text('주변 기기 찾기', style: TextStyle(color: Colors.grey[600])),
//         ],
//       ),
//     );
//   }
// }
