Extension { #name : #DateAndTime }

{ #category : #'*Roe-Extensions' }
DateAndTime >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitDateAndTime: self
]

{ #category : #'*Roe-Extensions' }
DateAndTime >> asSqlString [
	^ (self asDate asSqlString allButFirst allButLast , ' ' , self asTime asSqlString allButFirst allButLast) printString
]
