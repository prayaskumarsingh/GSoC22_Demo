clear
javac Hello.java
gcc hello.c -dynamiclib -o libhello.dylib -fPIC -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -L$JAVA_HOME/lib/server -L$JAVA_HOME/lib -ljli -ljvm -arch x86_64
install_name_tool -add_rpath $JAVA_HOME/lib libhello.dylib
install_name_tool -add_rpath $JAVA_HOME/lib/server libhello.dylib
dart run hello.dart