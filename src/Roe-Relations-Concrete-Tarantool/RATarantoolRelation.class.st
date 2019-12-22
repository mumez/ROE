Class {
	#name : #RATarantoolRelation,
	#superclass : #RASQLRelation,
	#category : #'Roe-Relations-Concrete-Tarantool'
}

{ #category : #private }
RATarantoolRelation >> basicExec: aString [
	| result |
	result := connection executeSql: aString.
	^ result
]

{ #category : #private }
RATarantoolRelation >> basicQuery: aString [
	| result |
	result := self basicExec: aString.
	^ result value
]

{ #category : #private }
RATarantoolRelation >> discoverAttributes [
	| resp |
	resp := connection executeSql: ('select * from {1} limit 1' format: {self name}).
	^(resp metadata columnNames) 
		collect: [ :each | RASimpleAttribute named: each relation: self ]
	
]

{ #category : #testing }
RATarantoolRelation >> shouldQuoteColumnName [
	^ false
]
