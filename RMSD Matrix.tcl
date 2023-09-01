proc calculateRMSD {pdbFile} {
    set molid [mol load pdb $pdbFile]
    set num_frames [molinfo top get numframes]
    set file [open "rmsd.txt" a]
    for {set index 0} { $index <  $num_frames } { incr index } {
        set index2 [expr $index + 1]
        for {set index1 $index2 } { $index1 < $num_frames} { incr index1} {
            set val [measure rmsd [atomselect $molid "all and name CA" frame $index] [atomselect $molid "all and name CA" frame $index1]]
            puts $file "frame $index , frame $index1 rmsd: $val" 
        }
    }

    close $file

}
