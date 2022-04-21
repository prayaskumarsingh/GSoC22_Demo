import 'dart:ffi';
import 'dart:io';

typedef GetJavaMemory = Pointer<Int32> Function();

final dylib = DynamicLibrary.open('./libmemory.dylib');

// Start And Destroy JVM C functions
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
