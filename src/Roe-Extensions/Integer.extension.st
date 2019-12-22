Extension { #name : #Integer }

{ #category : #'*Roe-Extensions' }
Integer >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitInteger: self
]
