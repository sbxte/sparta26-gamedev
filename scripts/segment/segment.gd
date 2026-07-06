@abstract
class_name Segment
extends Node2D

# Accepts the session node to adjust segment generation based on session statistics
@abstract 
func init_segment(ses: Session)

@abstract 
func destroy_segment()

@abstract
func length() -> float
