proc calculateRMSD {pdbFile} {
    set molid [mol load pdb $pdbFile]
    # puts $molid
    set num_frames [molinfo top get numframes]
    for {set index 0} { $index < $num_frames } { incr index } {
        set m1 [atomselect $molid "all and name CA" frame $index]
        set two [$m1 get structure]
        # set var [lsort -unique $two]
        # puts $var
        set B 0
        set C 0
        set E 0
        set H 0
        set T 0
        foreach hbtc $two {
            if {$hbtc == "B"} {
                incr B
            }
            if {$hbtc == "C"} {
                incr C
            }
            if {$hbtc == "H"} {
                incr H
            }
            if {$hbtc == "E"} {
                incr E
            }
            if {$hbtc == "T"} {
                incr T
            }
        }
        
        set file [open "file.txt" a]
        puts $file "frame $index\n$two" 
        puts $file "B: [expr [expr $B * 1.0] / [expr $C + $H + $T + $B + $E]]"
        puts $file "T: [expr [expr $T * 1.0] / [expr $C + $H + $T + $B + $E]]"
        puts $file "C: [expr [expr $C * 1.0] / [expr $C + $H + $T + $B + $E]]"
        puts $file "H: [expr [expr $H * 1.0] / [expr $C + $H + $T + $B + $E]]"
        puts $file "E: [expr [expr $E * 1.0] / [expr $C + $H + $T + $B + $E]]"
        close $file
    }
}
