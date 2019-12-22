Class {
	#name : #RAAliasedAttribute,
	#superclass : #RAAttribute,
	#instVars : [
		'source',
		'name'
	],
	#category : #'Roe-Attributes'
}

{ #category : #'instance creation' }
RAAliasedAttribute class >> attribute: anAttribute name: aString [
	^ self new setAttribute: anAttribute name: aString
]

{ #category : #accessing }
RAAliasedAttribute >> name [
	^name
]

{ #category : #accessing }
RAAliasedAttribute >> originalAttribute [
	^ source originalAttribute
]

{ #category : #accessing }
RAAliasedAttribute >> originalRelation [
	^ source originalRelation
]

{ #category : #resolving }
RAAliasedAttribute >> resolveAttributeIn: aCollection [
	| attribute |
	aCollection do: [:ea | 
		self = ea ifTrue: 
			[attribute ifNil: [attribute := self]
				ifNotNil: [RAAttribute ambiguousAttributeError: self name]]].
	attribute ifNotNil: [^attribute].
	RAAttribute errorCouldNotResolveAttribute
]

{ #category : #private }
RAAliasedAttribute >> setAttribute: anAttribute name: aString [
	source := anAttribute.
	name := aString asString
]

{ #category : #accessing }
RAAliasedAttribute >> source [
	^ source
]
