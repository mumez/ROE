Class {
	#name : #RASelection,
	#superclass : #RATransformation,
	#instVars : [
		'condition'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'as yet unclassified' }
RASelection class >> from: aRelation where: aBlock [
	^ self new setRelation: aRelation condition: aBlock
]

{ #category : #visiting }
RASelection >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitSelection: self
]

{ #category : #evaluating }
RASelection >> evaluateTuple: anArray [
	^ condition value: anArray
]

{ #category : #initializing }
RASelection >> setRelation: aRelation condition: aBlock [
	source := aRelation.
	condition := aBlock.
]
