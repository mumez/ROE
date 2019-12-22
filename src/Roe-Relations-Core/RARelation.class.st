Class {
	#name : #RARelation,
	#superclass : #Collection,
	#category : #'Roe-Relations-Core'
}

{ #category : #'core operators' }
RARelation >> * aRelation [
	^ RACartesianProduct of: self with: aRelation
]

{ #category : #'core operators' }
RARelation >> , aRelation [
	^self union: aRelation
]

{ #category : #'core operators' }
RARelation >> - aRelation [
	^self difference: aRelation
]

{ #category : #comparing }
RARelation >> = other [
	"pretty hackish"
	^ self printString = other printString
]

{ #category : #convenience }
RARelation >> >> aSymbol [
	^ self attributeNamed: aSymbol
]

{ #category : #visiting }
RARelation >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitRelation: self
]

{ #category : #private }
RARelation >> ambiguousAttributeError: aString [
	self error: 'More than one attribute named ', aString printString.
]

{ #category : #converting }
RARelation >> asAlgebraicString [
	^String streamContents: [ :stream |
		(RAAlgebraicPrinter on: stream) visit: self ]
]

{ #category : #converting }
RARelation >> asArray [
	^(OrderedCollection new addAll: self; yourself)
		asArray
]

{ #category : #converting }
RARelation >> asMappedCollection [ 
	^ RAMappedCollection on: self
]

{ #category : #converting }
RARelation >> asOrderedCollection [
	^ OrderedCollection new 
		addAll: self;
		yourself
]

{ #category : #converting }
RARelation >> asSingleMappedCollection [ 
	^ RASingleMappedCollection on: self

]

{ #category : #accessing }
RARelation >> attributeNamed: aString [
	^ self attributeNamed: aString ifAbsent: [self couldNotFindAttributeError: aString]
]

{ #category : #accessing }
RARelation >> attributeNamed: aString ifAbsent: errorBlock [
	| attribute |
	attribute := nil.
       self attributes do: [:ea |
		(ea name asString sameAs: aString asString) ifTrue:
			[attribute ifNil: [attribute := ea]
				ifNotNil: [RAAttribute ambiguousAttributeError: aString]]].
       ^attribute ifNotNil: [attribute] ifNil: errorBlock
]

{ #category : #accessing }
RARelation >> attributes [
	self subclassResponsibility 
]

{ #category : #accessing }
RARelation >> attributesGroupedByOriginalRelation [
	^ Array with: self -> self attributes
]

{ #category : #'core operators' }
RARelation >> clone [
	^ RAClone of: self
]

{ #category : #private }
RARelation >> concreteRelation [
	self subclassResponsibility
]

{ #category : #'core operators' }
RARelation >> copyFrom: start to: stop [
	^self from: start to: stop
]

{ #category : #private }
RARelation >> couldNotFindAttributeError: aString [
	self error: 'Could not find attribute named ', aString printString.
]

{ #category : #removing }
RARelation >> delete [
	self concreteRelation deleteFor: self
]

{ #category : #'core operators' }
RARelation >> difference: aRelation [ 
	^RADifference of: self with: aRelation
]

{ #category : #'core operators' }
RARelation >> distinct [
	^RADistinct source: self
]

{ #category : #enumerating }
RARelation >> do: aBlock [
	self concreteRelation for: self do: aBlock
]

{ #category : #'core operators' }
RARelation >> from: start to: stop [
	^RARange of: self from: start to: stop
]

{ #category : #'core operators' }
RARelation >> groupBy: aString [
	^self groupByAll: (Array with: aString)
]

{ #category : #'core operators' }
RARelation >> groupByAll: attributeNames [
	^RAGrouping of: self by: attributeNames
]

{ #category : #comparing }
RARelation >> hash [
	^ self printString hash
]

{ #category : #'core operators' }
RARelation >> indexBy: attributeName [
	^ RAIndexWrapper on: self key: attributeName
]

{ #category : #'core operators' }
RARelation >> intersection: aRelation [ 
	^RAIntersection of: self with: aRelation
]

{ #category : #testing }
RARelation >> isMutable [
	^true
]

{ #category : #'core operators' }
RARelation >> keyBy: attributeName [
	^ RAIndexWrapper on: self uniqueKey: attributeName

]

{ #category : #'core operators' }
RARelation >> orderBy: aString [
	^self orderByAll: (Array with: aString)
]

{ #category : #'core operators' }
RARelation >> orderBy: aString ascending: aBoolean [
	^self 
		orderByAll: (Array with: aString) 
		ascending: (Array with: aBoolean)
]

{ #category : #'core operators' }
RARelation >> orderByAll: attributeNames [
	| ascending |
	ascending := Array 
		new: attributeNames size 
		withAll: true.
	^self 
		orderByAll: attributeNames 
		ascending: ascending
]

{ #category : #'core operators' }
RARelation >> orderByAll: attributeNames ascending: booleanArray [
	^RAOrdering
		of: self 
		order: attributeNames 
		ascending: booleanArray
]

{ #category : #'core operators' }
RARelation >> project: aString [
	^ self projectAll: (Array with: aString)
]

{ #category : #'core operators' }
RARelation >> projectAll: attributeNames [
	^ RAProjection of: self into: attributeNames
]

{ #category : #'core operators' }
RARelation >> rename: oldName to: newName [
	^ self renameAll: (Array with: oldName) to: (Array with: newName)
]

{ #category : #'core operators' }
RARelation >> renameAll: oldNameArray to: newNameArray [
	^ RAAlias of: self from: oldNameArray to: newNameArray 
]

{ #category : #'core operators' }
RARelation >> select: aBlock [
	^ RASelection from: self where: aBlock
]

{ #category : #testing }
RARelation >> shouldQuoteColumnName [
	^ true
]

{ #category : #private }
RARelation >> species [
	^ OrderedCollection
]

{ #category : #'core operators' }
RARelation >> union: aRelation [
	^RAUnion of: self with: aRelation
]

{ #category : #updating }
RARelation >> update: aBlock [
	self concreteRelation for: self update: aBlock
]

{ #category : #convenience }
RARelation >> where: attributeName equals: anObject [
	| attr |
	attr := self attributeNamed: attributeName.
	^self select: [:ea | (ea valueForAttribute: attr) = anObject]
]

{ #category : #convenience }
RARelation >> whereEqual: attributePair [
	^ self select: [:ea | (ea valueForAttributeNamed: attributePair first) = (ea valueForAttributeNamed: attributePair last)]
]
