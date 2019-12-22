Extension { #name : #Boolean }

{ #category : #'*Roe-Extensions' }
Boolean >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitBoolean: self
]
