Class {
	#name : #RATestSyntax,
	#superclass : #TestCase,
	#instVars : [
		'abc',
		'def',
		'abcdef',
		'ab',
		'fe',
		'abd',
		'geh',
		'abqe',
		'aLT2',
		'bEQfoo',
		'abcSquared',
		'abcGBa',
		'abcGBab',
		'abcOBaa',
		'abcOBad',
		'abcOBaabd',
		'abcEabc',
		'abcUabc',
		'abcIabc',
		'abcD',
		'abcI'
	],
	#category : #'Roe-Tests'
}

{ #category : #private }
RATestSyntax >> assert: aRelation hasAttributes: attributeNames [
	self assert: (aRelation attributes collect: [:ea | ea name asSymbol]) asArray 
		    = attributeNames
]

{ #category : #private }
RATestSyntax >> assertError: aBlock [
	self should: aBlock raise: Error
]

{ #category : #running }
RATestSyntax >> setUp [
	abc := RAArrayRelation name: 'abc' attributes: #(a b c).
	def := RAArrayRelation name: 'def' attributes: #(d e f).

	abcdef := abc * def.
	ab := abc projectAll: #(a b).
	fe := def projectAll: #(f e).
	abd := abc rename: #c to: #d.
	geh := def renameAll: #(d f) to: #(g h).
	abqe := ab * (fe rename: #f to: #q).
	aLT2 := abc select: [:ea | ea a < 2].
	bEQfoo := abc select: [:ea | (ea b = 'foo') & (ea a >= (ea c * 2))].
	abcSquared := abc * (abc renameAll: #(a b c) to: #(a1 b1 c1)).
	abcGBa := abc groupBy: #a.
	abcGBab := abc groupByAll: #(a b).
	abcOBaa := abc orderBy: #a.
	abcOBad := abc orderBy: #a ascending: false.
	abcOBaabd := abc orderByAll: #(a b) ascending: (Array with: true with: false).
	abcEabc := abc difference: abc.   " abc - abc "
	abcUabc := abc union: abc.   " abc , abc "
	abcIabc := abc intersection: abc.
	abcD := abc distinct.
	abcI := abc from: 10 to: 15.	" abc copyFrom: 10 to: 15 "

]

{ #category : #testing }
RATestSyntax >> testAttributeNames [
	self assert: abc hasAttributes: #(a b c).
	self assert: def hasAttributes: #(d e f).	
	self assert: abcdef hasAttributes: #(a b c d e f).
	self assert: ab hasAttributes: #(a b).
	self assert: fe hasAttributes: #(f e).
	self assert: abd hasAttributes: #(a b d).
	self assert: geh hasAttributes: #(g e h).
	self assert: abqe hasAttributes: #(a b q e).
	self assert: aLT2 hasAttributes: #(a b c).
	self assert: bEQfoo hasAttributes: #(a b c).
	self assert: abcSquared hasAttributes: #(a b c a1 b1 c1).
	self assert: abcGBa hasAttributes: #(a b c).
	self assert: abcGBab hasAttributes: #(a b c).
	self assert: abcOBaa hasAttributes: #(a b c).
	self assert: abcOBad hasAttributes: #(a b c).
	self assert: abcOBaabd hasAttributes: #(a b c).
	self assert: abcEabc hasAttributes: #(a b c).	
	self assert: abcUabc hasAttributes: #(a b c).
	self assert: abcIabc hasAttributes: #(a b c).
	self assert: abcD hasAttributes: #(a b c).
	self assert: abcI hasAttributes: #(a b c).

]

{ #category : #testing }
RATestSyntax >> testEquality [
	self assert: (abc project: #a) = (abc project: #a).
	self deny: (abc project: #a) = (abc project: #b).
	self deny: (abc project: #a) = (ab project: #a).
	self assert: (abc rename: #a to: #x) = (abc rename: #a to: #x).
	self assert: (abc renameAll: #(a) to: #(x)) = (abc rename: #a to: #x).
	self assert: (abc renameAll: #(a b) to: #(x y)) = (abc renameAll: #(b a) to: #(y x)).
	self deny: (abc rename: #a to: #x) = (abc renameAll: #(a b) to: #(x y)).
]

{ #category : #testing }
RATestSyntax >> testErrors [
	abc project: #c.
	self assertError: [abc project: #d].
	self assertError: [ab project: #c].
	abc rename: #c to: #e.
	self assertError: [abc rename: #d to: #e].
	abc renameAll: #(a b) to: #(e f).
	self assertError: [abc renameAll: #(a b) to: #(e)].
	abc where: #a equals: 3.
	self assertError: [abc where: #d equals: 3].
	(abc*(abc rename: #a to: #a2)) project: #a.
	self assertError: [(abc*abc) project: #a].
	(abc*(abc rename: #a to: #a2)) rename: #a to: #e.
	self assertError: [(abc*abc) rename: #a to: #e].
	(abc*(abc rename: #a to: #a2)) where: #a equals: 3.
	self assertError: [(abc*abc) where: #a equals: 3].

]

{ #category : #testing }
RATestSyntax >> testEscapingSql [
	self assert: '\' asEscapedSql  = '\\'.
	self assert: '''' asEscapedSql  = ''''''.
	self assert: '\''' asEscapedSql  = '\\'''''.
]

{ #category : #testing }
RATestSyntax >> testOrigins [
	self assert: (abc attributeNamed: #a) originalRelation = abc.
	self assert: (abcdef attributeNamed: #a) originalRelation = abc.
	self assert: (abd attributeNamed: #d) originalRelation = abc.
	self assert: (abc attributeNamed: #c) originalAttribute = (abc attributeNamed: #c).
	self assert: (abd attributeNamed: #d) originalAttribute = (abc attributeNamed: #c).
	
]

{ #category : #testing }
RATestSyntax >> testPrinting [
"commented out cause I'm not sure we care"
"	self assert: abc prints: 'abc'.
	self assert: def prints: 'def'.
	self assert: abcdef prints: '(abc) * (def)'.
	self assert: ab prints: '(abc) projectAll: #(#a #b)'.
	self assert: fe prints: '(def) projectAll: #(#f #e)'.
	self assert: abd prints: '(abc) renameAll: #(#c) to: #(#d)'.
	self assert: geh prints: '(def) renameAll: #(#d #f) to: #(#g #h)'.
	self assert: abqe prints: '((abc) projectAll: #(#a #b)) * ( X R[f->q](P[f,e](def))'.
	self assert: aLT2 prints: 'S[(a<2)](abc)'.
	self assert: bEQfoo prints: 'S[((b=''foo'')&(a>=(c*2)))](abc)'.
	self assert: abcSquared prints: 'abc X R[a->a1,b->b1,c->c1](abc)'.
	self assert: abcGBa prints: 'G[a](abc)'.
	self assert: abcGBab prints: 'G[a,b](abc)'.
	self assert: abcOBaa prints: 'O[a->asc](abc)'.
	self assert: abcOBad prints: 'O[a->desc](abc)'.
	self assert: abcOBaabd prints: 'O[a->asc,b->desc](abc)'.
	self assert: abcEabc prints: 'abc \ abc'.	
	self assert: abcUabc prints: 'abc u abc'.
	self assert: abcIabc prints: 'abc n abc'.
	self assert: abcD prints: '{abc}'.
	self assert: abcI prints: 'I[10,15](abc)'.
"
]

{ #category : #testing }
RATestSyntax >> testPrintingAlgebraic [
	self assert: abc asAlgebraicString = 'abc'.
	self assert: def asAlgebraicString = 'def'.
	self assert: abcdef asAlgebraicString = 'abc X def'.
	self assert: ab asAlgebraicString = 'P[a,b](abc)'.
	self assert: fe asAlgebraicString = 'P[f,e](def)'.
	self assert: abd asAlgebraicString = 'R[c->d](abc)'.
	self assert: geh asAlgebraicString = 'R[d->g,f->h](def)'.
	self assert: abqe asAlgebraicString = 'P[a,b](abc) X R[f->q](P[f,e](def))'.
	self assert: aLT2 asAlgebraicString = 'S[(a<2)](abc)'.
	self assert: bEQfoo asAlgebraicString = 'S[((b=''foo'')&(a>=(c*2)))](abc)'.
	self assert: abcSquared asAlgebraicString = 'abc X R[a->a1,b->b1,c->c1](abc)'.
	self assert: abcGBa asAlgebraicString = 'G[a](abc)'.
	self assert: abcGBab asAlgebraicString = 'G[a,b](abc)'.
	self assert: abcOBaa asAlgebraicString = 'O[a->asc](abc)'.
	self assert: abcOBad asAlgebraicString = 'O[a->desc](abc)'.
	self assert: abcOBaabd asAlgebraicString = 'O[a->asc,b->desc](abc)'.
	self assert: abcEabc asAlgebraicString = 'abc \ abc'.	
	self assert: abcUabc asAlgebraicString = 'abc u abc'.
	self assert: abcIabc asAlgebraicString = 'abc n abc'.
	self assert: abcD asAlgebraicString = '{abc}'.
	self assert: abcI asAlgebraicString = 'I[10,15](abc)'.

]

{ #category : #testing }
RATestSyntax >> testPrintingSql [
	self assert: (RASqlPrinter print: abc) =  'SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc'.
	self assert: (RASqlPrinter print: def) =  'SELECT "d" AS c1, "e" AS c2, "f" AS c3 FROM def'.
	self assert: (RASqlPrinter print: abcdef) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1, (SELECT "d" AS c4, "e" AS c5, "f" AS c6 FROM def) AS t2'.
	self assert: (RASqlPrinter print: ab) =  'SELECT c1, c2 FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1'.
	self assert: (RASqlPrinter print: fe) =  'SELECT c1, c2 FROM (SELECT "d" AS c3, "e" AS c2, "f" AS c1 FROM def) AS t1'.
	self assert: (RASqlPrinter print: abd) =  'SELECT c1 AS c1, c2 AS c2, c3 AS c4 FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1'.
	self assert: (RASqlPrinter print: geh) = 'SELECT c1 AS c2, c3 AS c3, c4 AS c5 FROM (SELECT "d" AS c1, "e" AS c3, "f" AS c4 FROM def) AS t1'.
	self assert: (RASqlPrinter print: abqe) =  'SELECT * FROM (SELECT c1, c2 FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1) AS t2, (SELECT c4 AS c5, c6 AS c6 FROM (SELECT c4, c6 FROM (SELECT "d" AS c7, "e" AS c6, "f" AS c4 FROM def) AS t3) AS t4) AS t5'.
	self assert: (RASqlPrinter print: aLT2) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 WHERE (c1<''2'')'.
	self assert: (RASqlPrinter print: bEQfoo) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 WHERE ((c2=''foo'') AND (c1>=(c3*''2'')))'.
	self assert: (RASqlPrinter print: abcSquared) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1, (SELECT c1 AS c4, c2 AS c5, c3 AS c6 FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t2) AS t3'.
	self assert: (RASqlPrinter print: abcGBa) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 GROUP BY c1'.
	self assert: (RASqlPrinter print: abcGBab) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 GROUP BY c1, c2'.
	self assert: (RASqlPrinter print: abcOBaa) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 ORDER BY c1 ASC'.
	self assert: (RASqlPrinter print: abcOBad) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 ORDER BY c1 DESC'.
	self assert: (RASqlPrinter print: abcOBaabd) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 ORDER BY c1 ASC, c2 DESC'.
	self assert: (RASqlPrinter print: abcEabc) =  'SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc EXCEPT SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc'.	
	self assert: (RASqlPrinter print: abcUabc) =  'SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc UNION SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc'.
	self assert: (RASqlPrinter print: abcIabc) =  'SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc INTERSECT SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc'.
	self assert: (RASqlPrinter print: abcD) =  'SELECT DISTINCT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1'.
	self assert: (RASqlPrinter print: abcI) =  'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 LIMIT 6 OFFSET 9'
]

{ #category : #testing }
RATestSyntax >> testPrintingSqlCondition [
	| notNullQuery nullQuery dateQuery trueQuery |
	notNullQuery := abc select: [:ea | ea a ~= nil].
	self assert: (RASqlPrinter print: notNullQuery) = 'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 WHERE (c1 IS NOT NULL)'.
	
	nullQuery := abc select: [:ea | ea a = nil].
	self assert: (RASqlPrinter print: nullQuery) = 'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 WHERE (c1 IS NULL)'.
	
	dateQuery := abc select: [:ea | ea a = (Date year: 2006 month: 11 day: 10 )].
	self assert: (RASqlPrinter print: dateQuery) = 'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 WHERE (c1=''2006-11-10'')'.
	
	trueQuery := abc select: [:ea | ea a = true].
	self assert: (RASqlPrinter print: trueQuery) = 'SELECT * FROM (SELECT "a" AS c1, "b" AS c2, "c" AS c3 FROM abc) AS t1 WHERE (c1=''true'')'.
]
