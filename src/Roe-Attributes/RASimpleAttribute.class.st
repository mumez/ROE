Class {
	#name : #RASimpleAttribute,
	#superclass : #RAAttribute,
	#instVars : [
		'relation',
		'name'
	],
	#category : #'Roe-Attributes'
}

{ #category : #'instance creation' }
RASimpleAttribute class >> named: aString relation: aRelation [
	^ self new setName: aString relation: aRelation
]

{ #category : #accessing }
RASimpleAttribute >> name [
	^name
]

{ #category : #accessing }
RASimpleAttribute >> originalAttribute [
	^ self
]

{ #category : #accessing }
RASimpleAttribute >> originalRelation [
	^ relation
]

{ #category : #resolving }
RASimpleAttribute >> resolveAttributeIn: aCollection [
	| attribute |
	aCollection do: [:ea | 
		self = ea ifTrue: 
			[attribute ifNil: [attribute := self]
				ifNotNil: [RAAttribute ambiguousAttributeError: self name]]].
	attribute ifNotNil: [^attribute].
	RAAttribute errorCouldNotResolveAttribute
]

{ #category : #private }
RASimpleAttribute >> setName: aString relation: aRelation [
	name := aString asString.
	relation := aRelation
]
