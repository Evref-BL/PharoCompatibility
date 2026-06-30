Extension { #name : 'PharoCompatibility' }

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> gitCommandWithArguments: argumentStrings in: repositoryLocation [

	^ String streamContents: [ :stream |
		  stream
			  nextPutAll: 'git -C ';
			  nextPutAll: (self posixShellQuote: repositoryLocation fullName).
		  argumentStrings do: [ :each |
			  stream
				  space;
				  nextPutAll: (self posixShellQuote: each asString) ] ]
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> gitOutputWithArguments: argumentStrings in: repositoryLocation [

	^ (LibC resultOfCommand:
		   (self
			    gitCommandWithArguments: argumentStrings
			    in: repositoryLocation)) trimBoth
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> icebergCommandLineCommitModifiedFilePaths: modifiedFilePaths repository: repository message: message parentCommits: parentCommits [

	| addArguments |
	addArguments := OrderedCollection with: 'add' with: '--'.
	modifiedFilePaths do: [ :each | addArguments add: each pathString ].
	self
		runGitCommandWithArguments: addArguments asArray
		in: repository location.
	self runGitCommitWithMessage: message in: repository location.
	^ self
		  icebergCommitForRepository: repository
		  message: message
		  parentCommits: parentCommits
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> icebergCommitAuthorNameForRepository: repository [

	^ self
		gitOutputWithArguments: #( 'log' '-1' '--format=%an' )
		in: repository location
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> icebergCommitForRepository: repository message: message parentCommits: parentCommits [

	| commitId |
	commitId := self
		gitOutputWithArguments: #( 'rev-parse' 'HEAD' )
		in: repository location.
	^ IceGitCommit new
		id: commitId;
		author: (self icebergCommitAuthorNameForRepository: repository);
		datetime: DateAndTime now;
		ancestorIds: (parentCommits collect: [ :each | each id ]);
		comment: message;
		repository: repository;
		yourself
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> posixShellQuote: aString [

	^ String streamContents: [ :stream |
		  stream nextPut: $'.
		  aString asString do: [ :each |
			  each = $'
				  ifTrue: [
					  stream
						  nextPut: $';
						  nextPut: $";
						  nextPut: $';
						  nextPut: $";
						  nextPut: $' ]
				  ifFalse: [ stream nextPut: each ] ].
		  stream nextPut: $' ]
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> runGitCommandWithArguments: argumentStrings in: repositoryLocation [

	| command status |
	command := self
		           gitCommandWithArguments: argumentStrings
		           in: repositoryLocation.
	status := LibC runCommand: command.
	status = 0 ifFalse: [
		Error signal: 'Git command failed with status ' , status asString ]
]

{ #category : '*PharoCompatibility-Pharo12Surface-Pharo13' }
PharoCompatibility class >> runGitCommitWithMessage: message in: repositoryLocation [

	| command status |
	command := self
		gitCommandWithArguments: {
			'commit'.
			'-m'.
			message withUnixLineEndings }
		in: repositoryLocation.
	status := LibC runCommand: command.
	status = 0 ifFalse: [
		Error signal: 'Git commit failed with status ' , status asString ]
]
