Class {
	#name : #RASingleMappedCollection,
	#superclass : #RAMappedCollection,
	#category : #'Roe-Mapping'
}

{ #category : #'as yet unclassified' }
RASingleMappedCollection >> do: aBlock [
	super do: [:ea | aBlock value: ea first]
]
