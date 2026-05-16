"
Tests for the Pharo 13 surface restored on Pharo 11.
"
Class {
	#name : 'PharoCompatibilityP13SurfacePharo11Test',
	#superclass : 'PharoCompatibilityP13SurfaceTest',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo11-Tests-Tests',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo11-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfacePreservesP13Globals [

	self assertPharo13SurfacePreservesP13Globals
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesLegacyFileStreamBinding [

	self assertPharo13SurfaceProvidesLegacyFileStreamBinding
]

{ #category : 'tests' }
PharoCompatibilityP13SurfacePharo11Test >> testInstallPharo13SurfaceProvidesMillisecondSemaphoreTimeout [

	self assertPharo13SurfaceProvidesMillisecondSemaphoreTimeout
]
