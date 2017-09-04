
puts "quartus_hook.tcl begins"

package require ::quartus::project

set module [lindex $quartus(args) 0]
set top    [lindex $quartus(args) 1]
set rev    [lindex $quartus(args) 3]

set script_dir [file dirname [info script]]

set need_to_close_project 0
set make_assignments 1

if {[is_project_open]} {
    if {[string compare $quartus(project) "$top"]} {
        post_message "Wrong project open: $quartus(project) expected: $top"
        set make_assignments 0
    } else {
        post_message "Project $top was already open"
    }
} else {
    # Only open if not already open
    if {[project_exists $top]} {
        project_open $top
        post_message "Project $top opened"
        set need_to_close_project 1
    } else {
        post_message "Project $top doesnt exist"
    }
}

if {$make_assignments} {
    switch $module quartus_map {
        post_message "Running LPDDR2 pin assignments script"
        source lpddr2ctrl1/lpddr2ctrl1_p0_pin_assignments.tcl
        post_message "Running DDR3 pin assignments script"
        source ddr3ctrl1/ddr3ctrl1_p0_pin_assignments.tcl
    } default {
        post_message "quartus hook does nothing after $module"
    }
}



if {$need_to_close_project} {
    project_close
}



puts "quartus_hook.tcl ends"
