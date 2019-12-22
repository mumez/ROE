Class {
	#name : #RATestPostgresSemanticsWithNils,
	#superclass : #RATestPostgresSemantics,
	#category : #'Roe-Tests'
}

{ #category : #private }
RATestPostgresSemanticsWithNils >> addNilColumnsToTables: tableNames [
    |  setNotNilValues |

	setNotNilValues := false.

	tableNames do:
		[:ea | self connection execute: 
			('ALTER TABLE '
 , ea , ' ADD COLUMN ' , self nilColumnName , ' int4 ').
			setNotNilValues ifTrue:
				[ self connection execute: 
					('UPDATE  '
 , ea , ' SET ' , self nilColumnName , '=1')]
]

]

{ #category : #private }
RATestPostgresSemanticsWithNils >> assertQueryOrdered: aRelation gives: anArray [
	| myRelation |
	myRelation := self dropNilColumnFromRelation: aRelation.
	super assertQueryOrdered: myRelation gives: anArray
]

{ #category : #private }
RATestPostgresSemanticsWithNils >> assertQueryUnordered: aRelation gives: anArray [
	| myRelation |
	myRelation := self dropNilColumnFromRelation: aRelation.
	super assertQueryUnordered: myRelation gives: anArray
]

{ #category : #private }
RATestPostgresSemanticsWithNils >> dropNilColumnFromRelation: aRelation [

	^aRelation projectAll: 
		(aRelation attributes reject: [:attr | attr name = self nilColumnName])
		
]

{ #category : #private }
RATestPostgresSemanticsWithNils >> nilColumnName [
	^'nilcolumn'
]

{ #category : #private }
RATestPostgresSemanticsWithNils >> setUp [

	super setUp.
 
	self addNilColumnsToTables: 	#('profs' 'students' 'students2' 'courses' 'enrollment') .


]
