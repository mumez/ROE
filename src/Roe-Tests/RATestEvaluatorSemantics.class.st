Class {
	#name : #RATestEvaluatorSemantics,
	#superclass : #RATestSemantics,
	#category : #'Roe-Tests'
}

{ #category : #private }
RATestEvaluatorSemantics >> createRelation: aString attributes: anArray [
	^ RAArrayRelation name: aString attributes: anArray
]
