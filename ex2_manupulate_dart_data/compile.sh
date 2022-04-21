clear
javac Pokemon.java
gcc pokemon.c -dynamiclib -o libpokemon.dylib -fPIC -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin -L$JAVA_HOME/lib/server -L$JAVA_HOME/lib -ljli -ljvm -arch x86_64
install_name_tool -add_rpath $JAVA_HOME/lib libpokemon.dylib
install_name_tool -add_rpath $JAVA_HOME/lib/server libpokemon.dylib
dart run pokemon.dart