Class {
	#name : #RATuple,
	#superclass : #Object,
	#instVars : [
		'relation'
	],
	#category : #'Roe-Tuples'
}

{ #category : #'as yet unclassified' }
RATuple class >> relation: aRelation [
	^ self basicNew initializeWithRelation: aRelation
]

{ #category : #'as yet unclassified' }
RATuple >> at: anObject [
	^ self valueForAttribute: (anObject resolveAttributeIn: relation attributes)
]

{ #category : #'as yet unclassified' }
RATuple >> doesNotUnderstand: aMessage [
	| selector |
	selector := aMessage selector.
	(selector numArgs = 0
		and: [self hasAttributeNamed: selector asString])
			ifTrue: [^ self valueForAttributeNamed: selector].
		
	((selector numArgs = 1
		and: [self hasAttributeNamed: selector allButLast])
		and: [self isMutable])
			ifTrue: [^ self
						takeValue: aMessage argument
						forAttributeNamed: selector allButLast].
					
	^ super doesNotUnderstand: aMessage
]

{ #category : #testing }
RATuple >> hasAttributeNamed: aString [
	| s |
	s := aString asString.
	^relation attributes anySatisfy: [:ea | ea name sameAs: s]
]

{ #category : #'as yet unclassified' }
RATuple >> initializeWithRelation: aRelation [
	relation := aRelation
]

{ #category : #'as yet unclassified' }
RATuple >> isMutable [
	^ false
]

{ #category : #'as yet unclassified' }
RATuple >> name [
	^ self valueForAttributeNamed: #name ifAbsent: [super name]
]

{ #category : #'as yet unclassified' }
RATuple >> takeValue: anObject forAttribute: anAttribute [
	self isMutable
		ifTrue: [self subclassResponsibility]
		ifFalse: [self shouldNotImplement]
]

{ #category : #'as yet unclassified' }
RATuple >> takeValue: anObject forAttributeNamed: aString [
	self takeValue: anObject forAttribute: (relation attributeNamed: aString)
]

{ #category : #'as yet unclassified' }
RATuple >> valueForAttribute: anAttribute [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
RATuple >> valueForAttributeNamed: aString [
	^ self valueForAttribute: (relation attributeNamed: aString)
]

{ #category : #'as yet unclassified' }
RATuple >> valueForAttributeNamed: aString ifAbsent: errorBlock [
	^ self valueForAttribute: (relation attributeNamed: aString ifAbsent: [^ errorBlock value])
]
