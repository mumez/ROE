Class {
	#name : #RAPrinter,
	#superclass : #RAVisitor,
	#instVars : [
		'stream',
		'requester'
	],
	#category : #'Roe-Visitors'
}

{ #category : #'as yet unclassified' }
RAPrinter class >> on: aStream [
	^ self new stream: aStream
]

{ #category : #'as yet unclassified' }
RAPrinter class >> print: aRelation [
	^ self print: aRelation for: nil
]

{ #category : #'as yet unclassified' }
RAPrinter class >> print: aRelation for: requester [
	^ String
		streamContents: [ :s | 
			(self on: s)
				requester: requester;
				visit: aRelation ]
]

{ #category : #printing }
RAPrinter >> printOperator: aNode [
	stream nextPutAll: aNode operator
]

{ #category : #accessing }
RAPrinter >> requester [
	^requester
]

{ #category : #accessing }
RAPrinter >> requester: anObject [
	requester := anObject
]

{ #category : #accessing }
RAPrinter >> stream: aStream [
	stream := aStream
]

{ #category : #accessing }
RAPrinter >> tupleFor: aRelation [
	^ RASelectTuple relation: aRelation
]

{ #category : #visiting }
RAPrinter >> visitAttributeNode: aNode [
	stream nextPutAll: aNode name
]

{ #category : #visiting }
RAPrinter >> visitBinaryNode: aNode [
	stream nextPut: $(.
	self visit: aNode left.
	self printOperator: aNode.
	self visit: aNode right.
	stream nextPut: $).
]

{ #category : #visiting }
RAPrinter >> visitConditionNodesFor: aRelation [
	self visit: (aRelation evaluateTuple: (self tupleFor: aRelation))
]

{ #category : #visiting }
RAPrinter >> visitObject: anObject [
	anObject printOn: stream
]

{ #category : #visiting }
RAPrinter >> visitRelation: aRelation [
	aRelation printOn: stream
]
