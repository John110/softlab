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
			@image_of_capture = @capture.query.resize OpenCV::CvSize.new(@WIDTH, @HEIGHT)
			@image_of_dest = @image_of_capture
			input_key = OpenCV::GUI::wait_key(1)
			if input_key != nil 
				mode = input_key
			end
			case mode
			when @KEY_1
				@image_of_dest = @image_of_dest.not
			when @KEY_2
				@image_of_dest = @image_of_dest.smooth(:blur, 10, 10)
			when @KEY_3
				@detector.detect_objects(@image_of_capture).each do |rect|
					puts "detect!! : #{rect.top_left}, #{rect.top_right}, #{rect.bottom_left}, #{rect.bottom_right}"
					@image_of_dest = @image_of_dest.rectangle(rect.top_left, rect.bottom_right, :color => OpenCV::CvColor::Red)
				end
			when @KEY_Q
				break
			end
			@source_window.show(@image_of_capture)
			@dest_window.show(@image_of_dest)
		end
		OpenCV::GUI::Window.destroy_all
	end
end

filter = Filter.new
filter.process
