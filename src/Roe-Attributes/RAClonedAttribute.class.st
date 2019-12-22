Class {
	#name : #RAClonedAttribute,
	#superclass : #RAAttribute,
	#instVars : [
		'source'
	],
	#category : #'Roe-Attributes'
}

{ #category : #'as yet unclassified' }
RAClonedAttribute class >> attribute: anAttribute [
	^ self new setAttribute: anAttribute
]

{ #category : #'as yet unclassified' }
RAClonedAttribute >> name [
	^ source name
]

{ #category : #'as yet unclassified' }
RAClonedAttribute >> originalAttribute [
	^ source originalAttribute
]

{ #category : #'as yet unclassified' }
RAClonedAttribute >> originalRelation [
	^ source originalRelation
]

{ #category : #resolving }
RAClonedAttribute >> resolveAttributeIn: aCollection [
	| attribute |
	aCollection do: [:ea | 
		self = ea ifTrue: 
			[attribute ifNil: [attribute := self]
				ifNotNil: [RAAttribute ambiguousAttributeError: self name]]].
	attribute ifNotNil: [^attribute].
	RAAttribute errorCouldNotResolveAttribute
]

{ #category : #'as yet unclassified' }
RAClonedAttribute >> setAttribute: anAttribute [
	source := anAttribute
]
