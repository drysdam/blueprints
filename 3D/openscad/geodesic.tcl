#!/usr/bin/env tclsh8.5

proc subdivide_triangle { points } {
	lassign [lindex $points 0] x1 y1 z1
	lassign [lindex $points 1] x2 y2 z2
	lassign [lindex $points 2] x3 y3 z3
	set midx12 [expr ($x1+$x2)/2.0]
	set midx23 [expr ($x2+$x3)/2.0]
	set midx31 [expr ($x3+$x1)/2.0]
	set midy12 [expr ($y1+$y2)/2.0]
	set midy23 [expr ($y2+$y3)/2.0]
	set midy31 [expr ($y3+$y1)/2.0]
	set midz12 [expr ($z1+$z2)/2.0]
	set midz23 [expr ($z2+$z3)/2.0]
	set midz31 [expr ($z3+$z1)/2.0]
	set tri1 [list\
				  [list $x1 $y1 $z1]\
				  [list $midx12 $midy12 $midz12]\
				  [list $midx31 $midy31 $midz31]]
	set tri2 [list\
				  [list $midx12 $midy12 $midz12]\
				  [list $x2 $y2 $z2]\
				  [list $midx23 $midy23 $midz23]]
	set tri3 [list\
				  [list $midx31 $midy31 $midz31]\
				  [list $midx23 $midy23 $midz23]\
				  [list $x3 $y3 $z3]]
	set tri4 [list\
				  [list $midx23 $midy23 $midz23]\
				  [list $midx31 $midy31 $midz31]\
				  [list $midx12 $midy12 $midz12]]
	return [list $tri1 $tri2 $tri3 $tri4]
}

proc subdivide { points faces } {
	set points2 $points
	set faces2 {}
	foreach face $faces {
		set facepoints {}
		foreach fp $face {
			lappend facepoints [lindex $points $fp]
		}
		set newpointgroups [subdivide_triangle $facepoints]
		set nextpointnum [llength $points2]
		foreach newpointgroup $newpointgroups {
			set points2 [concat $points2 $newpointgroup]
			lappend faces2 [list $nextpointnum\
								[expr $nextpointnum + 1]\
								[expr $nextpointnum + 2]]
			incr nextpointnum 3
		}
	}
	return [list $points2 $faces2]
}

proc list2vector { l } {
	set vect \[
	set comma1 ""
	foreach litem $l {
		append vect ${comma1}\[
		set comma2 ""
		foreach sublitem $litem {
			append vect "$comma2$sublitem"
			set comma2 ,
		}
		append vect \]
		set comma1 ,
	}
	append vect \]
	return $vect
}

proc printit { points faces } {
	puts "include <coordinates.scad>;"
	puts "polyhedron2([list2vector $points], [list2vector $faces], 3);"
}

proc print_unique_lines { points faces } {
	global fn
	array unset linesdone()

	puts "include <coordinates.scad>;"
	puts "\$fn=$fn;"
	foreach face $faces {
		for {set i 0} {$i < [llength $face]} {incr i} {
			set pnum [lindex $face $i]
			set nextpnum [lindex $face [expr $i + 1]]
			if {$i + 1 >= [llength $face]} {
				set nextpnum [lindex $face 0]
			}
			set first [lindex $points $pnum] 
			set second [lindex $points $nextpnum] 
			if {![info exists linesdone($first,$second)]} {
				puts "line_xyz(\[[join $first ,]\], \[[join $second ,]\], 2);"
				set linesdone($first,$second) 1
				set linesdone($second,$first) 1
			}
		}
	}
}

proc push_to_radius { points radius } {
	set newpoints {}
	foreach point $points {
		lassign $point x y z
		set len [expr sqrt($x*$x+$y*$y+$z*$z)]
		set factor [expr $radius/($len*1.0)]
		lappend newpoints [list [expr $x*$factor] [expr $y*$factor] [expr $z*$factor]]
	}
	return $newpoints
}

global fn
set fn [lindex $argv 0]
set levels [lindex $argv 1]

set points {{0 0 100} {100 0 0} {0 100 0} {-100 0 0} {0 -100 0} {0 0 -100}}
set faces {{0 1 2} {0 2 3} {0 3 4} {0 4 1}\
		   {5 2 1} {5 3 2} {5 4 3} {5 1 4}}
for {set l 0} {$l < $levels} {incr l} {
	lassign [subdivide $points $faces] points faces
	set points [push_to_radius $points 50]
}
set newpoints {}
foreach point $points {
	lassign $point x y z
	if {$z > 0} {
		set newz [expr $z * 1.5]
	} else {
		set newz $z
	}
	lappend newpoints [list $x $y $newz]
}
set points $newpoints
print_unique_lines $points $faces
