import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ble_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class FindDeviceButton extends StatelessWidget {
  final BleController controller = Get.put(BleController());

  FindDeviceButton({Key? key}) : super(key: key);

  void _showDeviceList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("주변 기기",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(data.device.platformName.isEmpty
                                  ? 'Unknown Device'
                                  : data.device.platformName),
                              subtitle: Text(data.device.remoteId.str),
                              trailing: Text(data.rssi.toString()),
                              onTap: () =>
                                  controller.connectToDevice(data.device),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("기기를 찾고 있습니다..."));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startScan() async {
    try {
      await controller.scanDevices();
    } catch (e) {
      Get.snackbar(
        '스캔 오류',
        '기기 스캔 중 오류가 발생했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFCEBF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      onPressed: () {
        _startScan();
        _showDeviceList(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/movementstate-run.png',
            width: 32,
            height: 32,
            color: Colors.grey[600],
          ),
          SizedBox(width: 12),
          Text('주변 기기 찾기',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
