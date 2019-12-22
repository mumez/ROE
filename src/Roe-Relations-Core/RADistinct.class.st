Class {
	#name : #RADistinct,
	#superclass : #RATransformation,
	#category : #'Roe-Relations-Core'
}

{ #category : #'as yet unclassified' }
RADistinct class >> source: aRelation [
	^ self basicNew setSource: aRelation
]

{ #category : #visiting }
RADistinct >> acceptRoeVisitor: aVisitor [
	^aVisitor visitDistinct: self
]

{ #category : #testing }
RADistinct >> isMutable [
	^false
]

{ #category : #visiting }
RADistinct >> setSource: aRelation [
	source := aRelation
]
