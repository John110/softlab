require 'opencv.rb'

class Filter
	def initialize
		@source_window = OpenCV::GUI::Window.new("SourceImage")
		@dest_window = OpenCV::GUI::Window.new("DestImage")
		@detector = OpenCV::CvHaarClassifierCascade::load("haarcascade_frontalface_default.xml")
		@capture = OpenCV::CvCapture.open
		@WIDTH = 300
		@HEIGHT = 240
		@KEY_1 = 49
		@KEY_2 = 50
		@KEY_3 = 51
		@KEY_Q = 113
	end

	def process
		mode = 0
		loop do
			@capture_image = @capture.query.resize OpenCV::CvSize.new(@WIDTH, @HEIGHT)
			@dest_image = @capture_image
			input_key = OpenCV::GUI::wait_key(1)
			if input_key != nil 
				mode = input_key
			end
			case mode
			when @KEY_1
				@dest_image = @dest_image.not
			when @KEY_2
				@dest_image = @dest_image.smooth(:blur, 10, 10)
			when @KEY_3
				@detector.detect_objects(@capture_image).each do |rect|
					puts "detect!! : #{rect.top_left}, #{rect.top_right}, #{rect.bottom_left}, #{rect.bottom_right}"
					@dest_image = @dest_image.rectangle(rect.top_left, rect.bottom_right, :color => OpenCV::CvColor::Red)
				end
			when @KEY_Q
				break
			end
			@source_window.show(@capture_image)
			@dest_window.show(@dest_image)
		end
		OpenCV::GUI::Window.destroy_all
	end
end

filter = Filter.new
filter.process
