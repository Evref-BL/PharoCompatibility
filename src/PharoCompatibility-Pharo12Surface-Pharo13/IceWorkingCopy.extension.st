Extension { #name : 'IceWorkingCopy' }

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
IceWorkingCopy >> commitChanges: aDiff withMessage: message force: forcing [

	| newCommit |
	self validateCanCommit.
	self repository index
		updateDiskWorkingCopy: aDiff;
		updateIndex: aDiff.
	(forcing not and: [ repository index isEmpty ]) ifTrue: [
		IceNothingToCommit signal ].
	newCommit := self repository
		             commitIndexWithMessage: message
		             andParents:
			             (self workingCopyState referenceCommits reject: [
				              :each | each isNoCommit ]).
	referenceCommit := newCommit.
	^ newCommit
]
