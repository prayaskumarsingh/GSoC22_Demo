#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

// JVM Variables
JavaVM *vm;
JNIEnv *env;

jclass JavaClass;
jmethodID JavaClassConstructor;

void startJVM()
{
      JavaVMInitArgs vm_args;
      vm_args.version = JNI_VERSION_1_8;
      vm_args.nOptions = 0;
      JavaVMOption options[0];
      vm_args.options = options;

      // Starting JVM
      jint res = JNI_CreateJavaVM(&vm, (void **)&env, &vm_args);
      if (res != JNI_OK)
      {
            printf("Can't create Java VM\n");
            exit(1);
      }

      // Finding Java Class
      JavaClass = (*env)->FindClass(env, "Memory");
      if (JavaClass == NULL)
      {
            printf("Class not found\n");
            exit(1);
      }

      // Finding Object Constructor
      JavaClassConstructor = (*env)->GetMethodID(env, JavaClass, "<init>", "()V");
      if (JavaClassConstructor == NULL)
      {
            printf("Constuctor not found\n");
            exit(1);
      }

      return;
}

void destroyJVM()
{
      (*vm)->DestroyJavaVM(vm);
      return;
}

int *getJavaMemoryAddress()
{
      // Object of Class
      jobject Object = (*env)->NewObject(env, JavaClass, JavaClassConstructor);

      // Feild ID of class
      jfieldID fidBB = (*env)->GetFieldID(env, JavaClass, "buf", "Ljava/nio/ByteBuffer;");

      // Get object buf within the object of Memory Class
      jobject buf = (*env)->GetObjectField(env, Object, fidBB);

      // Getting memory address of byte stream
      int *v = (*env)->GetDirectBufferAddress(env, buf);
      return v;
}