import java.nio.ByteBuffer;

public class Pokemon {
      public static void evolve(ByteBuffer myPokemon) {
            byte[] evolvedPokemon = "Charlizard".getBytes();
            myPokemon.put(evolvedPokemon);
      }
}