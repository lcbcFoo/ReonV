# called from quartus or makefile:
# arg0: <modulename> 
# arg1: <top> 
# arg2: -c <rev> 
# <variant>_pin_assignments.tcl expects "<top> " to be open

set module [lindex $quartus(args) 0]
set top    [lindex $quartus(args) 1]
set rev    [lindex $quartus(args) 3]

package require ::quartus::project
set need_to_close_project 0
set make_assignments 1

if {[is_project_open]} {
    if {[string compare $quartus(project) "$top"]} {
	post_message "Project $top is not open"
	set make_assignments 0
    } else {
	post_message "Project $top is open"
    }
} else {
    # Only open if not already open
    if {[project_exists $top]} {
	project_open $top
	set need_to_close_project 1
	post_message "Project $top opened"
	set need_to_close_project 1
    } else {
	post_message "Project $top doesnt exist"
    }
}

set script_dir [file dirname [info script]]
#lset quartus(args) [list $top ]

# proc get_top_level_instances_matching { wildcard } {
#     catch { array unset names_to_return }
#     array set names_to_return [list]
#     foreach_in_collection name_id [get_names -filter * -node_type hierarchy] {
#         set short_full_name [get_name_info -info short_full_path $name_id]
#         set short_full_pieces [split $short_full_name "|"]
#         set top_level_instance [lindex $short_full_pieces 0]
#         if { [string match $wildcard $top_level_instance] } {
#             set names_to_return($top_level_instance) 1
#         }
#     }
#     return [array names names_to_return]
# }
# set instance_list [ get_top_level_instances_matching "*uni*" ]
# if {[ llength $instance_list ] == 0} {
#     set make_assignments 0
# }

if {$make_assignments} {
    
    if [string match "quartus_map" $module] {
	if { [file exists "$script_dir/uniphy/uniphy_p0_pin_assignments.tcl" ] } {
	    #source "leon3mp_ddr2.tcl"
	    post_message "Running pin assignement $script_dir/uniphy/uniphy_p0_pin_assignments.tcl"
	    source "$script_dir/uniphy/uniphy_p0_pin_assignments.tcl"
	} else {
	    post_message "Didnt find pin assignement $script_dir/uniphy/uniphy_p0_pin_assignments.tcl"
	}
    }
    if {$need_to_close_project} {
	project_close
    }
} else {
    post_message "DDR2 seems to be disabled"
}
