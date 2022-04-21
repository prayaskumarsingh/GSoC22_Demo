import 'dart:ffi';
import 'dart:io';

// FFI and Dart Signatures
typedef GetJavaMemory = Pointer<Int32> Function();

// Opening dynamic native file
final dylib = DynamicLibrary.open('./libmemory.dylib');

// Start And Destroy JVM which connect to Java through C using FFI and JNI
final startJVM =
    dylib.lookupFunction<Void Function(), void Function()>('startJVM');
final destroyJVM =
    dylib.lookupFunction<Void Function(), void Function()>('destroyJVM');

// Look up the C functions
final getJavaMemoryAddress =
    dylib.lookupFunction<GetJavaMemory, GetJavaMemory>('getJavaMemoryAddress');

void main() {
  if (!Platform.isMacOS) {
    print("This demo only runs on MacOS");
    return;
  }
  startJVM();

  final ptr = getJavaMemoryAddress();

  // Print elements recived from Java
  for (var i = 0; i < 10; i++) print(ptr.elementAt(i).value);

  destroyJVM();
  print("\nProgram Over.");
}
