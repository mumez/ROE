Class {
	#name : #RAProjection,
	#superclass : #RATransformation,
	#instVars : [
		'attributes'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'as yet unclassified' }
RAProjection class >> of: aRelation into: attributeRefs [
	^ self new setRelation: aRelation attributes: attributeRefs
]

{ #category : #visiting }
RAProjection >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitProjection: self
]

{ #category : #visiting }
RAProjection >> attributes [
	^ attributes
]

{ #category : #accessing }
RAProjection >> attributesGroupedByOriginalRelation [
	^ source attributesGroupedByOriginalRelation
			collect: [:assoc | assoc key -> (assoc value select: [:ea | attributes includes: ea])]
			thenSelect: [:assoc | assoc value isEmpty not]
]

{ #category : #initializing }
RAProjection >> setRelation: aRelation attributes: attributeRefs [
	source := aRelation.
	attributes := attributeRefs collect: [:ea | ea resolveAttributeIn: source attributes]
]
