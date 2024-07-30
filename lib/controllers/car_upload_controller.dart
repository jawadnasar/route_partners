import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CarUploadController extends GetxController implements GetxService {
  List<File> _files = [];
  List<File> get files => _files;

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  late TextEditingController capacity;
  late TextEditingController modalYear;
  late TextEditingController carModal;
  late TextEditingController carRegisteredArea;
  late TextEditingController description;
  late TextEditingController sellerName;
  late TextEditingController price;
  late TextEditingController? primaryMobNum;
  late TextEditingController secondaryPhone;
  late TextEditingController carExteriorColor;
  clearAll() {
    capacity.clear();
    description.clear();
    sellerName.clear();
    price.clear();
    primaryMobNum?.clear();
    secondaryPhone.clear();
    _files = [];
    update();
  }

  bool? whatsapp = false;

  addImage(File file) {
    files.add(file);
    update();
  }

  removeFile(int index) {
    _files.removeAt(index);
    update();
  }

  Future<List<File>?> pickImages({
    bool allowMultiple = true,
    BuildContext? context,
  }) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowedExtensions: [
        'png',
        'jpg',
      ], allowMultiple: true, type: FileType.custom, allowCompression: true);

      if (result != null) {
        List<File> files =
            result.paths.map((path) => File(path!)).toSet().toList();
        _files.addAll(files);
        update();
      }
      update();
    } catch (e) {
      log(e.toString());
    }

    update();
    return null;
  }

  updateIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  @override
  void onInit() {
    modalYear = TextEditingController();
    carModal = TextEditingController();
    capacity = TextEditingController();
    carExteriorColor = TextEditingController();
    carRegisteredArea = TextEditingController();
    description = TextEditingController();
    sellerName = TextEditingController();
    price = TextEditingController();
    primaryMobNum = TextEditingController();
    secondaryPhone = TextEditingController();

    super.onInit();
  }

  static CarUploadController get i => Get.put(CarUploadController());
}
