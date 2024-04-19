
/mob/living/scp096/get_status_tab_items()
    . = ..()
    . += "Real Name: [target.real_name]"
    . += "Job: [target.job]"

/mob/living/scp096/proc/stop_scream()
	current_state = STATE_096_IDLE
	target = null
	targets = null 	//Макросы прерываются в /mob/living/scp096, убрал прерывание одного макроса
	update_icon()
