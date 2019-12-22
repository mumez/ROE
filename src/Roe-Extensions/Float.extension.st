Extension { #name : #Float }

{ #category : #'*Roe-Extensions' }
Float >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitFloat: self
]
