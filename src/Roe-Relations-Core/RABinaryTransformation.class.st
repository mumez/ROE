Class {
	#name : #RABinaryTransformation,
	#superclass : #RARelation,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'as yet unclassified' }
RABinaryTransformation class >> of: leftRelation with: rightRelation [
	^self new setLeftRelation: leftRelation rightRelation: rightRelation
]

{ #category : #accessing }
RABinaryTransformation >> attributesGroupedByOriginalRelation [
	^ left attributesGroupedByOriginalRelation, right attributesGroupedByOriginalRelation
]

{ #category : #private }
RABinaryTransformation >> concreteRelation [
	^ left concreteRelation
]

{ #category : #testing }
RABinaryTransformation >> isMutable [
	^left isMutable and: [ right isMutable ]
]

{ #category : #accessing }
RABinaryTransformation >> left [
	^left
]

{ #category : #printing }
RABinaryTransformation >> printOn: aStream [
	(RAAlgebraicPrinter on: aStream) visit: self
]

{ #category : #accessing }
RABinaryTransformation >> right [
	^right
]

{ #category : #initialization }
RABinaryTransformation >> setLeftRelation: leftRelation rightRelation: rightRelation [
	left := leftRelation.
	right := rightRelation.
]
