#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

// JVM Variables
JavaVM *vm;
JNIEnv *env;

jclass JavaClass;

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
      JavaClass = (*env)->FindClass(env, "Pokemon");
}

void destroyJVM()
{
      (*vm)->DestroyJavaVM(vm);
}

void evolve(char *myPokemon)
{
      jobject bbObject = (*env)->NewDirectByteBuffer(env, myPokemon, 10);

      // Finding evolve Method ID
      jmethodID evolveJava = (*env)->GetStaticMethodID(env, JavaClass, "evolve", "(Ljava/nio/ByteBuffer;)V");

      // Calling evolve java function
      (*env)->CallStaticVoidMethod(env, JavaClass, evolveJava, bbObject);
}