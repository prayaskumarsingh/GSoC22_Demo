#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

int main(int argc, char const *argv[])
{
      return 0;
}

void sayHello()
{
      printf("In C: Starting JVM.\n");

      // JVM Variables
      JavaVM *vm;
      JNIEnv *env;

      // VM Args
      JavaVMInitArgs vm_args;
      vm_args.version = JNI_VERSION_1_8;
      vm_args.nOptions = 0;
      JavaVMOption options[0];
      // options[0].optionString = "-Djava.class.path=.";
      vm_args.options = options;

      // Starting JVM
      jint res = JNI_CreateJavaVM(&vm, (void **)&env, &vm_args);
      if (res != JNI_OK)
      {
            printf("Can't create Java VM\n");
            exit(1);
      }

      // Finding Java Class
      jclass cls = (*env)->FindClass(env, "Hello");
      if (cls == NULL)
      {
            printf("Hello class not found\n");
            exit(1);
      }

      // Finding function in class File
      jmethodID mid =
          (*env)->GetStaticMethodID(env, cls, "sayHello", "()V");
      if (mid == NULL)
      {
            printf("sayHello() method not found\n");
            exit(1);
      }

      // Calling Java Function
      printf("In C: Calling Java function.\n");
      (*env)->CallStaticVoidMethod(env, cls, mid);
      return;
}