Extension { #name : #Number }

{ #category : #'*Roe-Extensions' }
Number >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitNumber: self
]
