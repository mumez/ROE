Class {
	#name : #RAUnion,
	#superclass : #RABinaryTransformation,
	#category : #'Roe-Relations-Core'
}

{ #category : #visiting }
RAUnion >> acceptRoeVisitor: aVisitor [
	^aVisitor visitUnion: self
]

{ #category : #accessing }
RAUnion >> attributes [
	^left attributes
]
