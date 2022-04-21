import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

// FFI signature of the sayHello C function
typedef FFISignature = Void Function(Pointer<Utf8>, Pointer<Utf8>);
// Dart type definition for calling the C foreign function
typedef DartSignature = void Function(Pointer<Utf8>, Pointer<Utf8>);

final dylib = DynamicLibrary.open('./libfavorite.dylib');

// Start And Destroy JVM which connect to Java through C using FFI and JNI
final startJVM =
    dylib.lookupFunction<Void Function(), void Function()>('startJVM');
final destroyJVM =
    dylib.lookupFunction<Void Function(), void Function()>('destroyJVM');

// Change Favorite Functions which connect to Java through C using FFI and JNI
final change = dylib.lookupFunction<FFISignature, DartSignature>('change');

void main() {
  if (!Platform.isMacOS) {
    print("This demo only runs on MacOS");
    return;
  }

  startJVM();

  bool flag = false;
  while (true) {
    print("Change your favorite:   1.color   2.song   3.movie   4:exit");
    String? choice = stdin.readLineSync();

    Pointer<Utf8> feild = "".toNativeUtf8();
    switch (int.parse(choice!)) {
      case 1:
        feild = "color".toNativeUtf8();
        break;
      case 2:
        feild = "song".toNativeUtf8();
        break;
      case 3:
        feild = "movie".toNativeUtf8();
        break;
      default:
        flag = true;
    }

    if (flag) break;

    print("Your new favorite is : ");
    Pointer<Utf8> newFav = stdin.readLineSync()!.toNativeUtf8();

    change(newFav, feild);
  }

  print("\nProgram Over.");
}
