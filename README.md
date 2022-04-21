# GSoC'22 Demo
This repo contains proof of concept spaghetti code for Dart interop Java with C as intermediate interface and using JNI and dart:fii. This is made for GSoC '22 by Prayas Kumar Singh, a student at BITS Pilani, Goa Campus, India.

Please Note : I wil be be uploading a Video demo of my Programs very soon.

---

## How to run Programs

### Requirements

x86 JDK installed with $JAVA_HOME set in PATH

Dart-lang installed

### compile.sh

Java and C program files can easily compiled using `./compile.sh` scripts. This scripts compiles java file to java bytecode. Followed by compiling C and attaching runtime envoirment files (JNI and JLI files). Lastly calls Dart main function to run the program.

This should seemlessly work for Apple Silicone Mac with installed requirements. Other envoirements like Windows and Linux will require changes like compiling and making references to envoirment specific dynamic files (.dll and .so files) in each program.

I could have used software like CMAKE, etc but for simplicty I decided not to.

---

## Descrpition of examples
### Example 1 : Hello World

This example takes name of `user` as input in dart as `Pointer<int32>`. Then passes the input to C using dart:ffi, which in turn passes this input to Java in JVM using JNI. Latly, Java code prints a greeting with `name`.

The program also shows flow of control by printing outputs in the terminal.

---
  
### Example 2 : Manupulate Dart Data

This example manupulates Dart code in Java using ByteStream API in Java.

A pointer called `myPokemon` in Dart is created and passed to a method `evolve()` in Java through C. The method changes the value stored at `myPokemon` pointer.
  
Thing to note is flow of data is only a pointer down into Java. No data comes out of Java and value stored is changed.
  
---
  
### Example 3 : Read Java Memory
  
This example allocates a array of 10 `int` or `int[10]` in form of bytestream in Java and the pointer is given up to dart using C. The data stored in this array is accessed using fucntions in dart.
  
Thing to note is flow of data is only a pointer up to Dart. No data comes out of Java and still data is accessed. It is also possible to alter data, but I havent for simplicity of example. The changes made to data on either side will be reflected on both sides as they are at the same memory location.

---
  
### Example 4 : Java Object Manupulation by Dart Code
  
This example creates a object of class `Favorite` in Java which holds information like your favorite color, song and movie. The main control of program is always in Dart. The Dart program asks for your new favorite as  and updates the `Favorite` object using interface created using C functions.

The thing to note is control of program is always with dart and no `Favorite` Class has no methods.
