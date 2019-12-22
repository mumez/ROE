Extension { #name : #Time }

{ #category : #'*Roe-Extensions' }
Time >> acceptRoeVisitor: aVisitor [
	^ aVisitor visitTime: self
]

{ #category : #'*Roe-Extensions' }
Time >> asSqlString [
	^ (String streamContents: [ :s | self print24: true showSeconds: true on: s ]) printString
]
