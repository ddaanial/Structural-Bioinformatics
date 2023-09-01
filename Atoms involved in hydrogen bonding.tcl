proc Bonds {pdbFile} {
    set molid [mol load pdb $pdbFile]
    set bonds [measure hbonds 20 3.4 [atomselect $molid all]]
    set firstset [lindex $bonds 0]
    set secondset [lindex $bonds 1]
    set doner [atomselect $molid "index $firstset"]
    set acceptor [atomselect $molid "index $secondset"]
    set resids1 [$doner get resid]
    puts "omega on doner residues:"
    for {set index 0} { $index < 10 } { incr index } {
        set current_res [lindex $resids1 $index]
        set before_res [expr $current_res - 1]
        set cur_sel [atomselect $molid "resid $current_res"]
        set before_sel [atomselect $molid "resid $before_res"]
        set cur_sell [$cur_sel get {index}]
        set before_sell [$before_sel get {index}]
        set ca_cur [lindex $cur_sell "1"]
        set ca_before [lindex $before_sell "1"]
        set n_cur [lindex $cur_sell "0"]
        set c_cur [lindex $cur_sell "2"]
        set omega [measure dihed "$ca_before $c_cur $n_cur $ca_cur"]
        puts "omega for resid $current_res: $omega"
        set gyr [measure rgyr [atomselect $molid "resid $current_res"]]
        puts "Radius of gyration for resid $current_res: $gyr"
        
    }
    puts "omega on acceptor residues:"
    set resids2 [$acceptor get resid]
    for {set index 0} { $index < 12 } { incr index } {
        set current_res [lindex $resids2 $index]
        set before_res [expr $current_res - 1]
        set cur_sel [atomselect $molid "resid $current_res"]
        set before_sel [atomselect $molid "resid $before_res"]
        set cur_sell [$cur_sel get {index}]
        set before_sell [$before_sel get {index}]
        set ca_cur [lindex $cur_sell "1"]
        set ca_before [lindex $before_sell "1"]
        set n_cur [lindex $cur_sell "0"]
        set c_cur [lindex $cur_sell "2"]
        puts "omega for resid $current_res: $omega"
        set gyr [measure rgyr [atomselect $molid "resid $current_res"]]
        puts "Radius of gyration for resid $current_res: $gyr"
    
    }
    set resnames1 [$doner get resname]
    set resnames2 [$acceptor get resname]
    puts "doner resids: $resids1"
    puts "acceptor resids: $resids2"
    puts "doner resnames: $resnames1"
    puts "acceptor resnames: $resnames2"
    set sel1 [atomselect $molid "protein and name CA and resid $resids1"]
    set sel2 [atomselect $molid "protein and name CA and resid $resids2"]
    set donerstructure [$sel1 get structure]
    set acceptorstructure [$sel2 get structure]
    puts "doner second structure: $donerstructure"
    puts "acceptor second structure: $acceptorstructure"
    #set donerphipsi [atomselect $molid]
    set pp1 [$sel1 get {psi phi}]
    set pp2 [$sel2 get {psi phi}]
    puts "doner psi phi: $pp1"
    puts "acceptor psi phi: $pp2"
    set gyr [measure rgyr [atomselect $molid all]]
    puts "Radius of gyration for the whole protein: $gyr"
    
}
