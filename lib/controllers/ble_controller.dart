import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  BluetoothDevice? connectedDevice;
  List<BluetoothService> services = [];
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  StreamSubscription<List<int>>? _characteristicSubscription;

  RxList<String> receivedDataList = <String>[].obs;

  // 이 클래스 안에서만 사용되는 private 변수
  String _completeData = "";

  // 다른 클래스에서 사용할 수신한 전체데이터 변수
  String get completeData => _completeData;

  @override
  void onInit() {
    super.onInit();
    // 블루투스 어댑터 상태 모니터링
    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      // 상태에 따른 처리
      print('Bluetooth adapter state: $state');
    });
  }

  @override
  void dispose() {
    connectedDevice?.disconnect();
    _adapterStateSubscription?.cancel();
    _characteristicSubscription?.cancel();
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  Future<void> scanDevices() async {
    bool permissionsGranted = await _requestPermissions();

    if (permissionsGranted) {
      try {
        await FlutterBluePlus.startScan(timeout: Duration(seconds: 10));
        await Future.delayed(Duration(seconds: 10));
      } catch (e) {
        print("스캔 중 오류 발생: $e");
      } finally {
        await FlutterBluePlus.stopScan();
      }
    } else {
      print("필요한 권한이 부여되지 않았습니다.");
      // 여기에 사용자에게 권한이 필요하다는 메시지를 표시하는 로직을 추가할 수 있습니다.
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(timeout: Duration(seconds: 15));
      connectedDevice = device;
      print("기기 연결됨 : $connectedDevice");

      services = await device.discoverServices();

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid ==
              Guid('00002a57-0000-1000-8000-00805f9b34fb')) {
            if (characteristic.properties.notify) {
              print("캐릭터 : $characteristic");
              await _subscribeToCharacteristic(characteristic);
            }
          }
        }
      }
    } catch (e) {
      print("에러 발생: $e");
    }
  }

  Future<void> _subscribeToCharacteristic(
      BluetoothCharacteristic characteristic) async {
    await characteristic.setNotifyValue(true);
    _characteristicSubscription =
        characteristic.onValueReceived.listen((value) {
      String data = utf8.decode(value);

      // 누적
      if (data.contains('!')) {
        _completeData += data;
        print("Complete Data Received! : $_completeData");
        _completeData = "";
      } else {
        _completeData += data;
      }

      // print("Received data: $data");
      receivedDataList.add(data);
      if (receivedDataList.length > 100) {
        receivedDataList.removeAt(0);
      }
    });
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  @override
  void onClose() {
    _adapterStateSubscription?.cancel();
    _characteristicSubscription?.cancel();
    super.onClose();
  }
}
