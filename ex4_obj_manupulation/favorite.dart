import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

// FFI signature of the sayHello C function
typedef FFISignature = ffi.Void Function(ffi.Pointer<Utf8>);
// Dart type definition for calling the C foreign function
typedef DartSignature = void Function(ffi.Pointer<Utf8>);

final dylib = ffi.DynamicLibrary.open('./libfavorite.dylib');

// Start And Destroy JVM which connect to Java through C using FFI and JNI
final startJVM =
    dylib.lookupFunction<ffi.Void Function(), void Function()>('startJVM');
final destroyJVM =
    dylib.lookupFunction<ffi.Void Function(), void Function()>('destroyJVM');

// Change Favorite Functions which connect to Java through C using FFI and JNI
final changeColor =
    dylib.lookupFunction<FFISignature, DartSignature>('changeColor');
final changeSong =
    dylib.lookupFunction<FFISignature, DartSignature>('changeSong');
final changeMovie =
    dylib.lookupFunction<FFISignature, DartSignature>('changeMovie');

void main() {
  if (!Platform.isMacOS) {
    print("This demo only runs on MacOS");
    return;
  }

  startJVM();

  bool flag = false;
  while (!flag) {
    print("Change your favorite:   1.color   2.song   3.movie   4:exit");
    String? choice = stdin.readLineSync();

    print("Your new favorite is : ");
    ffi.Pointer<Utf8> newFav = stdin.readLineSync()!.toNativeUtf8();

    switch (int.parse(choice!)) {
      case 1:
        changeColor(newFav);
        break;
      case 2:
        changeSong(newFav);
        break;
      case 3:
        changeMovie(newFav);
        break;
      default:
        flag = true;
    }
  }

  print("\nProgram Over.");
}
