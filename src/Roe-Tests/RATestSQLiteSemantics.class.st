Class {
	#name : #RATestSQLiteSemantics,
	#superclass : #RATestSemantics,
	#category : #'Roe-Tests'
}

{ #category : #testing }
RATestSQLiteSemantics class >> runTests [
	<script>
	| ts |
	ts := TestSuite named: 'RASQLiteTests'.
	ts addTest: (RATestSQLiteSemantics selector: #testCreateTable).
	(RATestSemantics selectorsInProtocol: 'testing') do: [ :sel |
		ts addTest: (RATestSQLiteSemantics selector: sel) ].
	^ ts run inspect.

]

{ #category : #configuration }
RATestSQLiteSemantics >> connection [
	^ connection ifNil:
		[connection := UDBCSQLite3Connection on: self defaultConnectionArgs.
		 connection open; yourself]
]

{ #category : #configuration }
RATestSQLiteSemantics >> createRelation: aString attributes: anArray [
	^ RASQLiteRelation name: aString connection: self connection
]

{ #category : #configuration }
RATestSQLiteSemantics >> defaultConnectionArgs [
	^':memory:'
]

{ #category : #private }
RATestSQLiteSemantics >> setUp [
	self connection
		basicExecute: 'create table profs ("facultyID" integer, name varchar)';
		basicExecute: 'create table students ("studentNumber" integer, name varchar)';
		basicExecute: 'create table students2 ("studentNumber" integer, name varchar)';
		basicExecute: 'create table courses ("courseNumber" integer, title varchar, prof integer)';
		basicExecute: 'create table enrollment (student integer, course integer)'.

	super setUp.

]

{ #category : #private }
RATestSQLiteSemantics >> tearDown [
	#(profs students students2 courses enrollment) do:
		[:ea |
		connection basicExecute: 'DROP TABLE ', ea].
	connection close.
	
]

{ #category : #testing }
RATestSQLiteSemantics >> testCreateTable [
	dropouts := RASQLiteRelation name: 'dropouts' connection: connection.
	dropouts attributes: #(dropoutNumber studentName).
	dropouts materialize.
	self addAllValues: #((1 'Zandy') (2 'Yandy')) to: dropouts.
	self assertQueryUnordered: dropouts gives: #((1 'Zandy') (2 'Yandy'))
]
