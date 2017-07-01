#! /usr/bin/env python

import roslib
import rospy
import cv2
import sys, time
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

class ellipse_detection:

    def __init__(self):
        cv2.namedWindow('mywindow')
        cv2.namedWindow('thresh')

        #cv2.createTrackbar( 'l_M', 'mywindow', 0,300 , self.getTrackValue )
        #cv2.createTrackbar( 'h_M', 'mywindow', 0,300 , self.getTrackValue )
        #cv2.createTrackbar( 'thresh','thresh', 0,255 , self.getTrackValue )
        #cv2.createTrackbar( 'l_m', 'mywindow', 50,100 , self.getTrackValue )
        #cv2.createTrackbar( 'h_m', 'mywindow', 100,240 , self.getTrackValue )

        self.bridge = CvBridge()
        self.image_sub = rospy.Subscriber("usb_cam/image_raw",Image,self.callback)

    def callback(self,data):
        try:
            ret=img = self.bridge.imgmsg_to_cv2(data, "bgr8")
        except CvBridgeError as e:
            print(e)

        #l_M = cv2.getTrackbarPos('l_M','mywindow')
        #h_M = cv2.getTrackbarPos('h_M','mywindow')
        #l_m = cv2.getTrackbarPos('l_m','mywindow')
        #h_m = cv2.getTrackbarPos('h_m','mywindow')
        #thresh = cv2.getTrackbarPos('thresh','thresh')
        
        thresh=127     #need to change it as required
        imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        mblur = cv2.GaussianBlur(imgray,(5,5),0)
        ret,threshim = cv2.threshold(mblur,thresh,255,cv2.THRESH_BINARY)
        res = cv2.medianBlur(threshim,3)
        contours,hierarchy = cv2.findContours(res,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)

        for cnt in contours:
            if len(cnt) > 5: # at least 5 pts needed
                box = cv2.fitEllipse(cnt)
                (x,y),(MA,ma),angle=cv2.fitEllipse(cnt)
                if(h_M>MA>l_M and h_m>ma>l_m):  #TODO.. INCLUDE THE LOWER AND HIGHER VALUES OF MAJOR MINOR AXES
                    print x,y
                    cv2.ellipse(img,box,(200,0,0), 2)

        cv2.imshow('thresh', threshim)
        cv2.imshow('mywindow', img)
        cv2.waitKey(1)

    def getTrackValue(self, value):
        return value


def main(args):
    ed = ellipse_detection()
    rospy.init_node('ellipse_detection', anonymous=True)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down ellipse_detection")
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)
