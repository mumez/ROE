Class {
	#name : #RADifference,
	#superclass : #RABinaryTransformation,
	#category : #'Roe-Relations-Core'
}

{ #category : #visiting }
RADifference >> acceptRoeVisitor: aVisitor [
	^aVisitor visitDifference: self
]

{ #category : #accessing }
RADifference >> attributes [
	^left attributes
]
