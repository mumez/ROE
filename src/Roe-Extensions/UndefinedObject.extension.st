Extension { #name : #UndefinedObject }

{ #category : #'*Roe-Extensions' }
UndefinedObject >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitUndefinedObject: self
]

{ #category : #'*Roe-Extensions' }
UndefinedObject >> asSqlString [
	^ 'NULL'
]
