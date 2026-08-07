extends Node

var spawn_point := ""

enum StoryState {
	EXPLORE,
	FOUND_WAREHOUSE,
	INVESTIGATE,
	FIND_CAT,
	WAREHOUSE_UNLOCKED,
}

var story_state = StoryState.EXPLORE

func set_story_state(state: StoryState):
	story_state = state
	
func is_state(state: StoryState):
	return story_state == state

func print_state():
	print("Current Story State: ", StoryState.keys()[story_state])
	
