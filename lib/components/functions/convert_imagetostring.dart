import 'dart:convert';
import 'dart:io';

Future<String?> convertImageToBase64(String? imagePath) async {
  if (imagePath == null) {
    return null;
  }
  File imageFile = File(imagePath);
  if (!imageFile.existsSync()) {
    print('File does not exist');
    return null;
  }
  List<int> imageBytes = await imageFile.readAsBytes();
  print('Base64 Image: ${base64Encode(imageBytes)}');
  return base64Encode(imageBytes);
}