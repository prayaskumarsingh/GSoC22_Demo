import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

// FFI signature of the sayHello C function
typedef FFISignature = Void Function(Pointer<Utf8>);
// Dart type definition for calling the C foreign function
typedef DartSignature = void Function(Pointer<Utf8>);

// Start And Destroy JVM which connect to Java through C using FFI and JNI
final dylib = DynamicLibrary.open('./libpokemon.dylib');

// Start And Destroy JVM
final startJVM =
    dylib.lookupFunction<Void Function(), void Function()>('startJVM');
final destroyJVM =
    dylib.lookupFunction<Void Function(), void Function()>('destroyJVM');

// Look up evolve function in native
final evolve = dylib.lookupFunction<FFISignature, DartSignature>('evolve');

void main() {
  if (!Platform.isMacOS) {
    print("This demo only runs on MacOS");
    return;
  }

  startJVM();

  Pointer<Utf8>? myPokemon = "Charmander".toNativeUtf8();
  print("My Pokemen before evolution: " + myPokemon.toDartString());

  evolve(myPokemon); // calls native funtion which calls java function
  print("My Pokemen after evolution: " + myPokemon.toDartString());

  destroyJVM();

  print("\nProgram Over.");
}
