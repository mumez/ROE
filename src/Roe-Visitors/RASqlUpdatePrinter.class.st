Class {
	#name : #RASqlUpdatePrinter,
	#superclass : #RASqlPrinter,
	#category : #'Roe-Visitors'
}

{ #category : #visiting }
RASqlUpdatePrinter >> visitAttributeNode: aNode [
	stream nextPutAll: (self ifNeededDoubleQuoted: aNode attribute originalAttribute name)
]
