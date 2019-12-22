Class {
	#name : #RAEscaptingSqlPrinter,
	#superclass : #RAPrinter,
	#category : #'Roe-Visitors'
}

{ #category : #private }
RAEscaptingSqlPrinter >> ifNeededDoubleQuoted: aString [
	self requester ifNil: [ ^ '"' , aString , '"'].
	
	^ self requester shouldQuoteColumnName
		ifTrue: [ '"' , aString , '"' ]
		ifFalse: [ aString ]
]

{ #category : #'visiting-objects' }
RAEscaptingSqlPrinter >> visitString: anObject [
	^self visitObject: anObject asEscapedSql
]

{ #category : #'visiting-objects' }
RAEscaptingSqlPrinter >> visitUndefinedObject: anObject [
	^ stream nextPutAll: 'NULL'
]
