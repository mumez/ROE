Class {
	#name : #RAAttribute,
	#superclass : #Object,
	#category : #'Roe-Attributes'
}

{ #category : #errors }
RAAttribute class >> ambiguousAttributeError: aString [
	self error: 'More than one attribute named ', aString printString
]

{ #category : #errors }
RAAttribute class >> errorCouldNotResolveAttribute [
	self error: 'could not resolve attribute'
]

{ #category : #accessing }
RAAttribute >> name [
	self subclassResponsibility
]

{ #category : #accessing }
RAAttribute >> originalAttribute [
	self subclassResponsibility 
]

{ #category : #accessing }
RAAttribute >> originalRelation [
	self subclassResponsibility 
]

{ #category : #printing }
RAAttribute >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '(', self name, ')'.
]

{ #category : #resolving }
RAAttribute >> resolveAttributeIn: aCollection [
	self subclassResponsibility 
]
