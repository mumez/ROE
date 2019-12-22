Class {
	#name : #RABinaryNode,
	#superclass : #RAConditionNode,
	#instVars : [
		'left',
		'right',
		'operator'
	],
	#category : #'Roe-Conditions'
}

{ #category : #'as yet unclassified' }
RABinaryNode class >> left: leftNode right: rightNode operator: aSymbol [
	^ self new setLeft: leftNode right: rightNode operator: aSymbol
]

{ #category : #visiting }
RABinaryNode >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitBinaryNode: self
]

{ #category : #accessing }
RABinaryNode >> left [
	^ left
]

{ #category : #accessing }
RABinaryNode >> operator [
	^ operator
]

{ #category : #accessing }
RABinaryNode >> right [
	^ right
]

{ #category : #private }
RABinaryNode >> setLeft: aNode right: otherNode operator: aSymbol [
	left := aNode.
	right := otherNode.
	operator := aSymbol
]

{ #category : #accessing }
RABinaryNode >> sqlOperator [
	right isNil ifTrue: [
		(operator = #=) ifTrue: [ ^ ' IS ' ].
		(operator = #~=) ifTrue: [ ^ ' IS NOT ' ] ].
	(operator = #&) ifTrue: [^' AND '].
	(operator = #|)  ifTrue: [^' OR '].	
	(operator = #~=) ifTrue: [^' != '].
	(operator = #like) ifTrue: [^' LIKE '].
	(operator = #ilike) ifTrue: [^' ILIKE '].
	
	^operator
		
]
