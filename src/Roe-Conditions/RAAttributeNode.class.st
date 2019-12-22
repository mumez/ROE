Class {
	#name : #RAAttributeNode,
	#superclass : #RAConditionNode,
	#instVars : [
		'attribute'
	],
	#category : #'Roe-Conditions'
}

{ #category : #visiting }
RAAttributeNode >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitAttributeNode: self
]

{ #category : #private }
RAAttributeNode >> attribute [
	^ attribute
]

{ #category : #private }
RAAttributeNode >> attribute: anAttribute [
	attribute := anAttribute
]

{ #category : #accessing }
RAAttributeNode >> name [
	^ attribute name
]
