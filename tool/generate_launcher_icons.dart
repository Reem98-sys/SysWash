import 'dart:io';
import 'package:image/image.dart' as img;

Future<void> main() async {
  const inputPath = 'assets/icon.png';
  const outputForeground = 'assets/icon_foreground.png';
  const outputBackground = 'assets/icon_background.png';
  const scale = 0.7; // Adjust: smaller = more padding

  print('⚙️ Loading $inputPath...');
  final originalBytes = File(inputPath).readAsBytesSync();
  final original = img.decodeImage(originalBytes)!;

  print('📏 Resizing to ${(scale * 100).toInt()}%...');
  final resized = img.copyResize(
    original,
    width: (original.width * scale).round(),
    height: (original.height * scale).round(),
  );

  print('🖼️ Creating white background...');
  // ✅ Works with image: ^4.x
  final background = img.Image(width: original.width, height: original.height);
  background.clear(img.ColorRgb8(255, 255, 255)); // fill with white

  final offsetX = ((original.width - resized.width) ~/ 2);
  final offsetY = ((original.height - resized.height) ~/ 2);

  print('📍 Centering logo...');
  img.compositeImage(
    background,
    resized,
    dstX: offsetX,
    dstY: offsetY,
  );

  print('💾 Saving new images...');
  File(outputForeground).writeAsBytesSync(img.encodePng(background));

  // plain white background
  final bgWhite = img.Image(width: original.width, height: original.height);
  bgWhite.clear(img.ColorRgb8(255, 255, 255));
  File(outputBackground).writeAsBytesSync(img.encodePng(bgWhite));

  print('✅ Done!');
  print('Foreground saved as: $outputForeground');
  print('Background saved as: $outputBackground');
  print('\n👉 Next: Run\nflutter pub run flutter_launcher_icons');
}
