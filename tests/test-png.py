import sys
import matplotlib.image as img
import numpy as np

if len(sys.argv) != 4:
    print sys.argv
    print "Parameters number" + (len(sys.argv)-1) + "!=3"
    sys.exit( 1 )

try:
    im_refr = img.imread(sys.argv[1])
except IOError:
    print "Error openning file" + sys.argv[1]
    sys.exit( 2 )
try:
    im_test = img.imread(sys.argv[2])
except IOError:
    print "Error openning file" + sys.argv[2]
    sys.exit( 2 )

if im_refr.shape != im_test.shape:
    print "Shapes are different. " + str(im_refr.shape) + " " + str(im_test.shape)
    sys.exit( 3 )

error=0

# sum colors
imAbw = im_refr[:,:,0] + im_refr[:,:,0] + im_refr[:,:,0]
imBbw = im_test[:,:,0] + im_test[:,:,0] + im_test[:,:,0]

# dalculate difference
diff = imAbw - imBbw
diff_pts = np.where(diff != 0)[0]

# test average difference
if np.average( np.abs(diff) ) > 1e-5:
    print "Average difference " + str(np.average( np.abs(diff) )) + " > 1e-6."
    error = -1
# test number od diferrent points
if np.prod( diff_pts.shape ) > np.prod( diff.shape ) * 1e-6:
    print "Number of different pixels " + str( (1.*np.prod( diff_pts.shape )) / np.prod( diff.shape )) + " > 1e-6"
    error = -2

# plot diff image
diffP =  diff
diffM = -diff

diffP[ diffP < 0 ] = 0
diffM[ diffM < 0 ] = 0

if np.amax( diffP ) != 0:
    diffP = diffP / np.amax( diffP )
if np.amax( diffM ) != 0:
    diffM = diffM / np.amax( diffM )

im_refr[:,:,0] = diffP
im_refr[:,:,1] = diffM
im_refr[:,:,2] = 0

img.imsave( sys.argv[3], im_refr )

if error != 0:
    print "Files are different. See " + sys.argv[3] + "for details."
    sys.exit( error )
sys.exit( 0 )


