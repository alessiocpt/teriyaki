"""
Writes to file a problem file for the simple case.

"""

import sys
import argparse
import os
import random
from random import randint
import numpy as np

__author__ = "Alessio Capitanelli"
__copyright__ = "Copyright 2016, Alessio Capitanelli"
__license__ = "GNU"
__version__ = "1.0.0"
__maintainer__ = "Alessio Capitanelli"
__email__ = "alessio.capitanelli@dibris.unige.it"
__status__ = "Development"


def generate_simple_prob(file, links, joints, angles, init, goal, oriented, id, tipo):
    file.write("(define (problem joint_bar)\n"
               "(:domain joint_bar)\n"
               "(:objects\n    gleft gright - gripper\n    ".format(id))

    for link in range(1, links + 1):
        file.write("link{0} ".format(link))
    file.write("- link\n    ")

    if oriented:
        file.write("joint_ground ")
        joints -= 1

    for joint in range(1, joints + 1):
        file.write("joint{0} ".format(joint))
    file.write("- joint\n    ")

    for angle in angles:
        file.write("angle{0} ".format(angle))
    file.write("- angle)\n")

    file.write("(:init\n")

    if tipo == 1:
        for link in range(1, links):
            file.write("    (link-before link{0} link{1})\n".format(link, link + 1))
        count = 2
        while (count < joints+1):

            count_min = count - 1
            while (count_min > 0):
                file.write("    (affected joint{0} link{1} joint{2})\n".format(count_min, count, count))
                count_min=count_min - 1

            count_mag=count
            while (count_mag < joints+1):
                file.write("    (affected joint{0} link{1} joint{2})\n".format(count_mag, count, count-1))
                count_mag=count_mag+1

            count = count + 1


    for angle in range(len(angles) - 1):
        file.write("    (angle-before angle{0} angle{1})\n".format(angles[angle], angles[angle + 1]))
    file.write("    (angle-before angle{0} angle{1})\n\n".format(angles[len(angles) - 1], angles[0]))

    if oriented:
        file.write("    (connected joint_ground link1)\n")

    for joint in range(1, joints + 1):
        file.write("    (connected joint{0} link{1})\n".format(joint, joint))
        file.write("    (connected joint{0} link{1})\n".format(joint, joint + 1))
    file.write("\n")

    if oriented:
        file.write("    (angle_joint angle{0} joint_ground)\n".format(init[0]))
    for joint in range(int(oriented), joints + int(oriented)):
        file.write("    (angle_joint angle{0} joint{1})\n".format(init[joint], joint + int(not oriented)))

    
    if oriented:
        file.write("\n    (fixed joint_ground)\n")
    file.write("    (in-centre joint{0})\n".format(random.choice(range(1, joints + 1))))
    
    if bool(random.getrandbits(1)):
        file.write("    (free gleft)\n    (free gright))\n")
    else:
        holding_link = random.choice(range(1, joints + 1))
        file.write("    (in-hand link{0})\n    (in-hand link{1})\n".format(holding_link, holding_link + 1))
        file.write("    (grasp gleft link{0})\n    (grasp gright link{1}))\n".format(holding_link, holding_link + 1))

    file.write("(:goal\n")
    file.write("(and\n")

    if oriented:
        file.write("    (angle_joint angle{0} joint_ground)\n".format(init[0]))
    for joint in range(int(oriented), joints + int(oriented)):
        file.write("    (angle_joint angle{0} joint{1})\n".format(goal[joint], joint + int(not oriented)))
    file.write("    )\n")

    file.write(")\n")
    file.write(")")




