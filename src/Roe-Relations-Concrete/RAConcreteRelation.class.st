Class {
	#name : #RAConcreteRelation,
	#superclass : #RARelation,
	#instVars : [
		'name',
		'attributes',
		'schema'
	],
	#category : #'Roe-Relations-Concrete'
}

{ #category : #'instance creation' }
RAConcreteRelation class >> factory: aFactory name: aString [ 
	^self new 
		factory: aFactory;
		name: aString;
		yourself
]

{ #category : #adding }
RAConcreteRelation >> addAllValues: anArray [
	anArray do: [ :row | self addValues: row ]
]

{ #category : #adding }
RAConcreteRelation >> addValues: anArray [
	self subclassResponsibility
]

{ #category : #accessing }
RAConcreteRelation >> attributes [
	^attributes
]

{ #category : #accessing }
RAConcreteRelation >> attributes: anObject [
	"Set the value of attributes"

	attributes := anObject
]

{ #category : #private }
RAConcreteRelation >> concreteRelation [
	^ self
]

{ #category : #private }
RAConcreteRelation >> for: aRelation do: aBlock [
	self subclassResponsibility 
]

{ #category : #updating }
RAConcreteRelation >> for: aRelation update: aBlock [
	self subclassResponsibility
]

{ #category : #initializing }
RAConcreteRelation >> initializeWithName: aString [
	| idx |
	idx := aString indexOf: $..
	idx > 0 
		ifFalse: [ name := aString ]
		ifTrue: [ schema := aString first: (idx-1).
				name := aString last: (aString size - idx) ]

]

{ #category : #accessing }
RAConcreteRelation >> name [
	schema isNil ifFalse: [ ^schema,'.',name ].
	^name
]

{ #category : #accessing }
RAConcreteRelation >> name: anObject [
	"Set the value of name"

	name := anObject
]

{ #category : #printing }
RAConcreteRelation >> printOn: aStream [
	"Don't call super printOn: because it sends #do: which causes a superfluous query 
	(quite a few superfluous queries when viewing a relation in an inspector/debugger)
	super printOn: aStream."
	aStream 
		nextPutAll: self class name;
		nextPut: $(.
	schema isNil
		ifFalse: [ aStream nextPutAll: schema; nextPut: $. ]. 
	aStream nextPutAll: self name; nextPut: $)

]

{ #category : #accessing }
RAConcreteRelation >> schema [
	"Answer the value of schema"

	^ schema
]

{ #category : #accessing }
RAConcreteRelation >> schema: anObject [
	"Set the value of schema"

	schema := anObject
]
