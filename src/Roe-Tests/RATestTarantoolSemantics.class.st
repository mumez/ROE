Class {
	#name : #RATestTarantoolSemantics,
	#superclass : #RATestSemantics,
	#classInstVars : [
		'uriString'
	],
	#category : #'Roe-Tests'
}

{ #category : #'class initialization' }
RATestTarantoolSemantics class >> initialize [
	"Before testing, you should set uriString to connect tarantool"
	"self initialize; uriString: 'username:password@192.168.1.123:3301'"
	uriString := nil
]

{ #category : #testing }
RATestTarantoolSemantics class >> runTests [
	<script>
	| ts |
	ts := TestSuite named: 'RATarantoolTests'.
	(RATestSemantics selectorsInProtocol: 'testing') do: [ :sel |
		ts addTest: (RATestTarantoolSemantics selector: sel) ].
	^ ts run inspect.

]

{ #category : #accessing }
RATestTarantoolSemantics class >> uriString [
	^ uriString
]

{ #category : #accessing }
RATestTarantoolSemantics class >> uriString: anObject [
	"self uriString: 'taran:talk@localhost:3301'"
	uriString := anObject
]

{ #category : #configuration }
RATestTarantoolSemantics >> connection [
	^ connection ifNil:
		[connection := self tarantalk]
]

{ #category : #configuration }
RATestTarantoolSemantics >> createRelation: aString attributes: anArray [
	^ RATarantoolRelation name: aString connection: self connection
]

{ #category : #running }
RATestTarantoolSemantics >> setUp [
	self connection
		executeSql: 'create table profs (facultyID integer PRIMARY KEY, name text)';
		executeSql: 'create table students (studentNumber integer PRIMARY KEY, name text)';
		executeSql: 'create table students2 (studentNumber integer PRIMARY KEY, name text)';
		executeSql: 'create table courses (courseNumber integer PRIMARY KEY, title text, prof integer)';
		executeSql: 'create table enrollment (student integer, course integer, id integer PRIMARY KEY)'.

	super setUp.

]

{ #category : #running }
RATestTarantoolSemantics >> setUpEnrollmeents [

	enrollment := self createRelation: 'enrollment' attributes: #('student' 'course').
	self addAllValues: #((1 310 1) (1 220 2) (2 220 3) (2 128 4) (3 220 5) (3 304 6) (3 310 7)) to: enrollment.
]

{ #category : #accessing }
RATestTarantoolSemantics >> tarantalk [
	| uriString talk |
	uriString := self class uriString.
	uriString ifNil: [ self error: 'Please set tarantool uri for testing' ].
	talk := TrTarantalk connect: uriString.
	talk waitAuthCompleted.
	^talk
]

{ #category : #private }
RATestTarantoolSemantics >> tearDown [
	#(profs students students2 courses enrollment) do:
		[:ea |
		connection executeSql: 'drop table if exists ', ea]
]

{ #category : #testing }
RATestTarantoolSemantics >> testUpdateAlias [
	(students rename: #name to: #sn) update: [:ea | ea sn: 'Bob'].
	self assertQueryUnordered: students gives: 
		#((1 'Bob') (2 'Bob') (3 'Bob') (4 'Bob'))
]
