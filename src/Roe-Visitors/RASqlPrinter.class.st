Class {
	#name : #RASqlPrinter,
	#superclass : #RAEscaptingSqlPrinter,
	#instVars : [
		'tableCounter',
		'columnCounter',
		'columnMap'
	],
	#category : #'Roe-Visitors'
}

{ #category : #private }
RASqlPrinter >> attributeNames: aCollection [ 
	^String streamContents: [ :s |
		 aCollection 
			do: [ :each | s nextPutAll: (self columnNameForAttribute: each) ]
			separatedBy: [ s nextPutAll: ', ' ] ]
]

{ #category : #private }
RASqlPrinter >> attributeNames: aCollection aliasedAs: aliasCollection [
	^ String streamContents:
		[:s |
		aCollection with: aliasCollection do: 
			[:attr :alias |
			s
				nextPutAll: (self columnNameForAttribute: attr);
				nextPutAll: ' AS ';
				nextPutAll: (self columnNameForAttribute: alias);
				nextPutAll: ', '].
		s skip: -2]
]

{ #category : #private }
RASqlPrinter >> columnNameForAttribute: anAttribute [
	columnMap ifNil: [columnMap := Dictionary new].
	^ columnMap at: anAttribute ifAbsentPut: [self nextColumnName]
]

{ #category : #accessing }
RASqlPrinter >> nextColumnName [
	columnCounter := (columnCounter ifNil: [1] ifNotNil: [columnCounter + 1]).
	^ 'c', columnCounter asString
]

{ #category : #accessing }
RASqlPrinter >> nextTableName [
	tableCounter := (tableCounter ifNil: [1] ifNotNil: [tableCounter + 1]).
	^ 't', tableCounter asString
]

{ #category : #private }
RASqlPrinter >> printOperator: aNode [
	stream nextPutAll: aNode sqlOperator
]

{ #category : #private }
RASqlPrinter >> select: aString fromRelation: aRelation [
	stream
		nextPutAll: 'SELECT ';
		nextPutAll: aString;
		nextPutAll: ' FROM '.
	self subselectRelation: aRelation.
]

{ #category : #private }
RASqlPrinter >> selectAllFromRelation: aRelation [
	self select: '*' fromRelation: aRelation
]

{ #category : #private }
RASqlPrinter >> subselectRelation: aRelation [
	stream nextPut: $(.
	self visit: aRelation.
	stream nextPutAll: ') AS '; nextPutAll: self nextTableName.
]

{ #category : #visiting }
RASqlPrinter >> visitAlias: aRelation [
	self
		select:
			(self
				attributeNames: aRelation source attributes
				aliasedAs: aRelation attributes)
		fromRelation: aRelation source.
]

{ #category : #visiting }
RASqlPrinter >> visitAttributeNode: aNode [
	stream nextPutAll: (self columnNameForAttribute: aNode attribute)
]

{ #category : #visiting }
RASqlPrinter >> visitCartesianProduct: aRelation [
	stream nextPutAll: 'SELECT * FROM '.
	self subselectRelation: aRelation left.
	stream nextPutAll: ', '.
	self subselectRelation: aRelation right.
]

{ #category : #visiting }
RASqlPrinter >> visitClone: aRelation [
	self visitAlias: aRelation
]

{ #category : #visiting }
RASqlPrinter >> visitDifference: aRelation [ 
	"stream nextPutAll: '('."
	self visit: aRelation left.
	stream nextPutAll: ' EXCEPT '.
	self visit: aRelation right.
	"stream nextPutAll: ')'"
]

{ #category : #visiting }
RASqlPrinter >> visitDistinct: aRelation [
	stream nextPutAll: 'SELECT DISTINCT * FROM '.
	self subselectRelation: aRelation source.
]

{ #category : #visiting }
RASqlPrinter >> visitGroup: aRelation [
	stream nextPutAll: 'SELECT * FROM '.
	self subselectRelation: aRelation source.
	stream nextPutAll: ' GROUP BY '.
	stream nextPutAll: (self attributeNames: aRelation group).
]

{ #category : #visiting }
RASqlPrinter >> visitIntersection: aRelation [ 
	self visit: aRelation left.
	stream nextPutAll: ' INTERSECT '.
	self visit: aRelation right.

]

{ #category : #visiting }
RASqlPrinter >> visitInterval: aRelation [
	stream nextPutAll: 'SELECT * FROM '.
	self subselectRelation: aRelation source.
	stream nextPutAll: ' LIMIT '; print: aRelation limit.
	stream nextPutAll: ' OFFSET '; print: aRelation offset.
]

{ #category : #'visiting-objects' }
RASqlPrinter >> visitObject: anObject [
	stream nextPutAll: anObject asSqlString
]

{ #category : #visiting }
RASqlPrinter >> visitOrder: aRelation [
	stream nextPutAll: 'SELECT * FROM '.
	self subselectRelation: aRelation source.
	stream nextPutAll: ' ORDER BY '.
	(1 to: aRelation order size) 
		do: [ :index | 
			stream nextPutAll: (self columnNameForAttribute: (aRelation order at: index)).
			(aRelation ascending at: index) 
				ifTrue: [ stream nextPutAll: ' ASC' ] 
				ifFalse: [ stream nextPutAll: ' DESC' ] ]
		separatedBy: [ stream nextPutAll: ', ' ]
]

{ #category : #visiting }
RASqlPrinter >> visitProjection: aRelation [
	self select: (self attributeNames: aRelation attributes) fromRelation: aRelation source
]

{ #category : #visiting }
RASqlPrinter >> visitRelation: aRelation [
	stream nextPutAll: 'SELECT '.
	aRelation attributes
		do: [:attr |
			stream
				nextPutAll: (self ifNeededDoubleQuoted: attr name);
				nextPutAll: ' AS ';
				nextPutAll: (self columnNameForAttribute: attr) ]
		separatedBy: [
			stream nextPutAll: ', '].
	stream nextPutAll: ' FROM '.
	stream nextPutAll: aRelation name
]

{ #category : #visiting }
RASqlPrinter >> visitSelection: aRelation [
	self selectAllFromRelation: aRelation source.
	stream nextPutAll: ' WHERE '.
	self visitConditionNodesFor: aRelation.
]

{ #category : #visiting }
RASqlPrinter >> visitUnion: aRelation [
	self visit: aRelation left.
	stream nextPutAll: ' UNION '.
	self visit: aRelation right.

]
