import static img.ImageManager.*;

import java.awt.image.BufferedImage;
import java.io.*;
import javax.imageio.ImageIO;

public class ImageProcessor{

    public static void main(String[] args) throws IOException{
        File input_image = new File("test.jpg");
        BufferedImage read=ImageIO.read(input_image);
        int width = read.getWidth(), height=read.getHeight();
        BufferedImage write =
                new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        int mode = Integer.parseInt(args[0]);
        if(mode == 1){
            for(int y=0;y<height;y++){
                for(int x=0;x<width;x++){
                    int c = read.getRGB(x, y);
                    int r = 255-r(c);
                    int g = 255-g(c);
                    int b = 255-b(c);
                    int rgb = rgb(r,g,b);
                    write.setRGB(x,y,rgb);
                }
            }
            File output_image = new File("ret.jpg");
            ImageIO.write(write, "jpg", output_image);
        }
    }
}
