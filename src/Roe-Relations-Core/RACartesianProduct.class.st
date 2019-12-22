Class {
	#name : #RACartesianProduct,
	#superclass : #RABinaryTransformation,
	#category : #'Roe-Relations-Core'
}

{ #category : #visiting }
RACartesianProduct >> acceptRoeVisitor: aVisitor [
	^  aVisitor visitCartesianProduct: self
]

{ #category : #accessing }
RACartesianProduct >> attributes [
	^ left attributes, right attributes
]

{ #category : #testing }
RACartesianProduct >> isMutable [
	^false
]
