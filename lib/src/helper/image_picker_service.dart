import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  /// Picks an image from the given [source].
  /// Defaults to [ImageSource.gallery] if no source is provided.
  static Future<File?> pickImage(
      {ImageSource source = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<bool> isFileValid(String? filePath) async {
    if (filePath == null || filePath.isEmpty) {
      return false;
    }
    final file = File(filePath);
    return await file.exists();
  }
}
