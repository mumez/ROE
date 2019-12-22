Extension { #name : #String }

{ #category : #'*Roe-Extensions' }
String >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitString: self
]

{ #category : #'*Roe-Extensions' }
String >> asEscapedSql [
	^String streamContents: [ :stream |
		self do: [ :char |
			(#($' $\) includes: char)
				ifTrue: [ stream nextPut: char ].
			stream nextPut: char ] ]
]

{ #category : #'*Roe-Extensions' }
String >> asSqlString [
	^ self asEscapedSql printString
]

{ #category : #'*Roe-Extensions' }
String >> resolveAttributeIn: aCollection [
	| attribute string |
	string := self asString asUppercase.
	aCollection do: [:ea | 
		string = ea name asString asUppercase ifTrue: 
			[attribute ifNil: [attribute := ea]
				ifNotNil: [RAAttribute ambiguousAttributeError: self]]].
	attribute isNil ifFalse: [^attribute].
	RAAttribute errorCouldNotResolveAttribute
]
