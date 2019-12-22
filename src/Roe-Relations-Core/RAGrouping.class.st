Class {
	#name : #RAGrouping,
	#superclass : #RATransformation,
	#instVars : [
		'group'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'instance creation' }
RAGrouping class >> of: aSource by: attributeRefs [
	^ self basicNew setSource: aSource groupAttributes: attributeRefs
]

{ #category : #visiting }
RAGrouping >> acceptRoeVisitor: aVisitor [
	^aVisitor visitGroup: self
]

{ #category : #accessing }
RAGrouping >> group [
	^group
]

{ #category : #testing }
RAGrouping >> isMutable [
	^false
]

{ #category : #initializing }
RAGrouping >> setSource: aRelation groupAttributes: attributeRefs [
	source := aRelation.
	group := attributeRefs collect: [:ea | ea resolveAttributeIn: source attributes].
]
