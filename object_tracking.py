import cv2

# Defined KCF tracker 
# selected this because KCF is a novel tracking framework 
# that utilizes properties of circulant matrix to enhance 
# the processing speed
tracker = cv2.TrackerKCF_create()

# Webcam object var
cap = cv2.VideoCapture(0)

# Get initial frame
ret, frame = cap.read()
if not ret:
    print("Unable to capture video")

# Create (ROI) of the object to track box
bbox = cv2.selectROI(frame, False)

# Initialize tracker with ROI
tracker.init(frame, bbox)

# determines frame dimensions
height, width, _ = frame.shape
midpoint = width // 2

while True:
    # allows live feed
    ret, frame = cap.read()
    if not ret:
        break

    # updates frames to show live-feed
    success, bbox = tracker.update(frame)

    # Determine the midpoint of the object and calculate the difference
    x, y, w, h = [int(i) for i in bbox]
    object_midpoint = x + w // 2
    difference = object_midpoint - midpoint

    # Print whether the object moves left or right
    if abs(difference) > 30:
        direction = "left" if difference < 0 else "right"
        print(f"{direction}")
    cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
    cv2.circle(frame, (object_midpoint, y + h // 2), 5, (0, 0, 255), -1)

    # display the frame
    cv2.imshow("Tracking", frame)

    # Exit if q is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release resources
cap.release()
cv2.destroyAllWindows()
