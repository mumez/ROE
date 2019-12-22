Class {
	#name : #RAPostgresRelation,
	#superclass : #RASQLRelation,
	#category : #'Roe-Relations-Concrete-Postgres'
}

{ #category : #private }
RAPostgresRelation >> basicExec: aString [
	| result |
	result := connection execute: aString.
	^ result
]

{ #category : #private }
RAPostgresRelation >> basicQuery: aString [
	| result |
	result := connection query: aString.
	^ result data
]

{ #category : #accessing }
RAPostgresRelation >> discoverAttributes [
	^(self query: self sqlDiscoverAttributes) 
		collect: [ :each | RASimpleAttribute named: each first relation: self ]
	
]

{ #category : #private }
RAPostgresRelation >> sqlDiscoverAttributes [
	^	'SELECT attname FROM pg_class, pg_attribute WHERE relname = ',
		self name printString,
		' AND attnum > 0 AND attrelid = pg_class.oid AND NOT attisdropped'
]
