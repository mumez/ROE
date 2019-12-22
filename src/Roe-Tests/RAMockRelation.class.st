Class {
	#name : #RAMockRelation,
	#superclass : #RAArrayRelation,
	#instVars : [
		'objectClass'
	],
	#category : #'Roe-Tests'
}

{ #category : #'as yet unclassified' }
RAMockRelation >> objectClass [
	^ objectClass
]

{ #category : #'as yet unclassified' }
RAMockRelation >> objectClass: aClass [
	objectClass := aClass
]

{ #category : #'as yet unclassified' }
RAMockRelation >> objectForValues: aDictionary [
	| values |
	values := IdentityDictionary new.
	aDictionary associationsDo: [:each | values at: each key name asSymbol put: each value].
	^self objectClass fromValues: values
]

{ #category : #'as yet unclassified' }
RAMockRelation >> printOn: aStream [
	self attributes do: [:ea | aStream nextPutAll: ea name]
]
