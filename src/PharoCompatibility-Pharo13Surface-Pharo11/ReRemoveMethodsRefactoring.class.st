"
P11 adapter for the Pharo 13 remove-methods refactoring factory surface.
"
Class {
	#name : 'ReRemoveMethodsRefactoring',
	#superclass : 'Object',
	#category : 'PharoCompatibility-Pharo13Surface-Pharo11-Refactoring',
	#package : 'PharoCompatibility-Pharo13Surface-Pharo11',
	#tag : 'Refactoring'
}

{ #category : 'instance creation' }
ReRemoveMethodsRefactoring class >> model: aModel selectors: selectorSymbols from: aBehavior [

	^ RBRemoveMethodRefactoring
		  model: aModel
		  removeMethods: selectorSymbols
		  from: aBehavior
]

{ #category : 'instance creation' }
ReRemoveMethodsRefactoring class >> selectors: selectorSymbols from: aBehavior [

	^ RBRemoveMethodRefactoring
		  removeMethods: selectorSymbols
		  from: aBehavior
]
