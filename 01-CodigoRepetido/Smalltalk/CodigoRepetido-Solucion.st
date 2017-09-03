!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'ELR 9/2/2017 21:22:52'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| anExecutionContext customerBook|
	
	anExecutionContext := [customerBook := CustomerBook new].
	
	self excecutionTimeInMillisecondsOf: [customerBook addCustomerNamed: 'John Lennon'] withinThisContext: anExecutionContext isLessThan: 50.


	
! !

!IdiomTest methodsFor: 'testing' stamp: 'ELR 9/2/2017 21:13:55'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| anExecutionContext  customerBook|
	
	anExecutionContext:= [
				customerBook:= CustomerBook  new.
				customerBook addCustomerNamed: 'Paul McCartney'.
	].
	
	self excecutionTimeInMillisecondsOf: [ customerBook removeCustomerNamed: 'Paul McCartney'.] withinThisContext: anExecutionContext  isLessThan: 100
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'ELR 9/3/2017 16:47:47'!
test03CanNotAddACustomerWithEmptyName 

	|objectToBeModified colaborationObject objectState |
	
	objectToBeModified:=CustomerBook new.
     colaborationObject:=[:customerBook | customerBook addCustomerNamed: ''].
	objectState:=[:anError :customerBook | customerBook isEmpty & anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage].
	
	
	self applyingThisColaboration: colaborationObject overTheObject: objectToBeModified generatesAnError: Error ensuringFinalState: objectState! !

!IdiomTest methodsFor: 'testing' stamp: 'ELR 9/3/2017 16:54:42'!
test04CanNotRemoveAnInvalidCustomer
	
	|objectToBeModified colaborationObject objectState  |
	
	objectToBeModified :=CustomerBook new.
	objectToBeModified  addCustomerNamed: 'John Lennon'.
	colaborationObject:= [ :customerBook | customerBook removeCustomerNamed: 'Paul McCartney'].
	objectState:=[:anError :customerBook | (customerBook numberOfCustomers = 1) & (customerBook includesCustomerNamed: 'John Lennon')].
      
     self applyingThisColaboration: colaborationObject overTheObject: objectToBeModified generatesAnError: NotFound  ensuringFinalState: objectState 
! !


!IdiomTest methodsFor: 'helpers' stamp: 'ELR 9/3/2017 16:56:26'!
applyingThisColaboration: aColaboration overTheObject: anObjectToBeColaborated generatesAnError: anErrorClass ensuringFinalState: somthingEnsuredAfterError 
	
	
	[(aColaboration value:anObjectToBeColaborated )]
		on: anErrorClass 
		do: [:anError | (somthingEnsuredAfterError value:anError value:anObjectToBeColaborated )]! !

!IdiomTest methodsFor: 'helpers' stamp: 'ELR 9/2/2017 21:23:12'!
excecutionTimeInMillisecondsOf: aBlockClosure withinThisContext: aBlockClosure2 isLessThan: aSmallInteger 
		|millisecondsBeforeRunning millisecondsAfterRunning|
	aBlockClosure2.
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure .
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aSmallInteger ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IdiomTest class' category: #'CodigoRepetido-Ejercicio'!
IdiomTest class
	instanceVariableNames: 'customerBook'!

!IdiomTest class methodsFor: 'helpers' stamp: 'ELR 9/2/2017 20:38:49'!
isExcecutionTimeOf: aBlockClosure lessThan: aSmallInteger 
	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	^millisecondsAfterRunning - millisecondsBeforeRunning < aSmallInteger ! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
