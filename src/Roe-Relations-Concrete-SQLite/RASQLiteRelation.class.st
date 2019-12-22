Class {
	#name : #RASQLiteRelation,
	#superclass : #RASQLRelation,
	#category : #'Roe-Relations-Concrete-SQLite'
}

{ #category : #adding }
RASQLiteRelation >> addValues: anArray [
	self sqlInsert: (self attributes collect: [:ea | ea name]) values: anArray
]

{ #category : #accessing }
RASQLiteRelation >> attributes [
	"2014-07-27, pierce: Doesn't feel quite right, but the tests pass."
	
	((attributes isNil) or: [ attributes isArray ])
		ifTrue: [ attributes := self discoverAttributes ].
	^attributes
]

{ #category : #private }
RASQLiteRelation >> basicExec: aString [
	| results s |
	
	results := OrderedCollection new.
	s := connection prepare: aString.
	s basicExecute: [ :row | 
		| rv vc |
		rv := OrderedCollection new.
		vc := row dataValuesAvailable. 
		(vc >  0) ifTrue: [ 
			0 to: (vc - 1) do: [ :i | rv add: (row valueOfColumn: i) ].
			results add: rv ]].
	s finalize.
	^ results 
]

{ #category : #private }
RASQLiteRelation >> basicQuery: aString [
	^ self basicExec: aString
]

{ #category : #accessing }
RASQLiteRelation >> discoverAttributes [
	^(self connection columnNamesFor: self name)	
		collect: [ :each | RASimpleAttribute named: each relation: self ]

]

{ #category : #private }
RASQLiteRelation >> log [
	^ false
]

{ #category : #updating }
RASQLiteRelation >> materialize [
	
	attributes isArray ifTrue: [
		self sqlCreateTable: name attributes: attributes ].
	^ self attributes "which converts the programmer-supplied attributes array into ROE-style attributes."
]

{ #category : #private }
RASQLiteRelation >> sqlCreateTable: aName attributes: anArray [

	(self isProperSqlTableName: aName) ifTrue: [ 
		self basicExec: 'drop table if exists ', aName.
		self basicExec: (String streamContents: [ :stream |
							stream nextPutAll: 'create table ';
								nextPutAll: aName;
								nextPutAll: ' ('.
							anArray allButLastDo: [ :ea | stream nextPutAll: ea asString, ', ' ].
							stream nextPutAll: anArray last asString, ')' ]) ]
					
"We use SQLite's dynamic typing, meaning we don't specify data types for the columns in the table we are creating. See http://sqlite.org/datatype3.html."
					
]

{ #category : #private }
RASQLiteRelation >> sqlInsert: attributeNames values: anArray [

	^ connection execute: (String streamContents: [ :stream |
							stream nextPutAll: 'INSERT INTO '.
							stream nextPutAll: self name; nextPutAll: ' ('.
							attributeNames
								do: [ :each | stream nextPut: $"; nextPutAll: each; nextPut: $" ]
								separatedBy: [ stream nextPutAll: ', ' ].
							stream nextPutAll: ') VALUES ('.
							anArray	
								do: [ :each | stream nextPutAll: '?' ]
								separatedBy: [ stream nextPutAll: ', ' ].
							stream nextPutAll: ')' ])
				with: anArray
]
