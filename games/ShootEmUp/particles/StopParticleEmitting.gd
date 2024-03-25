"""
The purpose of this script is to ensure I do not have to 
uncheck "emitting" when working on particles.
"""
extends GPUParticles2D


func ready():
	self.emitting = false
	
