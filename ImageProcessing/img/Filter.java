package img;
import java.awt.image.BufferedImage;
import java.io.*;
import javax.imageio.ImageIO;

public class Filter{
	static BufferedImage reader = ImageManager.reader;
	static BufferedImage writer = ImageManager.writer;
	static int width = ImageManager.width;
	static int height = ImageManager.height;

	public static void negapoji() throws IOException{
		for(int y=0;y<height;y++){
			for(int x=0;x<width;x++){
				int c = reader.getRGB(x, y);
				int r = 255 - ImageManager.r(c);
				int g = 255 - ImageManager.g(c);
				int b = 255 - ImageManager.b(c);
				int rgb = ImageManager.rgb(r,g,b);
				writer.setRGB(x,y,rgb);
			}
		}
		File output_image = new File("negapoji.jpg");
		ImageIO.write(writer, "jpg", output_image);
	}
}
