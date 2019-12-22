Class {
	#name : #RASingleTableSqlPrinter,
	#superclass : #RAEscaptingSqlPrinter,
	#category : #'Roe-Visitors'
}

{ #category : #visiting }
RASingleTableSqlPrinter >> errorInvalidOperation [
	self error: 'Invalid operation on this relation'
]

{ #category : #private }
RASingleTableSqlPrinter >> printOperator: aNode [
	stream nextPutAll: aNode sqlOperator
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitAlias: aRelation [
	self visit: aRelation source
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitAttributeNode: aNode [
	stream nextPutAll: (self ifNeededDoubleQuoted: aNode attribute originalAttribute name)
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitCartesianProduct: aRelation [
	self errorInvalidOperation
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitDifference: aRelation [ 
	self errorInvalidOperation 
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitDistinct: aRelation [
	self errorInvalidOperation 
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitGroup: aRelation [
	self errorInvalidOperation 
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitIntersection: aRelation [ 
	self errorInvalidOperation 
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitInterval: aRelation [
	self errorInvalidOperation 
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitOrder: aRelation [
	self visit: aRelation source
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitProjection: aRelation [
	self visit: aRelation source
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitRelation: aRelation [
	stream nextPutAll: ' 1=1'
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitSelection: aRelation [
	self visit: aRelation source.
	stream nextPutAll: ' AND ( '.
	self visitConditionNodesFor: aRelation.
	stream nextPutAll: ')'.
]

{ #category : #visiting }
RASingleTableSqlPrinter >> visitUnion: aRelation [
	self errorInvalidOperation 
]
