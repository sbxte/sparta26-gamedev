extends Node

signal session_ready
signal furina
signal player_hit(health: int)
signal boost_started
signal boost_ended
signal end_sesh
signal easy
signal normal
signal hard
signal final
signal run_completed
signal run_invalid
signal trigger_ending_2 #akumulasi tdk sampai 65km
signal trigger_ending_3 #bro failed the final test lol
signal unlock_final_test
signal force_final_test

#idk where to put these, gemini said put these on global
var total_km: float = 0.0
var current_session: int = 1
const max_sessions: int = 20
const target_total: float = 65.0

# Snapshot of the run that just ended, read by the results screen after the
# scene change (the Session node is gone by then, so its numbers must live here).
var last_run_km: float = 0.0
var last_run_pace: float = 0.0   # average km/h for that run

# Persists the level-select choice across the scene change into the session.
# The signals still fire for immediate UI/SFX reactions; this holds the value
# the Session reads when it loads. segment.gd maps difficulty -> spawn chance.
var selected_difficulty := Constants.SessionDifficulty.NORMAL
