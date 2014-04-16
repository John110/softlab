import static img.ImageManager.*;
import static img.Filter.*;

import java.awt.image.BufferedImage;
import java.io.*;


public class ImageProcessor{

	public static void main(String[] args) throws IOException{
		set_image("test.jpg");
		int mode = Integer.parseInt(args[0]);
		if(mode == 1){
			negapoji();
		}
	}
}
