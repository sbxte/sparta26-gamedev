extends Node

signal session_ready
signal furina
signal boost_started
signal boost_ended
signal end_sesh
signal easy
signal normal
signal hard
signal final

# Persists the level-select choice across the scene change into the session.
# The signals still fire for immediate UI/SFX reactions; this holds the value
# the Session reads when it loads. segment.gd maps difficulty -> spawn chance.
var selected_difficulty := Constants.SessionDifficulty.NORMAL
