Class {
	#name : #RASelectTuple,
	#superclass : #RATuple,
	#category : #'Roe-Tuples'
}

{ #category : #'as yet unclassified' }
RASelectTuple >> valueForAttribute: anAttribute [
	^ RAAttributeNode new attribute: anAttribute
]
