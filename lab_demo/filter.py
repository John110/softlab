import cv

class Filter:
  def __init__(self):
    cv.NamedWindow("SourceImage",1)
    cv.NamedWindow("DestImage",1)
    self.detector = cv.Load("haarcascade_frontalface_default.xml")
    self.capture = cv.CreateCameraCapture(0)
    self.WIDTH = 300
    self.HEIGHT = 240
    self.KEY_1 = 49
    self.KEY_2 = 50
    self.KEY_3 = 51
    self.KEY_4 = 52
    self.KEY_5 = 53
    self.KEY_Q = 113

  def process(self):
    flag = None
    mode = None
    HAAR_SCALE = 1.2
    MIN_NEIGHBORS = 2
    HAAR_FLAGS = 0
    MIN_SIZE = (20, 20)
    cv.SetCaptureProperty(self.capture, cv.CV_CAP_PROP_FRAME_WIDTH, self.WIDTH)
    cv.SetCaptureProperty(self.capture, cv.CV_CAP_PROP_FRAME_HEIGHT, self.HEIGHT)
    while True:
      image_of_source = cv.QueryFrame(self.capture)
      image_of_dest = cv.CloneImage(image_of_source)
      flag = cv.WaitKey(1)
      if flag != -1 :
        mode = flag
      if mode == self.KEY_1:
        cv.Not(image_of_source, image_of_dest)
      elif mode == self.KEY_2:
        cv.Smooth(image_of_source, image_of_dest, cv.CV_BLUR, 10, 10)
      elif mode == self.KEY_3:
        model = 10
        for i in xrange(0, self.HEIGHT - 1):
          for j in xrange(0, self.WIDTH - 1):
            bgr = cv.Get2D(image_of_source, i, j)
            next_pixel_bgr = cv.Get2D(image_of_source, i + 1, j + 1)
            if abs(bgr[0] - next_pixel_bgr[0]) > model or abs(bgr[1] - next_pixel_bgr[1]) > model or abs(bgr[2] - next_pixel_bgr[2]) > model:
              cv.Set2D(image_of_dest, i, j, (0, 0, 0))
            else:
              cv.Set2D(image_of_dest, i, j, (255, 255, 255))
      elif mode == self.KEY_4:
        for i in xrange(0, self.HEIGHT):
          for j in xrange(0, self.WIDTH):
            bgr = cv.Get2D(image_of_source, i, j)
            if bgr[2] > bgr[1] and bgr[2] > bgr[0]:
              cv.Set2D(image_of_dest, i, j, (0, 0, 255))
            elif bgr[1] > bgr[0]:
              cv.Set2D(image_of_dest, i, j, (0, 255, 0))
            else:
              cv.Set2D(image_of_dest, i, j, (255, 0, 0))
      elif mode == self.KEY_5:
        face = cv.HaarDetectObjects(image_of_dest, self.detector, cv.CreateMemStorage(0), HAAR_SCALE, MIN_NEIGHBORS, HAAR_FLAGS, MIN_SIZE)
        for ((x, y, w, h), n) in face:
          cv.Rectangle(image_of_dest, (x, y), (x + w, y + h), cv.RGB(255, 0, 0), 1, 0)
      elif mode == self.KEY_Q:
        break
      cv.ShowImage("SourceImage", image_of_source)
      cv.ShowImage("DestImage", image_of_dest) 
    cv.DestroyAllWindows()


filter = Filter()
filter.process()





	


