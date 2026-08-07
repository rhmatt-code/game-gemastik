extends Node

signal event_triggered(event_name)

var events = {}

func trigger(event_name: String):
	events[event_name] = true
	event_triggered.emit(event_name)

func has_event(event_name: String) -> bool:
	return events.get(event_name, false)
