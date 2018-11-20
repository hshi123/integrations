import collections
import json
import os
import sys
import yaml

from sensor_msgs.msg import CameraInfo

for filename in sys.argv[1:]:
    with open(filename) as fi:
        need_width = False
        need_height = False
        stereo = False
        camera_idx = 1
        camera_info_1 = CameraInfo()
        camera_info_1.distortion_model = 'plumb_bob'
        camera_info_2 = CameraInfo()
        camera_info_2.distortion_model = 'plumb_bob'
        for line in fi:
            if line.startswith('Left'):
                stereo = True
                camera_idx = 1
            elif line.startswith('Right'):
                stereo = True
                camera_idx = 2
            
            if line.startswith('(\'D = \''):
                value_str = line[line.find('[') + 1:line.find(']')]
                value = [float(s) for s in value_str.split(',')]
                if camera_idx == 1:
                    camera_info_1.D = value
                else:
                    camera_info_2.D = value
            elif line.startswith('(\'K = \''):
                value_str = line[line.find('[') + 1:line.find(']')]
                value = [float(s) for s in value_str.split(',')]
                if camera_idx == 1:
                    camera_info_1.K = value
                else:
                    camera_info_2.K = value
            elif line.startswith('(\'R = \''):
                value_str = line[line.find('[') + 1:line.find(']')]
                value = [float(s) for s in value_str.split(',')]
                if camera_idx == 1:
                    camera_info_1.R = value
                else:
                    camera_info_2.R = value
            elif line.startswith('(\'P = \''):
                value_str = line[line.find('[') + 1:line.find(']')]
                value = [float(s) for s in value_str.split(',')]
                if camera_idx == 1:
                    camera_info_1.P = value
                else:
                    camera_info_2.P = value
            elif line.startswith('width'):
                need_width = True
            elif line.startswith('height'):
                need_height = True
            elif need_width:
                camera_info_1.width = int(line)
                camera_info_2.width = int(line)
                need_width = False
            elif need_height:
                camera_info_1.height = int(line)
                camera_info_2.height = int(line)
                need_height = False
        
        output_path = filename[:filename.rfind('/')] + '/output/'
        output_file = filename[filename.rfind('/') + 1:]
        if not os.path.exists(output_path):
            os.makedirs(output_path)

        if stereo:
            with open(output_path + output_file + '_left_intrinsics.yaml', 'w') as of:
                of.write(str(camera_info_1))
            with open(output_path + output_file + '_right_intrinsics.yaml', 'w') as of:
                of.write(str(camera_info_2))
        else:
            with open(output_path + output_file + '_intrinsics.yaml', 'w') as of:
                of.write(str(camera_info_1))
    print ('convert ' + filename + ' finished.')
