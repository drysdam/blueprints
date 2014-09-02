#!/usr/bin/env tclsh8.5

proc subdivide_triangle { points } {
	lassign [lindex $points 0] x1 y1
	lassign [lindex $points 1] x2 y2
	lassign [lindex $points 2] x3 y3
	set midx12 [expr ($x1+$x2)/2.0]
	set midx23 [expr ($x2+$x3)/2.0]
	set midx31 [expr ($x3+$x1)/2.0]
	set midy12 [expr ($y1+$y2)/2.0]
	set midy23 [expr ($y2+$y3)/2.0]
	set midy31 [expr ($y3+$y1)/2.0]
	set tri1 [list [list $x1 $y1] [list $midx12 $midy12] [list $midx31 $midy31]]
	set tri2 [list [list $midx12 $midy12] [list $x2 $y2] [list $midx23 $midy23]]
	set tri3 [list [list $midx31 $midy31] [list $midx23 $midy23] [list $x3 $y3]]
	set tri4 [list [list $midx23 $midy23] [list $midx31 $midy31] [list $midx12 $midy12]]
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


set points {{0 0} {100 100} {200 0}}
set faces {{0 1 2}}
printit $points $faces
exit

puts "level 0"
puts $points
puts $faces
lassign [subdivide $points $faces] points faces
puts "level 1"
puts $points
puts $faces
lassign [subdivide $points $faces] points faces
puts "level 2"
puts $points
puts $faces
