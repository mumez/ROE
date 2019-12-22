Class {
	#name : #RAEvaluator,
	#superclass : #RAVisitor,
	#category : #'Roe-Visitors'
}

{ #category : #'as yet unclassified' }
RAEvaluator class >> evaluate: aRelation [
	^ self new visit: aRelation
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitCartesianProduct: aRelation [
	| right left |
	right := self visit: aRelation right.
	left := self visit: aRelation left.
	^ (Array streamContents:
		[:s |
		left do: [:l | right do: [:r | s nextPut: l, r]]]).		
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitClone: aClone [
	^ self visitTransformation: aClone
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitDifference: aRelation [ 
	| right |
	right := self visit: aRelation right.
	^Array streamContents: 
			[:stream | 
			(self visit: aRelation left) 
				do: [:row | (right includes: row) ifFalse: [stream nextPut: row]]]
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitDistinct: aRelation [ 
	^(self visit: aRelation source)
		asSet asArray
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitIntersection: aRelation [ 
	^(self visit: aRelation left) intersection: (self visit: aRelation right)
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitInterval: aRelation [
	^(self visitTransformation: aRelation)
		copyFrom: aRelation start to: aRelation stop
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitOrder: aRelation [
	| result ascending order pos block |
	result := self visitTransformation: aRelation.
	aRelation order size to: 1 by: -1 do: [ :index |
		ascending := aRelation ascending at: index.
		order := aRelation order at: index.
		pos := aRelation attributes indexOf: order.
		block := [ :x :y |
			ascending
				ifTrue: [ (x at: pos) first < (y at: pos) first]
				ifFalse: [ (x at: pos) first > (y at: pos) first] ].
		result := result sort: block ].
	^result
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitProjection: aRelation [
	|projectedAttributes sourceAttributes|
	projectedAttributes := aRelation attributes.
	sourceAttributes := aRelation source attributes.
	^ (self visitTransformation: aRelation)
		 collect:
			[:tuple |
			Array streamContents:
				[:s |
				tuple with: sourceAttributes do:
					[:val :attr |
					(projectedAttributes includes: attr)
						ifTrue: [s nextPut: val]]]]
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitRelation: aRelation [
	^ aRelation tuples
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitSelection: aRelation [
	| arrays tuples |
	arrays := self visitTransformation: aRelation.
	tuples := arrays collect: [:ea | RABoxedTuple relation: aRelation values: ea].
	tuples := tuples select: [:ea | aRelation evaluateTuple: ea].
	^ tuples collect: [:ea | ea values]
]

{ #category : #'as yet unclassified' }
RAEvaluator >> visitUnion: aRelation [
	^ (self visit: aRelation left) , (self visit: aRelation right)
]
