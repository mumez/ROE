Extension { #name : #ScaledDecimal }

{ #category : #'*Roe-Extensions' }
ScaledDecimal >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitDecimal: self
]
