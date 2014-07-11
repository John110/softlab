import cv
import numpy

cv.NamedWindow("window_image",1)
cv.NamedWindow("window_dst",1)
videoCapture = cv.CreateCameraCapture(0)
dstCapture = cv.CreateCameraCapture(0)
width = 300
height = 240

cv.SetCaptureProperty(videoCapture, cv.CV_CAP_PROP_FRAME_WIDTH, width)
cv.SetCaptureProperty(videoCapture, cv.CV_CAP_PROP_FRAME_HEIGHT, height)
cv.SetCaptureProperty(dstCapture, cv.CV_CAP_PROP_FRAME_WIDTH, width)
cv.SetCaptureProperty(dstCapture, cv.CV_CAP_PROP_FRAME_HEIGHT, height)
flag = None
mode = None

while True:
	captureImage = cv.QueryFrame(videoCapture)
	dstImage = cv.QueryFrame(dstCapture)
	flag = cv.WaitKey(1)
	if flag != -1 :
		mode = flag

	if mode == 49:
		cv.Not(dstImage, dstImage)
	elif mode == 50:
		cv.Smooth(dstImage, dstImage, cv.CV_BLUR, 10, 10)
	elif mode == 51:
		model = 10
		for i in range(0, height):
			for j in range(0, width):
				seq = cv.Get2D(dstImage, i, j)
				cv.Set2D(dstImage, i, j, (255, 255, 255))
		for i in range(0, height - 1):
			for j in range(0, width - 1):
				seq2 = cv.Get2D(captureImage, i, j)
				seq3 = cv.Get2D(captureImage, i + 1, j + 1)
				if abs(seq2[0] - seq3[0]) > model or abs(seq2[1] - seq3[1]) > model or abs(seq2[2] - seq3[2]) > model:
					cv.Set2D(dstImage, i, j, (0, 0, 0))
	elif mode == 52:
		for i in range(0, height):
			for j in range(0, width):
				seq = cv.Get2D(dstImage, i, j)
				if seq[2] > seq[1] and seq[2] >seq[0]:
					cv.Set2D(dstImage, i, j, (0, 0, 255))
				elif seq[1] > seq[0]:
					cv.Set2D(dstImage, i, j, (0, 255, 0))
				else:
					cv.Set2D(dstImage, i, j, (255, 0, 0))



	cv.ShowImage("window_image", captureImage)
	cv.ShowImage("window_dst", dstImage)
	
cv.DestroyAllWindow()

