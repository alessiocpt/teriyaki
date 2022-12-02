(define (domain joint_bar)
(:requirements :strips :equality :typing :adl :conditional-effects)

(:types link joint angle gripper)

(:predicates
	(connected ?j - joint ?l - link) ;; considero solo il fatto che un link sia connesso ad un joint, ignoro la direzione.
	(angle-before ?a - angle ?a1 - angle)
	(angle_joint ?a - angle ?j - joint)
	(link-before ?l - link ?l1 - link)
	(fixed ?j - joint)
	(grasp ?g - gripper ?l - link)
	(in-hand ?l - link)
	(in-centre ?j - joint)
	(free ?g - gripper)
	(affected ?j -joint ?l - link ?j1 - joint) ;; nel momento in cui uso un link come child, per ruotare il joint ?j1, tutti i joint successivi cambiano angolo.
)

;;;;;BASIC OPERATORS

;;grasp 2 links to make movement
(:action take-links-to-move
:parameters (?link1 ?link2 - link ?joint - joint ?g2 ?g1 - gripper)
:precondition (and 
	(in-centre ?joint) 
	(free ?g2) 
	(free ?g1)
	(not (in-hand ?link1))
	(not (in-hand ?link2))
	(not (= ?g1 ?g2))
	(connected ?joint ?link1)
	(connected ?joint  ?link2)
	(not (= ?link1 ?link2))
)
:effect (and 
	(not (free ?g2)) 
	(not (free ?g1))
	(in-hand ?link1)
	(in-hand ?link2)
	(grasp ?g2 ?link2)
	(grasp ?g1 ?link1))
)

(:action increase_angle_first_child
:parameters (?link1 ?link2 - link ?joint - joint ?a1 ?a2 - angle ?g2 ?g1 - gripper)
:precondition (and
	(link-before ?link2 ?link1)
	(in-centre ?joint)
	(grasp ?g2 ?link2) 	
	(in-hand ?link1)
	(in-hand ?link2)
	(grasp ?g1 ?link1)
	(connected ?joint ?link1)
	(connected ?joint  ?link2)
	(not (= ?link1 ?link2))
	(angle_joint ?a1 ?joint)
	(angle-before ?a1 ?a2)
	)
:effect 
    (and 
	    (not (angle_joint ?a1 ?joint)) 
	    (angle_joint ?a2 ?joint)
	    (forall (?js - joint ?a3 ?a4 - angle )
		    (when (and (affected ?js ?link1 ?joint) (not (= ?js ?joint)) (angle_joint ?a3 ?js) (angle-before ?a3 ?a4) )
		        (and
			        (not (angle_joint ?a3 ?js))
			        (angle_joint ?a4 ?js)
		        )
		    )
	    )
    )
)

(:action decrease_angle_first_child
:parameters (?link1 ?link2 - link ?joint - joint ?a1 ?a2 - angle ?g2 ?g1 - gripper)
:precondition (and
	(link-before ?link2 ?link1)
	(in-centre ?joint) 
	(grasp ?g2 ?link2) 	
	(in-hand ?link1)
	(in-hand ?link2)
	(grasp ?g1 ?link1)
	(connected ?joint ?link1)
	(connected ?joint  ?link2)
	(not (= ?link1 ?link2))
	(angle_joint ?a1 ?joint)
	(angle-before ?a2 ?a1)
	)
:effect 
    (and 
	    (not (angle_joint ?a1 ?joint)) 
	    (angle_joint ?a2 ?joint)
	    (forall (?js - joint ?a3 ?a4 - angle )
		    (when (and (affected ?js ?link1 ?joint) (not (= ?js ?joint)) (angle_joint ?a3 ?js) (angle-before ?a4 ?a3) )
		        (and
			        (not (angle_joint ?a3 ?js))
			        (angle_joint ?a4 ?js)
		        )
		    )
	    )
    )
)

;;release 2 links to make movement
(:action release-links
:parameters (?link1 ?link2 - link ?joint - joint ?g2 ?g1 - gripper)
:precondition (and 
	(grasp ?g2 ?link2) 	
	(in-hand ?link1)
	(in-hand ?link2)
	(grasp ?g1 ?link1)
	(connected ?joint ?link1)
	(connected ?joint  ?link2)
	(not (= ?link1 ?link2))
)
:effect (and 
	(free ?g2)
	(free ?g1)
	(not (in-hand ?link1))
	(not (in-hand ?link2))
	(not (grasp ?g2 ?link2))
	(not (grasp ?g1 ?link1)))
)


;;;;;;MACROS


(:action link-to-central-grasp
:parameters (?link1 ?link2 - link ?joint1 ?joint2 - joint ?g2 ?g1 - gripper)
:precondition (and 
	(in-centre ?joint1) 
	(connected ?joint2 ?link1) 
	(connected ?joint2 ?link2) 
	(not (= ?link1 ?link2)) 
	(free ?g2) 
	(free ?g1) 
	(not (= ?g1 ?g2))
	(not (in-hand ?link1))
	(not (in-hand ?link2))
	)
:effect (and 
	(not (in-centre ?joint1)) 
	(not (free ?g2)) 
	(not (free ?g1))  
	(in-centre ?joint2) 
	(grasp ?g2 ?link2)
	(grasp ?g1 ?link1) 
	(in-hand ?link1)
	(in-hand ?link2))
)

(:action increase_angle_first_child_45
:parameters (?link1 ?link2 - link ?joint - joint ?a1 ?a2 ?a3 ?a4 - angle ?g2 ?g1 - gripper)
:precondition (and
	(link-before ?link2 ?link1)
	(in-centre ?joint)
	(grasp ?g2 ?link2) 	
	(in-hand ?link1)
	(in-hand ?link2)
	(grasp ?g1 ?link1)
	(connected ?joint ?link1)
	(connected ?joint  ?link2)
	(not (= ?link1 ?link2))
	(angle_joint ?a1 ?joint)
	(angle-before ?a1 ?a2)
	(angle-before ?a2 ?a3)
	(angle-before ?a3 ?a4)
	)
:effect 
    (and 
	    (not (angle_joint ?a1 ?joint)) 
	    (angle_joint ?a4 ?joint)
	    (forall (?js - joint ?a5 ?a6 ?a7 ?a8 - angle )
		    (when (and (affected ?js ?link1 ?joint) (not (= ?js ?joint)) (angle_joint ?a5 ?js) (angle-before ?a5 ?a6) (angle-before ?a6 ?a7) (angle-before ?a7 ?a8))
		        (and
			        (not (angle_joint ?a5 ?js))
			        (angle_joint ?a8 ?js)
		        )
		    )
	    )
    )
)

(:action decrease_angle_first_child_45
:parameters (?link1 ?link2 - link ?joint - joint ?a1 ?a2 ?a3 ?a4 - angle ?g2 ?g1 - gripper)
:precondition (and
	(link-before ?link2 ?link1)
	(in-centre ?joint) 
	(grasp ?g2 ?link2) 	
	(in-hand ?link1)
	(in-hand ?link2)
	(grasp ?g1 ?link1)
	(connected ?joint ?link1)
	(connected ?joint  ?link2)
	(not (= ?link1 ?link2))
	(angle_joint ?a1 ?joint)
	(angle-before ?a2 ?a1)
	(angle-before ?a3 ?a2)
	(angle-before ?a4 ?a3)
	)
:effect 
    (and 
	    (not (angle_joint ?a1 ?joint)) 
	    (angle_joint ?a4 ?joint)
 		(forall (?js - joint ?a5 ?a6 ?a7 ?a8 - angle )
		    (when (and (affected ?js ?link1 ?joint) (not (= ?js ?joint)) (angle_joint ?a5 ?js) (angle-before ?a8 ?a7) (angle-before ?a7 ?a6) (angle-before ?a6 ?a5))
		        (and
			        (not (angle_joint ?a5 ?js))
			        (angle_joint ?a8 ?js)
		        )
		    )
	    )
	)
)

)
