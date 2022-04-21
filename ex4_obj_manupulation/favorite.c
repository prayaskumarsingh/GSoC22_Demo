// resource: for Java VM Type Signatures
// https://docs.oracle.com/javase/1.5.0/docs/guide/jni/spec/types.html#wp276
#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

// JVM Variables
JavaVM *vm;
JNIEnv *env;

jclass JavaClass;
jobject Object;
jmethodID show;

void startJVM()
{
      JavaVMInitArgs vm_args;
      vm_args.version = JNI_VERSION_1_8;
      vm_args.nOptions = 0;
      JavaVMOption options[0];
      vm_args.options = options;

      // Starting JVM
      jint res = JNI_CreateJavaVM(&vm, (void **)&env, &vm_args);

      // Finding Java Class
      JavaClass = (*env)->FindClass(env, "Favorite");

      // Finding Object Constructor
      jmethodID JavaClassConstructor = (*env)->GetMethodID(env, JavaClass, "<init>", "()V");

      // Instantiating Object of Class
      Object = (*env)->NewObject(env, JavaClass, JavaClassConstructor);

      // Getting Method ID for show method
      show = (*env)->GetMethodID(env, JavaClass, "show", "()V");

      printf("My Favorite Object:\n");
      (*env)->CallVoidMethod(env, Object, show);
}

void destroyJVM()
{
      (*vm)->DestroyJavaVM(vm);
}

void change(const char *newFav, const char *feild)
{
      // Get Java Class Feild ID
      jfieldID fid = (*env)->GetFieldID(env, JavaClass, feild, "Ljava/lang/String;");
      
      // Create a new C-string and assign to the JNI string
      jstring jnewFav = (*env)->NewStringUTF(env, newFav);

      // modify the instance variables
      (*env)->SetObjectField(env, Object, fid, jnewFav);

      // Calling Java Method
      (*env)->CallVoidMethod(env, Object, show);
      return;
}