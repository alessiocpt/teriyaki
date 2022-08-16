"""
Converts angles from relative form to absolute one.
"""

# imports here

__author__ = "Alessio Capitanelli"
__copyright__ = "Copyright 2016, Alessio Capitanelli"
# __credits__ = []
__license__ = "GNU"
__version__ = "1.0.0"
__maintainer__ = "Alessio Capitanelli"
__email__ = "alessio.capitanelli@dibris.unige.it"
__status__ = "Development"


def convert_angles_rel2abs(angles):
    previous_angle = 0
    new_angles = []
    for angle in angles:
        angle += previous_angle
        if angle > 359:
            angle -= 360
        new_angles.append(angle)
        previous_angle = angle
    return new_angles
