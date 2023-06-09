from flask import Flask, jsonify, request
import numpy as np
import cv2
import subprocess

# Create the Flask app
app = Flask(__name__)

@app.route('/api/pose', methods=['POST'])
def process_pose():
    # Access the uploaded video file
    video_file = request.files['video']
    video_path = 'uploaded_video.mp4'
    video_file.save(video_path)

    # Process the video using the provided code
    # ...
    # Place the entire code here or import it from another file

    # Return the results
    result = {
        'count': count,
        'position': position,
        'angle': angle,
        'startAngle': startAngle,
        'endAngle': endAngle
        # Add more relevant data to the result dictionary as needed
    }
    return jsonify(result)


# Run the Flask app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
