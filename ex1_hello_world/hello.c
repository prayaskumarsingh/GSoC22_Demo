#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

// JVM Variables
JavaVM *vm;
JNIEnv *env;

jclass JavaClass;

void startJVM()
{
      printf("In C: Starting JVM.\n");

      // JVM Args
      JavaVMInitArgs vm_args;
      vm_args.version = JNI_VERSION_1_8;
      vm_args.nOptions = 0;
      JavaVMOption options[0];
      vm_args.options = options;

      // Starting JVM
      jint res = JNI_CreateJavaVM(&vm, (void **)&env, &vm_args);

      // Finding Java Class
      JavaClass = (*env)->FindClass(env, "Hello");
}

void destroyJVM()
{
      printf("In C: Destroying JVM.\n");
      (*vm)->DestroyJavaVM(vm);
}

void sayHello(char *name)
{

      // Finding sayHello function in class File
      jmethodID sayHello =
          (*env)->GetStaticMethodID(env, JavaClass, "sayHello", "(Ljava/lang/String;)V");

      // Calling Java Function
      printf("In C: Calling Java function.\n\n");
      jstring jstrName = (*env)->NewStringUTF(env, name);               // JVM accepts only UTF strings
      (*env)->CallStaticVoidMethod(env, JavaClass, sayHello, jstrName); // Calling Java Function in JVM

      printf("In C: Back in C.\n\n");
}