import java.nio.ByteBuffer;
import java.nio.ByteOrder;

public class Memory {
      private ByteBuffer buf;

      Memory() {
            buf = ByteBuffer.allocateDirect(10 * Integer.BYTES );
            buf.order(ByteOrder.LITTLE_ENDIAN); // ByteOrder by default is Big Endian, but C uses Little Endian

            // Populate buffer
            for (int i = 0; i < 10; i++)
                  buf.putInt((int) i);

            buf.position(0);
      }
}