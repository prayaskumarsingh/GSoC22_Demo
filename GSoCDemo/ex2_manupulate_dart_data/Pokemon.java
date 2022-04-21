import java.nio.ByteOrder;
import java.nio.ByteBuffer;

public class Pokemon {

      public static void evolve(ByteBuffer myPokemon) {
            myPokemon.position(0);
            // myPokemon.order(ByteOrder.LITTLE_ENDIAN); // ByteOrder by default is Big Endian, but Dart uses Little Endian
            myPokemon.clear();

            byte[] evolvedPokemon = "Charlizard".getBytes();
            myPokemon.put(evolvedPokemon);
      }

}