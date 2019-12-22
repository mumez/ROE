Class {
	#name : #RAMappedCollection,
	#superclass : #Collection,
	#instVars : [
		'relation'
	],
	#category : #'Roe-Mapping'
}

{ #category : #'as yet unclassified' }
RAMappedCollection class >> on: aRelation [
	^ self new initializeWithRelation: aRelation
]

{ #category : #'as yet unclassified' }
RAMappedCollection >> do: aBlock [
	relation do: [:tuple | aBlock value: (self objectsForTuple: tuple)]
]

{ #category : #'as yet unclassified' }
RAMappedCollection >> initializeWithRelation: aRelation [
	relation := aRelation
]

{ #category : #'as yet unclassified' }
RAMappedCollection >> objectForTuple: anArray relation: aRelation attributes: attributeCollection [
	^ aRelation objectForValues:
		(self valuesForTuple: anArray attributes: attributeCollection)
]

{ #category : #'as yet unclassified' }
RAMappedCollection >> objectsForTuple: anArray [
	^ relation attributesGroupedByOriginalRelation collect:
		[:relationToAttributes |
		self
			objectForTuple: anArray
			relation: relationToAttributes key
			attributes: relationToAttributes value]
]

{ #category : #'as yet unclassified' }
RAMappedCollection >> valueForAttribute: anAttribute fromTuple: anArray [
	^ anArray at: (relation attributes indexOf: anAttribute)
]

{ #category : #'as yet unclassified' }
RAMappedCollection >> valuesForTuple: aTuple attributes: attributeCollection [
	^ Dictionary newFrom:
		(attributeCollection collect:
			[:attr |
			attr -> (aTuple valueForAttribute: attr)])
]
