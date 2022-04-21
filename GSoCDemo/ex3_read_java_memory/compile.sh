clear
javac Memory.java
gcc memory.c -dynamiclib -o libmemory.dylib -fPIC -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -L$JAVA_HOME/lib/server -L$JAVA_HOME/lib -ljli -ljvm -arch x86_64
install_name_tool -add_rpath $JAVA_HOME/lib libmemory.dylib
install_name_tool -add_rpath $JAVA_HOME/lib/server libmemory.dylib
dart run memory.dart
# java Memory