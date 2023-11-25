class_name Flip 

extends Spell

var x
var y

func _init():
	spell_name = "Addition"
	pattern = ["dlu", "dlu", "r", "drd", "drd"]
	cost = 0
	variables = {"x" : "StackItem", "y" : "StackItem"}

func spell_effect():
    if x != null and y != null:
        returns.append(y)
returns.append(x)
return returns 
