clear
javac Favorite.java
# gcc favorite.c -o libfavorite.o -fPIC -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -L$JAVA_HOME/lib/server -L$JAVA_HOME/lib -ljli -ljvm -arch x86_64
# install_name_tool -add_rpath $JAVA_HOME/lib libfavorite.o
# install_name_tool -add_rpath $JAVA_HOME/lib/server libfavorite.o
gcc favorite.c -dynamiclib -o libfavorite.dylib -fPIC -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -L$JAVA_HOME/lib/server -L$JAVA_HOME/lib -ljli -ljvm -arch x86_64
install_name_tool -add_rpath $JAVA_HOME/lib libfavorite.dylib
install_name_tool -add_rpath $JAVA_HOME/lib/server libfavorite.dylib
dart run favorite.dart