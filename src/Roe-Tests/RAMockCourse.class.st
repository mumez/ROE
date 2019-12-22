Class {
	#name : #RAMockCourse,
	#superclass : #RAMockObject,
	#instVars : [
		'title'
	],
	#category : #'Roe-Tests'
}

{ #category : #'initialize-release' }
RAMockCourse >> initializeWithValues: aDictionary [
	title := aDictionary at: #title
]
