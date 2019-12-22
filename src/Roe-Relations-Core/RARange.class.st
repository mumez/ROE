Class {
	#name : #RARange,
	#superclass : #RATransformation,
	#instVars : [
		'interval'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'instance creation' }
RARange class >> of: aSource from: min to: max [
	^ self basicNew setSource: aSource interval: (min to: max)
]

{ #category : #visiting }
RARange >> acceptRoeVisitor: aVisitor [
	^aVisitor visitInterval: self
]

{ #category : #accessing }
RARange >> interval [
	^interval
]

{ #category : #'accessing-interval' }
RARange >> limit [
	^self interval size
]

{ #category : #'accessing-interval' }
RARange >> offset [
	^self interval first - 1
]

{ #category : #initializing }
RARange >> setSource: aRelation interval: anInterval [
	source := aRelation.
	interval := anInterval
]

{ #category : #'accessing-interval' }
RARange >> start [
	^self interval first
]

{ #category : #'accessing-interval' }
RARange >> stop [
	^self interval last
]
