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


!classDefinition: #OOStackMixinElement category: #'Stack-Exercise'!
Object subclass: #OOStackMixinElement
	instanceVariableNames: 'substack superstack value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackMixinElement methodsFor: 'creation' stamp: 'ELR 9/16/2017 15:21:32'!
initialize
	self asBottomOf: self.
	self rebase: self .
! !


!OOStackMixinElement methodsFor: 'converting' stamp: 'ELR 9/16/2017 15:21:06'!
asBottomOf: aStack
	superstack:=aStack.! !

!OOStackMixinElement methodsFor: 'converting' stamp: 'ELR 9/16/2017 15:07:18'!
store: aString
	value := aString .! !


!OOStackMixinElement methodsFor: 'evaluating' stamp: 'ELR 9/16/2017 14:20:25'!
isEmpty
	^self size = 0.! !

!OOStackMixinElement methodsFor: 'evaluating' stamp: 'ELR 9/16/2017 14:19:55'!
size
	^substack size + 1.! !


!OOStackMixinElement methodsFor: 'accessing' stamp: 'ELR 9/16/2017 14:37:12'!
top
	^value.! !


!OOStackMixinElement methodsFor: 'associating' stamp: 'ELR 9/16/2017 14:47:57'!
pop
	substack push: superstack .
	^self top .! !

!OOStackMixinElement methodsFor: 'associating' stamp: 'ELR 9/16/2017 15:21:36'!
push: aStackElement 
	self asBottomOf: aStackElement.
	aStackElement rebase: self.! !

!OOStackMixinElement methodsFor: 'associating' stamp: 'ELR 9/16/2017 13:16:07'!
rebase: anOOStack 
	substack:= anOOStack .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackMixinElement class' category: #'Stack-Exercise'!
OOStackMixinElement class
	instanceVariableNames: ''!

!OOStackMixinElement class methodsFor: 'as yet unclassified' stamp: 'ELR 9/16/2017 14:54:05'!
asBottom
	^ OOVoidStack new.! !

!OOStackMixinElement class methodsFor: 'as yet unclassified' stamp: 'ELR 9/16/2017 15:07:43'!
with: aString
	^ self new store: aString.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
OOStackMixinElement subclass: #OOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/16/2017 15:20:49'!
asBottomOf: anStack
! !

!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:12:58'!
size
	^substack size! !

!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/16/2017 15:10:46'!
store: String
	^substack store: String.! !

!OOStack methodsFor: 'evaluating' stamp: 'ELR 9/16/2017 14:37:48'!
top
	^substack top.! !


!OOStack methodsFor: 'converting' stamp: 'ELR 9/15/2017 09:30:43'!
pop
	^substack pop.! !

!OOStack methodsFor: 'converting' stamp: 'ELR 9/16/2017 15:21:27'!
push: aString
	| newElement |
	newElement _ OOStackMixinElement with: aString.
	newElement rebase: substack.
	newElement asBottomOf: self.
	substack asBottomOf: newElement.
	self rebase: newElement.! !



!OOStack methodsFor: 'creation' stamp: 'ELR 9/16/2017 15:05:45'!
initialize
	substack _ OOStackMixinElement asBottom.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: 'value'!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !



!classDefinition: #OOVoidStack category: #'Stack-Exercise'!
OOStackMixinElement subclass: #OOVoidStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOVoidStack methodsFor: 'evaluating' stamp: 'ELR 9/15/2017 09:13:37'!
size
	^0.! !

!OOVoidStack methodsFor: 'evaluating' stamp: 'ELR 9/16/2017 14:36:17'!
top
	^self error: OOStack stackEmptyErrorDescription .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOVoidStack class' category: #'Stack-Exercise'!
OOVoidStack class
	instanceVariableNames: 'superstack'!
