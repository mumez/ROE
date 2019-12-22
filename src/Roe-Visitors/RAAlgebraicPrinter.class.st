Class {
	#name : #RAAlgebraicPrinter,
	#superclass : #RAPrinter,
	#category : #'Roe-Visitors'
}

{ #category : #visiting }
RAAlgebraicPrinter >> visitAlias: aRelation [
	| sourceAttributes attributes |
	stream nextPutAll: 'R['.
	sourceAttributes := aRelation source attributes.
	attributes := aRelation attributes.
	sourceAttributes with: attributes do:
		[:old :new |
		old = new ifFalse:
			[stream
				nextPutAll: old name;
				nextPutAll: '->';
				nextPutAll: new name;
				nextPutAll: ',']].
	(stream contents endsWith: ',') ifTrue: [stream skip: -1].
	stream nextPutAll: ']'.
	self visitTransformation: aRelation.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitCartesianProduct: aRelation [
	self visit: aRelation left.
	stream nextPutAll: ' X '.
	self visit: aRelation right.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitDifference: aRelation [ 
	self visit: aRelation left.
	stream nextPutAll: ' \ '.
	self visit: aRelation right
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitDistinct: aRelation [
	stream nextPut: ${.
	self visit: aRelation source.
	stream nextPut: $}.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitGroup: aRelation [
	stream nextPutAll: 'G['.
	aRelation group
		do: [ :each | stream nextPutAll: each name ]
		separatedBy: [ stream nextPut: $, ].
	stream nextPut: $].
	self visitTransformation: aRelation.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitIntersection: aRelation [ 
	self visit: aRelation left.
	stream nextPutAll: ' n '.
	self visit: aRelation right
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitInterval: aRelation [
	stream nextPutAll: 'I['.
	stream print: aRelation start.
	stream nextPut: $,.
	stream print: aRelation stop.
	stream nextPut: $].
	self visitTransformation: aRelation.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitOrder: aRelation [
	stream nextPutAll: 'O['.
	(1 to: aRelation order size)
		do: [ :index | 
			stream nextPutAll: (aRelation order at: index) name.
			(aRelation ascending at: index)
				ifTrue: [ stream nextPutAll: '->asc' ]
				ifFalse: [ stream nextPutAll: '->desc' ] ]
		separatedBy: [ stream nextPut: $, ].
	stream nextPut: $].
	self visitTransformation: aRelation.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitProjection: aRelation [
	stream nextPutAll: 'P['.
	aRelation attributes
		do: [ :each | stream nextPutAll: each name ]
		separatedBy: [ stream nextPut: $, ].
	stream nextPutAll: ']'.
	self visitTransformation: aRelation.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitRelation: aRelation [
	stream nextPutAll: aRelation name
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitSelection: aRelation [
	stream nextPutAll: 'S['.
	self visitConditionNodesFor: aRelation.
	stream nextPut: $].
	self visitTransformation: aRelation.
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitTransformation: aRelation [
	stream nextPut: $(.
	super visitTransformation: aRelation.
	stream nextPut: $).
]

{ #category : #visiting }
RAAlgebraicPrinter >> visitUnion: aRelation [
	self visit: aRelation left.
	stream nextPutAll: ' u '.
	self visit: aRelation right.
]
