Extension { #name : #Date }

{ #category : #'*Roe-Extensions' }
Date >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitDate: self
]

{ #category : #'*Roe-Extensions' }
Date >> asSqlString [
	^ self yyyymmdd printString
]
