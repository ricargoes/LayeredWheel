extends Node

var GRAVITY: float = 4000

enum Element {Air, Water, Oil, Gravel, Fire, Electricity, Mud}

func passive_elements() -> Array[GameLibrary.Element]:
	return [GameLibrary.Element.Air, GameLibrary.Element.Water, GameLibrary.Element.Oil, GameLibrary.Element.Gravel]

func active_elements() -> Array[GameLibrary.Element]:
	return [GameLibrary.Element.Fire, GameLibrary.Element.Electricity, GameLibrary.Element.Mud]
