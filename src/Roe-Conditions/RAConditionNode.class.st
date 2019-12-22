Class {
	#name : #RAConditionNode,
	#superclass : #Object,
	#category : #'Roe-Conditions'
}

{ #category : #logical }
RAConditionNode >> & other [
	^ RABinaryNode
		left: self
		right: other
		operator: #&
]

{ #category : #arithmetic }
RAConditionNode >> * other [
	^ RABinaryNode
		left: self
		right: other
		operator: #*
]

{ #category : #arithmetic }
RAConditionNode >> + other [
	^ RABinaryNode
		left: self
		right: other
		operator: #+
]

{ #category : #arithmetic }
RAConditionNode >> - other [
	^ RABinaryNode
		left: self
		right: other
		operator: #-
]

{ #category : #arithmetic }
RAConditionNode >> / other [
	^ RABinaryNode
		left: self
		right: other
		operator: #/
]

{ #category : #comparing }
RAConditionNode >> < other [
	^ RABinaryNode
		left: self
		right: other
		operator: #<
]

{ #category : #comparing }
RAConditionNode >> <= other [
	^ RABinaryNode
		left: self
		right: other
		operator: #<=
]

{ #category : #comparing }
RAConditionNode >> = other [
	^ RABinaryNode
		left: self
		right: other
		operator: #=
]

{ #category : #comparing }
RAConditionNode >> > other [
	^ RABinaryNode
		left: self
		right: other
		operator: #>
]

{ #category : #comparing }
RAConditionNode >> >= other [
	^ RABinaryNode
		left: self
		right: other
		operator: #>=
]

{ #category : #visiting }
RAConditionNode >> acceptRoeVisitor: aVisitor [
	self subclassResponsibility
]

{ #category : #converting }
RAConditionNode >> asString [
	^ self
]

{ #category : #comparing }
RAConditionNode >> like: aString [
	^self 
		like: aString 
		ignoreCase: false
]

{ #category : #comparing }
RAConditionNode >> like: aString ignoreCase: aBoolean [
	^aBoolean
		ifFalse: [
			RABinaryNode
				left: self
				right: aString
				operator: #like ]
		ifTrue: [
			RABinaryNode
				left: self
				right: aString
				operator: #ilike ]
]

{ #category : #logical }
RAConditionNode >> | other [
	^ RABinaryNode
		left: self
		right: other
		operator: #|
]

{ #category : #comparing }
RAConditionNode >> ~= other [
	^ RABinaryNode
		left: self
		right: other
		operator: #~=
]
