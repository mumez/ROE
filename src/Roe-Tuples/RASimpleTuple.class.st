Class {
	#name : #RASimpleTuple,
	#superclass : #RATuple,
	#instVars : [
		'values'
	],
	#category : #'Roe-Tuples'
}

{ #category : #'as yet unclassified' }
RASimpleTuple class >> relation: aRelation values: anArray [
	^ self basicNew initializeWithRelation: aRelation values: anArray
]

{ #category : #initializing }
RASimpleTuple >> initializeWithRelation: aRelation [
	self initializeWithRelation: aRelation values: (Array new: aRelation attributes size)
]

{ #category : #initializing }
RASimpleTuple >> initializeWithRelation: aRelation values: anArray [
	super initializeWithRelation: aRelation.
	values := anArray
]

{ #category : #accessing }
RASimpleTuple >> valueForAttribute: anAttribute [
	^ values at: (relation attributes indexOf: anAttribute)	
]

{ #category : #accessing }
RASimpleTuple >> values [
	^ values
]
