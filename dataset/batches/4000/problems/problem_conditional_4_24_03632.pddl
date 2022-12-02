(define (problem joint_bar)
(:domain joint_bar)
(:objects
    gleft gright - gripper
    link1 link2 link3 link4 - link
    joint1 joint2 joint3 - joint
    angle0 angle15 angle30 angle45 angle60 angle75 angle90 angle105 angle120 angle135 angle150 angle165 angle180 angle195 angle210 angle225 angle240 angle255 angle270 angle285 angle300 angle315 angle330 angle345 - angle)
(:init
    (link-before link1 link2)
    (link-before link2 link3)
    (link-before link3 link4)
    (affected joint1 link2 joint2)
    (affected joint2 link2 joint1)
    (affected joint3 link2 joint1)
    (affected joint2 link3 joint3)
    (affected joint1 link3 joint3)
    (affected joint3 link3 joint2)
    (angle-before angle0 angle15)
    (angle-before angle15 angle30)
    (angle-before angle30 angle45)
    (angle-before angle45 angle60)
    (angle-before angle60 angle75)
    (angle-before angle75 angle90)
    (angle-before angle90 angle105)
    (angle-before angle105 angle120)
    (angle-before angle120 angle135)
    (angle-before angle135 angle150)
    (angle-before angle150 angle165)
    (angle-before angle165 angle180)
    (angle-before angle180 angle195)
    (angle-before angle195 angle210)
    (angle-before angle210 angle225)
    (angle-before angle225 angle240)
    (angle-before angle240 angle255)
    (angle-before angle255 angle270)
    (angle-before angle270 angle285)
    (angle-before angle285 angle300)
    (angle-before angle300 angle315)
    (angle-before angle315 angle330)
    (angle-before angle330 angle345)
    (angle-before angle345 angle0)

    (connected joint1 link1)
    (connected joint1 link2)
    (connected joint2 link2)
    (connected joint2 link3)
    (connected joint3 link3)
    (connected joint3 link4)

    (angle_joint angle0 joint1)
    (angle_joint angle285 joint2)
    (angle_joint angle0 joint3)
    (in-centre joint3)
    (in-hand link2)
    (in-hand link3)
    (grasp gleft link2)
    (grasp gright link3))
(:goal
(and
    (angle_joint angle330 joint1)
    (angle_joint angle345 joint2)
    (angle_joint angle330 joint3)
    )
)
)