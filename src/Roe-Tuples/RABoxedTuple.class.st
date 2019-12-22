Class {
	#name : #RABoxedTuple,
	#superclass : #RASimpleTuple,
	#category : #'Roe-Tuples'
}

{ #category : #testing }
RABoxedTuple >> isMutable [
	^relation isMutable
]

{ #category : #'as yet unclassified' }
RABoxedTuple >> takeValue: anObject forAttribute: anAttribute [
	(values at: (relation attributes indexOf: anAttribute)) at: 1 put: anObject
]

{ #category : #'as yet unclassified' }
RABoxedTuple >> valueForAttribute: anAttribute [
	^ (super valueForAttribute: anAttribute) first
]
