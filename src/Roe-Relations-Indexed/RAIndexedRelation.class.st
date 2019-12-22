Class {
	#name : #RAIndexedRelation,
	#superclass : #RARelation,
	#category : #'Roe-Relations-Indexed'
}

{ #category : #'as yet unclassified' }
RAIndexedRelation >> at: anObject [
	| relation |
	relation := self where: self keyName equals: anObject.
	self keyIsUnique
		ifFalse: [^ relation]
		ifTrue: [relation do: [:tuple | ^ tuple]].
	self error: 'No value for key ', anObject printString.
]

{ #category : #'as yet unclassified' }
RAIndexedRelation >> keyAttribute [
	^ self attributeNamed: self keyName
]

{ #category : #'as yet unclassified' }
RAIndexedRelation >> keyIsUnique [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RAIndexedRelation >> keyName [
	self subclassResponsibility
]
