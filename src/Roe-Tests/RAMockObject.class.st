Class {
	#name : #RAMockObject,
	#superclass : #Object,
	#category : #'Roe-Tests'
}

{ #category : #'as yet unclassified' }
RAMockObject class >> fromValues: aDictionary [
	^ self new initializeWithValues: aDictionary
]

{ #category : #'initialize-release' }
RAMockObject >> initializeWithValues: aDictionary [
]
