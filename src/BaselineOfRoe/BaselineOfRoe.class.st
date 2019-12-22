Class {
	#name : #BaselineOfRoe,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoe
}

{ #category : #baseline }
BaselineOfRoe >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self p3: spec.
			self pharoSqlite3: spec.
			self tarantalk: spec.
			spec
				package: 'Roe-Attributes';
				package: 'Roe-Conditions';
				package: 'Roe-Mapping';
				package: 'Roe-Relations-Concrete';
				package: 'Roe-Relations-Core';
				package: 'Roe-Relations-Indexed';
				package: 'Roe-Tuples';
				package: 'Roe-Visitors';
				package: 'Roe-Relations-Concrete-Tarantool';
				package: 'Roe-Relations-Concrete-Postgres';
				package: 'Roe-Relations-Concrete-SQLite';
				package: 'Roe-Tests'.
			spec
				group: 'default' with: #('Core' 'Roe-Postgres' 'Roe-SQLite' 'Roe-Tarantool' 'Tests');
				group: 'Core'
					with:
					#(#'Roe-Attributes' #'Roe-Conditions' #'Roe-Mapping' #'Roe-Relations-Concrete' #'Roe-Relations-Core' #'Roe-Relations-Indexed' #'Roe-Tests' #'Roe-Tuples' #'Roe-Visitors');
				group: 'Roe-Postgres' with: #('Roe-Relations-Concrete-Postgres');
				group: 'Roe-SQLite' with: #('Roe-Relations-Concrete-SQLite');
				group: 'Roe-Tarantool' with: #('Roe-Relations-Concrete-Tarantool');
				group: 'Tests' with: #('Roe-Tests') ]
]

{ #category : #'external projects' }
BaselineOfRoe >> p3: spec [
	spec
		baseline: 'P3'
		with: [ spec
				repository: 'github://svenvc/P3';
				loads: 'default' ]
]

{ #category : #'external projects' }
BaselineOfRoe >> pharoSqlite3: spec [
	spec
		baseline: 'Pharo-SQLite3'
		with: [ spec
				repository: 'github://pharo-rdbms/Pharo-SQLite3/src';
				loads: 'default' ]
]

{ #category : #'external projects' }
BaselineOfRoe >> tarantalk: spec [
	spec
		baseline: 'Tarantalk'
		with: [ spec
				repository: 'github://mumez/Tarantalk/repository';
				loads: 'default' ]
]
