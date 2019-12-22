Class {
	#name : #RAArrayRelation,
	#superclass : #RAConcreteRelation,
	#instVars : [
		'tuples'
	],
	#category : #'Roe-Relations-Concrete'
}

{ #category : #'as yet unclassified' }
RAArrayRelation class >> name: aString attributes: anArray [
	^ self basicNew initializeWithName: aString attributes: anArray
]

{ #category : #adding }
RAArrayRelation >> addValues: anArray [
	tuples add: (anArray collect: [:ea | Array with: ea])
]

{ #category : #private }
RAArrayRelation >> for: aRelation do: aBlock [
	(RAEvaluator evaluate: aRelation) do:
		[:array |
		aBlock value:
			(RASimpleTuple
				relation: aRelation
				values: (array collect: [:ea | ea first]))]
]

{ #category : #updating }
RAArrayRelation >> for: aRelation update: aBlock [
	(RAEvaluator evaluate: aRelation)
		do: [:ea | aBlock value: (RABoxedTuple relation: aRelation values: ea)]
]

{ #category : #initializing }
RAArrayRelation >> initializeWithName: aString [
	self initializeWithName: aString attributes: #()
]

{ #category : #initializing }
RAArrayRelation >> initializeWithName: aString attributes: anArray [
	super initializeWithName: aString.
	attributes := anArray collect: [:ea | RASimpleAttribute named: ea relation: self].
	tuples := OrderedCollection new 
]

{ #category : #accessing }
RAArrayRelation >> tuples [
	^tuples
]

{ #category : #updating }
RAArrayRelation >> update: aBlock [
	tuples do: [:ea | aBlock value: (RABoxedTuple relation: self values: ea)]
]
