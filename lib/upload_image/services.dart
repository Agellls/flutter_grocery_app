import 'dart:typed_data';
import 'package:dio/dio.dart';

class UploadApiImage {
  Future<dynamic> uploadImage(Uint8List bytes, String fileName) async {
    var dio = Dio();
    var formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(bytes, filename: fileName),
    });

    try {
      var response = await dio.post(
        "https://api.escuelajs.co/api/v1/files/upload",
        data: formData,
      );

      if (response.statusCode == 201) {
        // Decode and return the response data
        return response.data;
      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Dio error: ${e.response?.statusCode}");
      print(e.message);
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
