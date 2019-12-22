Class {
	#name : #RAOrdering,
	#superclass : #RATransformation,
	#instVars : [
		'order',
		'ascending'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'instance creation' }
RAOrdering class >> of: aRelation order: attributeRefs ascending: booleanArray [
	^ self basicNew setSource: aRelation orderAttributes: attributeRefs ascending: booleanArray
]

{ #category : #visiting }
RAOrdering >> acceptRoeVisitor: aVisitor [
	^aVisitor visitOrder: self
]

{ #category : #accessing }
RAOrdering >> ascending [
	^ascending
]

{ #category : #accessing }
RAOrdering >> order [
	^order
]

{ #category : #initialization }
RAOrdering >> setSource: aRelation orderAttributes: attributeRefs ascending: booleanArray [
	source := aRelation.
	order := attributeRefs collect: [ :ea | ea resolveAttributeIn: source attributes ].
	ascending := booleanArray.
]
