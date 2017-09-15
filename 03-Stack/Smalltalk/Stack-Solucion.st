!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'substack value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'ELR 9/15/2017 08:22:26'!
initialize
	substack:=OOStackBottom onBottomOf: self.! !


!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 08:00:05'!
isEmpty
	^substack isBottom.! !

!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:12:58'!
size
	^substack size! !

!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:11:15'!
top
	^substack storedValue.! !


!OOStack methodsFor: 'converting' stamp: 'ELR 9/15/2017 09:30:43'!
pop
	^substack pop.! !

!OOStack methodsFor: 'converting' stamp: 'ELR 9/15/2017 09:01:13'!
push: aString 
	substack := OOStackElement betweenABottom: substack andATop: self with: aString .
	! !


!OOStack methodsFor: 'associating' stamp: 'ELR 9/15/2017 08:23:38'!
rebase: anOOStackElement 
	substack :=anOOStackElement .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: 'value'!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !



!classDefinition: #OOStackBottom category: #'Stack-Exercise'!
Object subclass: #OOStackBottom
	instanceVariableNames: 'superstack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBottom methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 08:00:21'!
isBottom
	^true.! !

!OOStackBottom methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:13:37'!
size
	^0.! !

!OOStackBottom methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:18:40'!
storedValue
	^self error: OOStack stackEmptyErrorDescription .! !


!OOStackBottom methodsFor: 'converting' stamp: 'ELR 9/15/2017 08:21:28'!
of: aStack
	superstack:=aStack.! !

!OOStackBottom methodsFor: 'converting' stamp: 'ELR 9/15/2017 09:37:14'!
pop
	^self error: OOStack stackEmptyErrorDescription .! !

!OOStackBottom methodsFor: 'converting' stamp: 'ELR 9/15/2017 09:20:57'!
push: aStackElement 
	superstack:=aStackElement .
	aStackElement rebase: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackBottom class' category: #'Stack-Exercise'!
OOStackBottom class
	instanceVariableNames: 'superstack'!

!OOStackBottom class methodsFor: 'as yet unclassified' stamp: 'ELR 9/15/2017 08:20:13'!
onBottomOf: aStack
	| bottom |
	bottom:= self new.
	^bottom of: aStack .! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'value substack superstack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'converting' stamp: 'ELR 9/15/2017 09:30:18'!
pop

	substack push: superstack .
	
	^value.! !


!OOStackElement methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 08:23:57'!
isBottom
	^false.! !

!OOStackElement methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:13:22'!
size
	^substack size + 1.! !


!OOStackElement methodsFor: 'as yet unclassified' stamp: 'ELR 9/15/2017 09:02:09'!
store: aString betweenABottom: anOOStackBottom andATop: anOOStack 
	value := aString .
	superstack :=anOOStack .
	substack :=anOOStackBottom .
	substack push: self.! !


!OOStackElement methodsFor: 'associating' stamp: 'ELR 9/15/2017 09:48:07'!
push: anOOStackElement 
     anOOStackElement rebase: self .
	superstack := anOOStackElement .! !

!OOStackElement methodsFor: 'associating' stamp: 'ELR 9/15/2017 09:21:37'!
rebase: anOOStack 
	substack:= anOOStack .! !


!OOStackElement methodsFor: 'accessing' stamp: 'ELR 9/15/2017 09:07:22'!
storedValue
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: #'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'class initialization' stamp: 'ELR 9/15/2017 08:36:54'!
betweenABottom: anOOStackBottom andATop: anOOStack with: aString 
	| element |
	element:= self new.
	^element store: aString betweenABottom: anOOStackBottom andATop: anOOStack .! !

