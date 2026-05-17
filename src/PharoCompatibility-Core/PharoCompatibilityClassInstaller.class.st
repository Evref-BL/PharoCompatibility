"
Version-aware facade for class installation operations.

It keeps newer Pharo images on their native Shift installer update path while
letting older images use an explicit builder/install sequence with the same
configuration block shape.
"
Class {
	#name : 'PharoCompatibilityClassInstaller',
	#superclass : 'Object',
	#category : 'PharoCompatibility-Core-Core',
	#package : 'PharoCompatibility-Core',
	#tag : 'Core'
}

{ #category : 'installing' }
PharoCompatibilityClassInstaller class >> createSubclassOf: aSuperclass named: aClassName package: aPackageName tag: aTagName slots: instanceSlots classSlots: classSideSlots traits: instanceTraits classTraits: classSideTraits sharedVariables: sharedVariableNames sharedPools: sharedPoolClasses layout: layoutClass [

	| builder |
	builder := self
		           newClassBuilderForSuperclass: aSuperclass
		           named: aClassName.
	builder package: aPackageName.
	aTagName ifNotNil: [ builder tag: aTagName ].
	builder slots: (instanceSlots ifNil: [ #(  ) ]).
	(classSideSlots ifNil: [ #(  ) ]) ifNotEmpty: [
		builder classSlots: classSideSlots ].
	(instanceTraits ifNil: [ #(  ) ]) ifNotEmpty: [
		builder traits: instanceTraits ].
	(classSideTraits ifNil: [ #(  ) ]) ifNotEmpty: [
		builder classTraits: classSideTraits ].
	(sharedVariableNames ifNil: [ #(  ) ]) ifNotEmpty: [
		builder sharedVariables: sharedVariableNames ].
	(sharedPoolClasses ifNil: [ #(  ) ]) ifNotEmpty: [
		builder sharedPools: sharedPoolClasses ].
	layoutClass ifNotNil: [ builder layout: layoutClass ].
	^ builder install
]

{ #category : 'private' }
PharoCompatibilityClassInstaller class >> newClassBuilderForSuperclass: aSuperclass named: aClassName [

	| builder |
	self shouldUseBuilderUpdate ifFalse: [
		^ aSuperclass << aClassName asSymbol ].
	builder := ShiftClassBuilder new.
	builder buildEnvironment: ShSmalltalkGlobalsEnvironment new.
	builder superclass: aSuperclass.
	builder name: aClassName asSymbol.
	^ builder
]

{ #category : 'installing' }
PharoCompatibilityClassInstaller class >> reparent: aClass toSuperclass: aSuperclass [

	^ self updateUsingBuilder: aClass to: [ :builder |
		  builder superclass: aSuperclass ]
]

{ #category : 'private' }
PharoCompatibilityClassInstaller class >> shouldUseBuilderUpdate [

	^ PharoCompatibility currentMajorVersion <= 11
]

{ #category : 'installing' }
PharoCompatibilityClassInstaller class >> update: aClass to: configurationBlock [

	self shouldUseBuilderUpdate ifTrue: [
		^ self updateUsingBuilder: aClass to: configurationBlock ].
	^ ShiftClassInstaller update: aClass to: configurationBlock
]

{ #category : 'private' }
PharoCompatibilityClassInstaller class >> updateUsingBuilder: aClass to: configurationBlock [

	| builder |
	builder := ShiftClassBuilder new.
	builder fillInstanceSideFromClass: aClass.
	builder fillClassSideFromEnvironment: aClass environment.
	builder name: aClass name.
	configurationBlock value: builder.
	^ builder install
]
