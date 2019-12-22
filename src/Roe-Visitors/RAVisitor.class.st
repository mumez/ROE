Class {
	#name : #RAVisitor,
	#superclass : #Object,
	#category : #'Roe-Visitors'
}

{ #category : #visiting }
RAVisitor >> visit: anObject [
	^ anObject acceptRoeVisitor: self
]

{ #category : #visiting }
RAVisitor >> visitAlias: aRelation [
	^ self visitTransformation: aRelation
]

{ #category : #'visiting-objects' }
RAVisitor >> visitBoolean: aBoolean [
	^self visitObject: aBoolean
]

{ #category : #visiting }
RAVisitor >> visitCartesianProduct: aRelation [
]

{ #category : #visiting }
RAVisitor >> visitClone: aClone [
]

{ #category : #'visiting-objects' }
RAVisitor >> visitDate: aDate [
	^self visitObject: aDate
]

{ #category : #'visiting-objects' }
RAVisitor >> visitDateAndTime: aDateAndTime [
	^self visitObject: aDateAndTime
]

{ #category : #'visiting-objects' }
RAVisitor >> visitDecimal: aDecimal [
	^self visitNumber: aDecimal
]

{ #category : #visiting }
RAVisitor >> visitDifference: aRelation [ 
	
]

{ #category : #visiting }
RAVisitor >> visitDistinct: aRelation [
]

{ #category : #'visiting-objects' }
RAVisitor >> visitFloat: aFloat [
	^self visitNumber: aFloat
]

{ #category : #visiting }
RAVisitor >> visitGroup: aRelation [
]

{ #category : #'visiting-objects' }
RAVisitor >> visitInteger: anInteger [
	^self visitNumber: anInteger
]

{ #category : #visiting }
RAVisitor >> visitIntersection: aRelation [ 
	
]

{ #category : #visiting }
RAVisitor >> visitInterval: aRelation [
]

{ #category : #'visiting-objects' }
RAVisitor >> visitMoney: anObject [
	self visitObject: anObject
]

{ #category : #'visiting-objects' }
RAVisitor >> visitNumber: aNumber [
	^self visitObject: aNumber
]

{ #category : #'visiting-objects' }
RAVisitor >> visitObject: anObject [
]

{ #category : #visiting }
RAVisitor >> visitOrder: aRelation [
]

{ #category : #visiting }
RAVisitor >> visitProjection: aRelation [

]

{ #category : #visiting }
RAVisitor >> visitRelation: aRelation [
]

{ #category : #visiting }
RAVisitor >> visitSelection: aRelation [
	
]

{ #category : #'visiting-objects' }
RAVisitor >> visitString: aString [
	^self visitObject: aString
]

{ #category : #'visiting-objects' }
RAVisitor >> visitTime: aTime [
	^self visitObject: aTime
]

{ #category : #visiting }
RAVisitor >> visitTransformation: aRelation [
	^ self visit: aRelation source
]

{ #category : #'visiting-objects' }
RAVisitor >> visitUndefinedObject: anUndefinedObject [
	^self visitObject: anUndefinedObject
]

{ #category : #visiting }
RAVisitor >> visitUnion: aRelation [
]
