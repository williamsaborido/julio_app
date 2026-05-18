import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Service responsible for sharing data and saving files to the device.
class SharingService {
  /// Shares a list of bytes as a file with the given [fileName].
  /// 
  /// The file is temporarily saved in the device's cache directory before being shared.
  Future<void> shareBytes(Uint8List bytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    
    await file.writeAsBytes(bytes);
    
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: fileName,
    );
  }

  /// Saves a list of bytes to a file in the application's documents directory.
  /// 
  /// Returns the path of the saved file.
  Future<String> saveFile(Uint8List bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    
    await file.writeAsBytes(bytes);
    
    return file.path;
  }

  /// Saves a list of bytes to a file in the external storage directory (Android only).
  /// 
  /// If external storage is not available, it falls back to the documents directory.
  /// Returns the path of the saved file.
  Future<String> saveToExternalStorage(Uint8List bytes, String fileName) async {
    Directory? directory;
    
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    }
    
    // Fallback to documents directory if external is not available or not Android
    directory ??= await getApplicationDocumentsDirectory();
    
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    
    return file.path;
  }
}
