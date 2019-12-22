Class {
	#name : #RAClone,
	#superclass : #RATransformation,
	#instVars : [
		'attributes'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'as yet unclassified' }
RAClone class >> of: aRelation [
	^ self basicNew setRelation: aRelation
]

{ #category : #'as yet unclassified' }
RAClone >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitClone: self
]

{ #category : #'as yet unclassified' }
RAClone >> attributes [
	^ attributes
]

{ #category : #'as yet unclassified' }
RAClone >> setRelation: aRelation [
	source := aRelation.
	attributes := source attributes collect: [:ea | RAClonedAttribute attribute: ea]
]
