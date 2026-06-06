import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PhotoStorageService {
  Future<String> copyIntoAppStorage(String sourcePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final photos = Directory(p.join(dir.path, 'progress_photos'));
    await photos.create(recursive: true);
    final ext = p.extension(sourcePath);
    final target = File(
      p.join(photos.path, 'photo_${DateTime.now().millisecondsSinceEpoch}$ext'),
    );
    return File(sourcePath).copy(target.path).then((file) => file.path);
  }
}
