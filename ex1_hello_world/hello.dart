import 'dart:ffi';
import 'dart:io';

import 'package:ffi/dart';

// FFI signature of C function
typedef sayHelloFFISignature = Void Function(Pointer<Utf8>);
// Dart signature for calling the C foreign function
typedef sayHelloDartSignature = void Function(Pointer<Utf8>);

// Opening dynamic native file
final dylib = DynamicLibrary.open('./libhello.dylib');

// Start And Destroy JVM which connect to Java through C using FFI and JNI
final startJVM =
    dylib.lookupFunction<Void Function(), void Function()>('startJVM');
final destroyJVM =
    dylib.lookupFunction<Void Function(), void Function()>('destroyJVM');

// Look up the C function in native file
final sayHello = dylib
    .lookupFunction<sayHelloFFISignature, sayHelloDartSignature>('sayHello');

void main() {
  if (!Platform.isMacOS) {
    print("This demo only runs on MacOS");
    return;
  }

  print("In Dart: Program Starts.");
  startJVM();

  // Reading name
  print("In Dart: Enter your name?");
  Pointer<Utf8>? name = stdin.readLineSync()!.toNativeUtf8();

  // Call the function
  print("In Dart: Calling native function wrapping Java.\n");
  sayHello(name);

  print("In Dart: Back in Dart.");

  destroyJVM();
  print("Program Over.");
}
