Class {
	#name : #RASQLRelation,
	#superclass : #RAConcreteRelation,
	#instVars : [
		'connection'
	],
	#category : #'Roe-Relations-Concrete'
}

{ #category : #'instance creation' }
RASQLRelation class >> name: aString [
	self shouldNotImplement
]

{ #category : #'instance creation' }
RASQLRelation class >> name: aString connection: aConnection [
	^ self basicNew initializeWithName: aString connection: aConnection
]

{ #category : #adding }
RASQLRelation >> addValues: anArray [
	self exec: (self sqlInsert: (self attributes collect: [:ea | ea name]) values: anArray)
]

{ #category : #accessing }
RASQLRelation >> attributes [
	attributes isNil
		ifTrue: [ attributes := self discoverAttributes ].
	^attributes
]

{ #category : #private }
RASQLRelation >> basicExec: aString [
	self subclassResponsibility
]

{ #category : #private }
RASQLRelation >> basicQuery: aString [
	self subclassResponsibility 
]

{ #category : #accessing }
RASQLRelation >> connection [
	^connection
]

{ #category : #removing }
RASQLRelation >> deleteFor: aRelation [ 
	| conditionString |
	conditionString := self singleTableSqlPrinterClass print: aRelation for: self.
	self exec: (self sqlDeleteWhere: conditionString).
]

{ #category : #private }
RASQLRelation >> discoverAttributes [
	
	self subclassResponsibility 
]

{ #category : #private }
RASQLRelation >> exec: aString [
	^ self basicExec: aString
]

{ #category : #private }
RASQLRelation >> for: aRelation do: aBlock [
	(self query: (self sqlPrinterClass print: aRelation for: self))
		do: [:ea | aBlock value: (RASimpleTuple relation: aRelation values: ea)].
]

{ #category : #updating }
RASQLRelation >> for: aRelation update: aBlock [
	| tuple conditionString |
	tuple := RAUpdateTuple relation: aRelation.
	aBlock value: tuple.
	conditionString := (self singleTableSqlPrinterClass print: aRelation for: self).
	self exec: (self sqlUpdate: tuple nodes where: conditionString).
]

{ #category : #private }
RASQLRelation >> ifNeededDoubleQuoted: aString [
	^ self shouldQuoteColumnName
		ifTrue: [ '"' , aString , '"' ]
		ifFalse: [ aString ]
]

{ #category : #initializing }
RASQLRelation >> initializeWithName: aString connection: aConnection [
	super initializeWithName: aString.
	connection := aConnection.
]

{ #category : #testing }
RASQLRelation >> isProperSqlTableName: aString [
	^ aString matchesRegex: '^(\w+\.)*\w+$' 
	
"This syntax is as per PostgreSQL, with the difference that the $ character is not accepted.
See http://www.postgresql.org/docs/current/static/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS"
]

{ #category : #private }
RASQLRelation >> log [
	^ true
]

{ #category : #private }
RASQLRelation >> logging: aString do: aBlock [
	| time val |
	time := Time millisecondsToRun: [val := aBlock value].
	self log ifTrue: [Transcript cr; show: aString, ' [', time asString, ']'].
	^ val
]

{ #category : #private }
RASQLRelation >> query: aString [
	^ self logging: aString do: [self basicQuery: aString]
]

{ #category : #factory }
RASQLRelation >> singleTableSqlPrinterClass [
	^ RASingleTableSqlPrinter
]

{ #category : #core }
RASQLRelation >> size [
	^ (self query: self sqlCount) first first
]

{ #category : #private }
RASQLRelation >> sqlCount [
	^ 'SELECT COUNT(*) FROM ' , self name
]

{ #category : #private }
RASQLRelation >> sqlDeleteWhere: conditionString [
	^ String streamContents:
		[:stream |
		stream
			nextPutAll: 'DELETE FROM ';
			nextPutAll: self name;
			nextPutAll: ' WHERE ';
			nextPutAll: conditionString]
			
]

{ #category : #private }
RASQLRelation >> sqlInsert: attributeNames values: anArray [
	^String streamContents: [ :stream |
		stream nextPutAll: 'INSERT INTO '.
		stream nextPutAll: self name; nextPutAll: ' ('.
		attributeNames
			do: [ :each | stream nextPutAll: (self ifNeededDoubleQuoted: each) ]
			separatedBy: [ stream nextPutAll: ', ' ].
		stream nextPutAll: ') VALUES ('.
		anArray	
			do: [ :each | stream nextPutAll: each asSqlString ]
			separatedBy: [ stream nextPutAll: ', ' ].
		stream nextPutAll: ')' ]
]

{ #category : #factory }
RASQLRelation >> sqlPrinterClass [
	^ RASqlPrinter 
]

{ #category : #private }
RASQLRelation >> sqlUpdate: attributesToNodes where: conditionString [
	^ String streamContents:
		[:stream |
		stream
			nextPutAll: 'UPDATE '.
		stream
			nextPutAll: self name;
			nextPutAll: ' SET '.
		attributesToNodes keysAndValuesDo:
			[:attribute :node |
					stream
						nextPutAll: (self ifNeededDoubleQuoted: attribute originalAttribute name);
						nextPutAll: ' = (';
						nextPutAll: (self sqlUpdatePrinterClass print: node for: self);
						nextPutAll: '), '].
		stream skip: -2.
		stream nextPutAll: ' WHERE '.
		stream nextPutAll: conditionString]
]

{ #category : #factory }
RASQLRelation >> sqlUpdatePrinterClass [
	^ RASqlUpdatePrinter 
]
