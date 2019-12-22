Class {
	#name : #RAAlias,
	#superclass : #RATransformation,
	#instVars : [
		'attributes'
	],
	#category : #'Roe-Relations-Core'
}

{ #category : #'as yet unclassified' }
RAAlias class >> of: aRelation from: attributeRefs to: nameArray [
	^ self new setRelation: aRelation attributes: attributeRefs newNames: nameArray
]

{ #category : #visiting }
RAAlias >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitAlias: self
]

{ #category : #accessing }
RAAlias >> attributes [
	^ attributes
]

{ #category : #accessing }
RAAlias >> attributesGroupedByOriginalRelation [
	^ source attributesGroupedByOriginalRelation collect:
		[:assoc |
		assoc key ->
			(assoc value collect:
				[:attr |
				attributes
					detect: [:ea | (ea respondsTo: #source) and: [ea source = attr]]
					ifNone: [attr]])]
]

{ #category : #initializing }
RAAlias >> setRelation: aRelation attributes: attributeRefs newNames: newNames [
	source := aRelation.
	attributes := source attributes copy.
	attributeRefs with: newNames do:
		[:ref :new ||attr|
		attr := ref resolveAttributeIn: attributes.
		attributes replaceAll: attr with: (RAAliasedAttribute attribute: attr name: new)]
]
