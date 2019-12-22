Class {
	#name : #RATransformation,
	#superclass : #RARelation,
	#instVars : [
		'source'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #visiting }
RATransformation >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitTransformation: self
]

{ #category : #accessing }
RATransformation >> attributes [
	^ source attributes
]

{ #category : #accessing }
RATransformation >> attributesGroupedByOriginalRelation [
	^ source attributesGroupedByOriginalRelation 

]

{ #category : #private }
RATransformation >> concreteRelation [
	^ source concreteRelation
]

{ #category : #testing }
RATransformation >> isMutable [
	^source isMutable
]

{ #category : #printing }
RATransformation >> printOn: aStream [
	aStream nextPutAll: self asAlgebraicString
]

{ #category : #accessing }
RATransformation >> source [
	^ source
]
