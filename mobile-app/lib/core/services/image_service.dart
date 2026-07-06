import 'dart:io';

class ImageService {
  Future<File?> pickImageFromGallery() async {
    // Wrapper for image_picker
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    // Wrapper for image_picker
    return null;
  }

  Future<File?> cropImage(File source) async {
    // Wrapper for image_cropper
    return source;
  }

  Future<File> compressImage(File source) async {
    // Wrapper for flutter_image_compress
    return source;
  }
}
