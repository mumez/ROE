Class {
	#name : #RAIndexWrapper,
	#superclass : #RAIndexedRelation,
	#instVars : [
		'source',
		'key',
		'unique'
	],
	#category : #'Roe-Relations-Indexed'
}

{ #category : #'as yet unclassified' }
RAIndexWrapper class >> on: aRelation key: anAttribute [
	^ self new setRelation: aRelation key: anAttribute unique: false
]

{ #category : #'as yet unclassified' }
RAIndexWrapper class >> on: aRelation uniqueKey: anAttribute [
	^ self new setRelation: aRelation key: anAttribute unique: true
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitTransformation: self
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> attributes [
	^ source attributes
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> concreteRelation [
	^ source concreteRelation
]

{ #category : #testing }
RAIndexWrapper >> isMutable [
	^source isMutable
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> keyIsUnique [
	^ unique
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> keyName [
	^ key
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> printOn: aStream [
	source printOn: aStream
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> setRelation: aRelation key: aString unique: aBoolean [
	source := aRelation.
	key := aString.
	unique := aBoolean
]

{ #category : #'as yet unclassified' }
RAIndexWrapper >> source [
	^ source
]
