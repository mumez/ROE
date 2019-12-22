Class {
	#name : #RATestSemantics,
	#superclass : #TestCase,
	#instVars : [
		'students',
		'students2',
		'courses',
		'profs',
		'enrollment',
		'dropouts',
		'connection'
	],
	#category : #'Roe-Tests'
}

{ #category : #private }
RATestSemantics >> addAllValues: anArray to: aRelation [
	aRelation addAllValues: anArray
]

{ #category : #private }
RATestSemantics >> assertQueryOrdered: aRelation gives: anArray [
	self assert: (aRelation collect: [:ea | ea values asArray]) asArray = anArray
]

{ #category : #private }
RATestSemantics >> assertQueryUnordered: aRelation gives: anArray [
	self assert: (aRelation collect: [:ea | ea values asArray]) asSet = anArray asSet
]

{ #category : #private }
RATestSemantics >> assertTuple: aTuple is: anArray [
	self assert: aTuple values asArray = anArray
]

{ #category : #private }
RATestSemantics >> createRelation: aString attributes: anArray [
	self subclassResponsibility 
]

{ #category : #private }
RATestSemantics >> selectCourseNumbersForProf: aString [
	^ ((profs * courses whereEqual: #(facultyID prof))
			where: #name equals: aString)
				project: #courseNumber
]

{ #category : #private }
RATestSemantics >> selectCourseTitlesForStudent: aString [
	^ (((students select: [:ea | ea name = aString]) * enrollment * courses)
		select: [:ea | (ea student = ea studentNumber) & (ea course = ea courseNumber)])
			project: #title
]

{ #category : #running }
RATestSemantics >> setUp [
	profs := self createRelation: 'profs' attributes: #(facultyID name).
	self addAllValues: #((1 'Murphy') (2 'Cavers') (3 'Tsiknis') (4 'Bob')) to: profs. 
	
	students := self createRelation: 'students' attributes: #(studentNumber name).
	self addAllValues: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob')) to: students.

	students2 := self createRelation: 'students2' attributes: #(studentNumber name).
	self addAllValues:  #((1 'Avi') (2 'Julian') (5 'Lukas') (6 'Adrian')) to: students2.

	courses := self createRelation: 'courses' attributes: #('courseNumber' 'title' 'prof').
	self addAllValues: #((310 'Software Engineering' 1) (220 'Discrete Math' 2) (128 'Scheme' 2) (304 'Databases' 3)) to: courses.

	self setUpEnrollmeents
]

{ #category : #running }
RATestSemantics >> setUpEnrollmeents [

	enrollment := self createRelation: 'enrollment' attributes: #('student' 'course').
	self addAllValues: #((1 310) (1 220) (2 220) (2 128) (3 220) (3 304) (3 310)) to: enrollment.
]

{ #category : #testing }
RATestSemantics >> testAllStudents [
	self assertQueryOrdered: students gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob'))
]

{ #category : #testing }
RATestSemantics >> testBothStudentAndProf [
	| profName studentName |
	profName := profs attributeNamed: #name.
	studentName := students attributeNamed: #name.
	self
		assertQueryOrdered:
			((profs * students select: [:ea | (ea at: profName) = (ea at: studentName)])
				project: profName)
		gives: #(('Bob'))
]

{ #category : #testing }
RATestSemantics >> testBothStudentAndProfOldStyle [
	self
		assertQueryOrdered: ((((profs rename: #name to: #profName)
						* (students rename: #name to: #studName))
							select: [:ea | ea profName = ea studName])
								project: #profName)
		gives: #(('Bob'))
]

{ #category : #testing }
RATestSemantics >> testDistinct [
	| student |
	student := enrollment attributeNamed: #student.

	self assertQueryOrdered: ((enrollment project: student) distinct orderBy: student) gives: #((1) (2) (3)).
	self assertQueryOrdered: ((enrollment project: #course) distinct orderBy: #course) gives: #((128) (220) (304) (310)).
]

{ #category : #testing }
RATestSemantics >> testFindClassmates [
	| classmates |
	classmates := enrollment clone.
	self assertQueryUnordered:
		((enrollment * classmates
			select: [:ea | ((ea at: enrollment>>#course) = (ea at: classmates>>#course))
							& ((ea at: enrollment>>#student) ~= (ea at: classmates>>#student))])
				projectAll: ( Array 
								with: enrollment>>#student
								with: classmates>>#student))
		gives: 
			#((1 3)(1 2)(2 3)(3 1)(2 1)(3 2))

]

{ #category : #testing }
RATestSemantics >> testFindClassmatesOldStyle [
	self assertQueryUnordered:
		(((enrollment * (enrollment renameAll: #(student course) to: #(classmate course2)))
			select: [:ea | (ea course = ea course2) & (ea student ~= ea classmate)])
				projectAll: #(student classmate))
		gives: 
			#((1 3)(1 2)(2 3)(3 1)(2 1)(3 2))
]

{ #category : #testing }
RATestSemantics >> testFindProfCourses [
	self
		assertQueryUnordered: (self selectCourseNumbersForProf: 'Cavers')
		gives: #((220) (128))
]

{ #category : #testing }
RATestSemantics >> testFindStudentCourses [
	self assertQueryUnordered: (self selectCourseTitlesForStudent: 'Andrew')
		gives: #(('Discrete Math') ('Databases') ('Software Engineering'))
]

{ #category : #testing }
RATestSemantics >> testIntervalStudents [
	| relation |
	relation := students orderBy: #studentNumber ascending: true.
	self
		assertQueryOrdered: (relation from: 1 to: 0)
		gives: #().
	self 
		assertQueryOrdered: (relation from: 1 to: 1)
		gives: #((1 'Avi')).
	self 
		assertQueryOrdered: (relation from: 1 to: 4)
		gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob')).

	self 
		assertQueryOrdered: (relation from: 2 to: 3)
		gives: #((2 'Julian') (3 'Andrew')).
	self 
		assertQueryOrdered: (relation copyFrom: 2 to: 3)
		gives: #((2 'Julian') (3 'Andrew')).
]

{ #category : #testing }
RATestSemantics >> testOrderStudents [
	self 
		assertQueryOrdered: (students orderBy: #studentNumber ascending: true)
		gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob')).
	self 
		assertQueryOrdered: (students orderBy: #studentNumber ascending: false)
		gives: #((4 'Bob') (3 'Andrew') (2 'Julian') (1 'Avi'))
]

{ #category : #testing }
RATestSemantics >> testSelectOneStudent [
	self
		assertQueryOrdered: (students select: [:ea | ea name = 'Julian'])
		gives: #((2 'Julian'))
]

{ #category : #testing }
RATestSemantics >> testSize [
	self assert: students size = 4
]

{ #category : #testing }
RATestSemantics >> testStudentExcept [
	self 
		assertQueryUnordered: (students - students2)
		gives: #((3 'Andrew') (4 'Bob')).
	self 
		assertQueryUnordered: (students difference: students2)
		gives: #((3 'Andrew') (4 'Bob')).
	self 
		assertQueryUnordered: (students2 - students)
		gives: #((5 'Lukas') (6 'Adrian')).
	self 
		assertQueryUnordered: (students2 difference: students)
		gives: #((5 'Lukas') (6 'Adrian')).

]

{ #category : #testing }
RATestSemantics >> testStudentIndex [
	|idx|
	idx := students indexBy: #studentNumber.
	self assertQueryUnordered: (idx at: 1) gives: #((1 'Avi')).
	idx := students keyBy: #studentNumber.
	self assertTuple: (idx at: 1) is: #(1 'Avi').	
]

{ #category : #testing }
RATestSemantics >> testStudentIntersect [
	self 
		assertQueryUnordered: (students intersection: students2)
		gives: #((1 'Avi') (2 'Julian')).
	self 
		assertQueryUnordered: (students2 intersection: students)
		gives: #((1 'Avi') (2 'Julian')).
]

{ #category : #testing }
RATestSemantics >> testStudentNames [
	self
		assertQueryOrdered: (students project: #name)
		gives: #(('Avi') ('Julian') ('Andrew') ('Bob'))
]

{ #category : #testing }
RATestSemantics >> testStudentUnion [
	self 
		assertQueryUnordered: (students , students2)
		gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob') (5 'Lukas') (6 'Adrian')).
	self 
		assertQueryUnordered: (students union: students2)
		gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob') (5 'Lukas') (6 'Adrian')).
	self 
		assertQueryUnordered: (students2 , students)
		gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob') (5 'Lukas') (6 'Adrian')).
	self 
		assertQueryUnordered: (students2 union: students)
		gives: #((1 'Avi') (2 'Julian') (3 'Andrew') (4 'Bob') (5 'Lukas') (6 'Adrian')).

]

{ #category : #testing }
RATestSemantics >> testUpdateAlias [
	(students rename: #studentNumber to: #sn) update: [:ea | ea sn: 1].
	self assertQueryUnordered: students gives: 
		#((1 'Avi') (1 'Julian') (1 'Andrew') (1 'Bob'))
]

{ #category : #testing }
RATestSemantics >> testUpdateAliasWithColumn [
	(students renameAll: #(name studentNumber) to: #(cn sn)) update: [:ea | ea cn: ea sn asString].
	self assertQueryUnordered: students gives: 
		#((1 '1') (2 '2') (3 '3') (4 '4'))
]

{ #category : #testing }
RATestSemantics >> testUpdateJoin [
	| join |
	join := students * profs.
	self should: [join update: [:ea | ea studentNumber: 17]] raise: Error
]

{ #category : #testing }
RATestSemantics >> testUpdateSimpleSelect [
	(students select: [:ea | ea name = 'Julian']) update: [:ea | ea name: 'Fitzell'].
	self assertQueryUnordered: students gives: 
		#((1 'Avi') (2 'Fitzell') (3 'Andrew') (4 'Bob'))
]

{ #category : #testing }
RATestSemantics >> testUpdateTableWithColumn [
	students update: [:ea | ea name: ea studentNumber asString].
	self assertQueryUnordered: students gives: 
		#((1 '1') (2 '2') (3 '3') (4 '4'))
]

{ #category : #testing }
RATestSemantics >> testUpdateTableWithLiteral [
	students update: [:ea | ea name: 'Foo'].
	self assertQueryUnordered: students gives: 
		#((1 'Foo') (2 'Foo') (3 'Foo') (4 'Foo'))
]
