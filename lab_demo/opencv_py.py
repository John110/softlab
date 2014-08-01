import cv
import numpy

#initialize
cv.NamedWindow("window_image",1)
cv.NamedWindow("window_dst",1)
videoCapture = cv.CreateCameraCapture(0)
dstCapture = cv.CreateCameraCapture(0)
WIDTH = 300
HEIGHT = 240
KEY_1 = 49
KEY_2 = 50
KEY_3 = 51
KEY_4 = 52
KEY_Q = 113

cv.SetCaptureProperty(videoCapture, cv.CV_CAP_PROP_FRAME_WIDTH, WIDTH)
cv.SetCaptureProperty(videoCapture, cv.CV_CAP_PROP_FRAME_HEIGHT, HEIGHT)
cv.SetCaptureProperty(dstCapture, cv.CV_CAP_PROP_FRAME_WIDTH, WIDTH)
cv.SetCaptureProperty(dstCapture, cv.CV_CAP_PROP_FRAME_HEIGHT, HEIGHT)
flag = None
mode = None

while True:
	captureImage = cv.QueryFrame(videoCapture)
	dstImage = cv.QueryFrame(dstCapture)
	flag = cv.WaitKey(1)
	if flag != -1 :
		mode = flag
	if mode == KEY_1:
		cv.Not(dstImage, dstImage)
	elif mode == KEY_2:
		cv.Smooth(dstImage, dstImage, cv.CV_BLUR, 10, 10)
	elif mode == KEY_3:
		model = 10
		for i in range(0, HEIGHT - 1):
			for j in range(0, WIDTH - 1):
				seq = cv.Get2D(captureImage, i, j)
				seq2 = cv.Get2D(captureImage, i + 1, j + 1)
				if abs(seq[0] - seq2[0]) > model or abs(seq[1] - seq2[1]) > model or abs(seq[2] - seq2[2]) > model:
					cv.Set2D(dstImage, i, j, (0, 0, 0))
				else:
					cv.Set2D(dstImage, i, j, (255, 255, 255))
	elif mode == KEY_4:
		for i in range(0, HEIGHT):
			for j in range(0, WIDTH):
				seq = cv.Get2D(dstImage, i, j)
				if seq[2] > seq[1] and seq[2] >seq[0]:
					cv.Set2D(dstImage, i, j, (0, 0, 255))
				elif seq[1] > seq[0]:
					cv.Set2D(dstImage, i, j, (0, 255, 0))
				else:
					cv.Set2D(dstImage, i, j, (255, 0, 0))
	elif mode == KEY_Q:
		break

	cv.ShowImage("window_image", captureImage)
	cv.ShowImage("window_dst", dstImage)
	
cv.DestroyAllWindow()

