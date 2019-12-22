Extension { #name : #Object }

{ #category : #'*Roe-Extensions' }
Object >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitObject: self
]

{ #category : #'*Roe-Extensions' }
Object >> asSqlString [
	^ self asString printString
]
