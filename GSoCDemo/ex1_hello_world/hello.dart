import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;

// FFI signature of the sayHello C function
typedef sayHelloFFISignature = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef sayHelloDartSignature = void Function();

void main() {
  if (Platform.isMacOS) {
    print("In Dart: Opening Dynamic Library wrapping Java Functions.");
    // Open the dynamic library
    var libraryPath = path.join(Directory.current.path, 'libhello.dylib');
    final dylib = ffi.DynamicLibrary.open(libraryPath);

    // Look up the C function 'hello_world'
    final sayHelloDartSignature sayHello = dylib
        .lookup<ffi.NativeFunction<sayHelloFFISignature>>('sayHello')
        .asFunction();

    // Call the function
    print("In Dart: Calling native function wrapping Java class.");
    sayHello();
  } else {
    print("This demo only runs on MacOS");
  }
}
