# GSoC'22 Demo
This repo contains proof of concept spaghetti code for Dart interop Java with C as intermediate interface and using JNI and dart:fii. This is made for GSoC '22 by Prayas Kumar Singh, a student at BITS Pilani, Goa Campus, India.

Please Note: I will be uploading a Video demo of my Programs very soon.

---

## How to run Programs

### Requirements

x86 JDK installed with $JAVA_HOME set in PATH

Dart-lang installed

### compile.sh

Java and C program files can easily compile using `./compile.sh` scripts. This script compiles the java file to java bytecode. Followed by compiling C and attaching runtime environment files (JNI and JLI files). Lastly calls, Dart’s main function to run the program.

This should seamlessly work for Apple Silicone Mac with installed requirements. Other environments like Windows and Linux will require changes like compiling and referencing environment-specific dynamic files (.dll and .so files) in each program.

I could have used software like CMAKE, etc., but I decided not to for simplicity.

---

## Description of examples
### Example 1 : Hello World

This example takes the name of `user` as input in dart as `Pointer<int32>`. Then passes the input to C using dart:ffi, which passes this input to Java in JVM using JNI. Lastly, Java code prints a greeting with `name`.

The program also shows the control flow by printing outputs in the terminal.

---
  
### Example 2: Manipulate Dart Data

This example manipulates Dart code in Java using ByteStream API in Java.

A pointer called `myPokemon` in Dart is created and passed to a method `evolve()` in Java through C. The method changes the value stored at the `myPokemon` pointer.
  
The thing to note is the flow of data is only a pointer down into Java. No data comes out of Java, and the value stored is changed.
  
---
  
### Example 3: Read Java Memory
  
This example allocates an array of 10 `int` or `int[10]` in the form of bytestream in Java, and the pointer is given up to dart using C. The data stored in this array is accessed using functions in dart.
  
The thing to note is the flow of data is only a pointer up to Dart. No data comes out of Java, and still, data is accessed. It is also possible to alter data, but I haven’t for simplicity. The changes made to data on either side will be reflected on both sides as they are at the exact memory location.

---
  
### Example 4: Java Object Manipulation by Dart Code
  
This example creates an object of class `Favorite` in Java which holds information like your favorite color, song, and movie. The main control of the program is always in Dart. The Dart program asks for your new favorite and updates the `Favorite` object using an interface created using C functions.

The thing to note is control of the program is always with the dart and the `Favorite` Class in Java has no methods.

