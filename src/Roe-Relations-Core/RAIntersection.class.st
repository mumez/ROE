Class {
	#name : #RAIntersection,
	#superclass : #RABinaryTransformation,
	#category : #'Roe-Relations-Core'
}

{ #category : #visiting }
RAIntersection >> acceptRoeVisitor: aVisitor [
	^aVisitor visitIntersection: self
]

{ #category : #accessing }
RAIntersection >> attributes [
	^left attributes
]
