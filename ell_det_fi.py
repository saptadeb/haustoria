# -*- coding: utf-8 -*-
"""
Created on Sun Feb 19 16:51:45 2017

@author: Parv Khandelwal
"""

import numpy as np
import cv2

cap = cv2.VideoCapture(1)
cap.set(5,2)

def onChange(trackbarValue):
    cap.set(cv2.CAP_PROP_POS_FRAMES,trackbarValue)
    err,img = cap.read()
    #cv2.imshow("mywindow", img)
    pass

cv2.namedWindow('mywindow')
cv2.namedWindow('thresh')

cv2.createTrackbar( 'l_M', 'mywindow', 0,300 , onChange )
cv2.createTrackbar( 'h_M', 'mywindow', 0,300 , onChange )
cv2.createTrackbar( 'h_M', 'mywindow', 0,300 , onChange )
cv2.createTrackbar( 'thresh','thresh', 0,255 , onChange )

cv2.createTrackbar( 'l_m', 'mywindow', 50,100 , onChange )
cv2.createTrackbar( 'h_m', 'mywindow', 100,240 , onChange )




onChange(0)
cv2.waitKey(1) 

while(True):
    # Capture frame-by-frame
    l_M = cv2.getTrackbarPos('l_M','mywindow')
    cap.set(cv2.CAP_PROP_POS_FRAMES,l_M)
    
    h_M = cv2.getTrackbarPos('h_M','mywindow')
    cap.set(cv2.CAP_PROP_POS_FRAMES,h_M)
    
    l_m = cv2.getTrackbarPos('l_m','mywindow')
    cap.set(cv2.CAP_PROP_POS_FRAMES,l_m)
    
    h_m = cv2.getTrackbarPos('h_m','mywindow')
    cap.set(cv2.CAP_PROP_POS_FRAMES,h_m)
    
    thresh = cv2.getTrackbarPos('thresh','thresh')
    cap.set(cv2.CAP_PROP_POS_FRAMES,thresh)
    
    ret, img = cap.read()
    imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    #mblur = cv2.medianBlur(imgray,5)
    mblur = cv2.GaussianBlur(imgray,(5,5),0)
    #equ = cv2.equalizeHist(mblur)
    ret,thresh = cv2.threshold(mblur,thresh,255,cv2.THRESH_BINARY)
    #thresh = cv2.adaptiveThreshold(mblur,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,15,2)
    #kernel = np.ones((5,5),np.uint8)
    #erosion = cv2.erode(thresh,kernel,iterations = 1)
    #dilation = cv2.dilate(erosion,kernel,iterations = 1)
    #opening = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, kernel)
    #y=thresh
    res = cv2.medianBlur(thresh,3)
    
    
    img2,contours,hierarchy = cv2.findContours(res,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
    #cv2.drawContours( img, contours,-1, (128,255,255), 2)
    for cnt in contours:
        if len(cnt) > 5: # at least 5 pts needed
            
            box = cv2.fitEllipse(cnt)
            (x,y),(MA,ma),angle=cv2.fitEllipse(cnt)
            if(h_M>MA>l_M and h_m>ma>l_m):
           
		print x,y
                cv2.ellipse(img,box,(200,0,0), 2)
               

    #cv2.imshow('contours', mblur)
    cv2.imshow('thresh', thresh)
    #cv2.imshow('closing',erosion)
    
    cv2.imshow('mywindow', img)
    if cv2.waitKey(1) == 27:
        break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()
