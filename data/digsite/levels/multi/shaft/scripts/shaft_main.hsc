(global short k_sentinel_spawn_time 15)

(script startup shaft_main
	(print "shaft start")
	; Commented out since AI don't properly sync in Halo 3 MP and team changing does not work
	;(wake sentinel_manager)
)

(script dormant sentinel_manager
	; place a few sentinels when the map starts
	(ai_place sq_sentinels_green 2)
	(ai_place sq_sentinels_yellow 2)
	(close_emitters)
	(wake sentinel_spawner)
	; begin looping - this won't work properly so I commented it out but the sentinels are meant to switch team
	;*
	(sleep_until 
		(begin
			(if (= (device_get_position switch_red) 1.0)
				(mp_ai_allegiance sentinel mp_team_red)
			)
			(if (= (device_get_position switch_blue) 1.0)
				(mp_ai_allegiance sentinel mp_team_blue)
			)
			false
		)
	)
	*;
)

(script dormant sentinel_spawner
	(sleep_until
		(begin
			(sleep_until (<= (ai_living_count gr_sentinels) 3))
			(sleep (* 30 k_sentinel_spawn_time))
			(ai_place sq_sentinels_green) ; Sentinels are aligned to green team
			(ai_place sq_sentinels_yellow) ; Senintels are aligned to yellow team
			(close_emitters)
			false
		)
	)
)

(script static void close_emitters
	(sleep 60)
	(unit_close sn_em_01)
	(unit_close sn_em_02)
	(unit_close sn_em_03)
	(unit_close sn_em_04)
)