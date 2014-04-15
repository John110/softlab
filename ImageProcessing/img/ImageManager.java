package img;
import java.awt.image.BufferedImage;
import java.io.*;
import javax.imageio.ImageIO;

public class ImageManager{
	static BufferedImage reader;
	static BufferedImage writer;
	static int width;
	static int height;
	
	public static void set_image(String file_name) throws IOException{
		reader = ImageIO.read(new File(file_name));
		width = reader.getWidth();
		height = reader.getHeight();
		writer = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	}
	
	public static void negapoji() throws IOException{
		for(int y=0;y<height;y++){
			for(int x=0;x<width;x++){
				int c = reader.getRGB(x, y);
				int r = 255-r(c);
				int g = 255-g(c);
				int b = 255-b(c);
				int rgb = rgb(r,g,b);
				writer.setRGB(x,y,rgb);
			}
		}
		File output_image = new File("negapoji.jpg");
		ImageIO.write(writer, "jpg", output_image);
	}
	
    public static int a(int c){
        return c>>>24;
    }
    public static int r(int c){
        return c>>16&0xff;
    }
    public static int g(int c){
        return c>>8&0xff;
    }
    public static int b(int c){
        return c&0xff;
    }
    public static int rgb
    (int r,int g,int b){
        return 0xff000000 | r <<16 | g <<8 | b;
    }
    public static int argb
    (int a,int r,int g,int b){
        return a<<24 | r <<16 | g <<8 | b;
    }

}
