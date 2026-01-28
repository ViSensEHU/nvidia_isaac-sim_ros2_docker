import sys
if sys.prefix == '/usr':
    sys.real_prefix = sys.prefix
    sys.prefix = sys.exec_prefix = '/home/isaac_sim/projects/javier.arambarri/robot_import/ws/install/create3'
