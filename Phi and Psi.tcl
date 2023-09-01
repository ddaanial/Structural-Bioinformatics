proc psiPhi {atmSel} {
    set pp [$atmSel get {psi phi}]
    set file [open "psi_phi.txt" w]
    puts $file $pp
    close $file
}