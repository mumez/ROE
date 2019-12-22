Class {
	#name : #RATestMapping,
	#superclass : #TestCase,
	#instVars : [
		'courses',
		'students'
	],
	#category : #'Roe-Tests'
}

{ #category : #running }
RATestMapping >> setUp [
	courses := RAMockRelation name: 'courses' attributes: #(id title).
	students := RAMockRelation name: 'students' attributes: #(name courseID).
	courses addAllValues: #((1 'Discrete Math') (2 'Databases')).
	students addAllValues: #(('Avi' 2) ('Ken' 2)).
	courses objectClass: RAMockCourse.
	students objectClass: RAMockStudent.
]

{ #category : #private }
RATestMapping >> studentsForCourseID: courseID [
	^ (students * (courses where: #id equals: courseID)) whereEqual: #(id courseID)
]

{ #category : #testing }
RATestMapping >> testObjectInstantiation [
	| mappedStudents |
	mappedStudents := (self studentsForCourseID: 2) asMappedCollection.
	self assert: mappedStudents size = 2.
	self assert: mappedStudents anyOne first class = RAMockStudent.
	self assert: mappedStudents anyOne second class = RAMockCourse.
]

{ #category : #testing }
RATestMapping >> testSelfJoins [
	| mapping tuple |
	mapping := (students * students * courses * students * courses) asMappedCollection.
	tuple := mapping anyOne.
	self assert: (tuple collect: [:ea | ea class name]) = #(RAMockStudent RAMockStudent RAMockCourse RAMockStudent RAMockCourse).
]

{ #category : #testing }
RATestMapping >> testSingleObjectInstantiation [
	| mappedStudents |
	mappedStudents := students asSingleMappedCollection.
	self assert: mappedStudents size = 2.
	self assert: mappedStudents anyOne class = RAMockStudent
]
