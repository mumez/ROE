Class {
	#name : #RAUpdateTuple,
	#superclass : #RATuple,
	#instVars : [
		'nodes'
	],
	#category : #'Roe-Tuples'
}

{ #category : #'as yet unclassified' }
RAUpdateTuple >> isMutable [
	^ true
]

{ #category : #'as yet unclassified' }
RAUpdateTuple >> nodes [
	^ nodes ifNil: [nodes := Dictionary new]
]

{ #category : #'as yet unclassified' }
RAUpdateTuple >> takeValue: anObject forAttribute: anAttribute [
	self nodes at: anAttribute put: anObject
]

{ #category : #'as yet unclassified' }
RAUpdateTuple >> valueForAttribute: anAttribute [
	^ RAAttributeNode new attribute: anAttribute
]
