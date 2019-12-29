Class {
	#name : #RATestPostgresSemantics,
	#superclass : #RATestSemantics,
	#classVars : [
		'UrlString'
	],
	#category : #'Roe-Tests'
}

{ #category : #'class initialization' }
RATestPostgresSemantics class >> initialize [
	UrlString := nil
]

{ #category : #testing }
RATestPostgresSemantics class >> runTests [
	<script>
	| ts |
	ts := TestSuite named: 'RAPostgresTests'.
	(RATestSemantics selectorsInProtocol: 'testing') do: [ :sel |
		ts addTest: (RATestPostgresSemantics selector: sel) ].
	^ ts run inspect.

]

{ #category : #accessing }
RATestPostgresSemantics class >> urlString [
	^ UrlString
]

{ #category : #accessing }
RATestPostgresSemantics class >> urlString: anObject [
	"self urlString: 'psql://postgres:postgres@localhost:5432/postgres'"
	UrlString := anObject
]

{ #category : #configuration }
RATestPostgresSemantics >> connection [
	^ connection ifNil:
		[connection := P3Client new
							url: self class urlString;
							connect;
							yourself]
]

{ #category : #configuration }
RATestPostgresSemantics >> createRelation: aString attributes: anArray [
	^ RAPostgresRelation name: aString connection: self connection
]

{ #category : #private }
RATestPostgresSemantics >> setUp [
	self connection
		execute: 'create table profs ("facultyID" integer, name varchar)';
		execute: 'create table students ("studentNumber" integer, name varchar)';
		execute: 'create table students2 ("studentNumber" integer, name varchar)';
		execute: 'create table courses ("courseNumber" integer, title varchar, prof integer)';
		execute: 'create table enrollment (student integer, course integer)'.

	super setUp.

]

{ #category : #private }
RATestPostgresSemantics >> tearDown [
	#(profs students students2 courses enrollment) do:
		[:ea |
		connection execute: 'DROP TABLE ', ea].
	connection close.
	
]
