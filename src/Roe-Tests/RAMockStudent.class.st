Class {
	#name : #RAMockStudent,
	#superclass : #RAMockObject,
	#instVars : [
		'name'
	],
	#category : #'Roe-Tests'
}

{ #category : #'initialize-release' }
RAMockStudent >> initializeWithValues: aDictionary [
	name := aDictionary at: #name
]
