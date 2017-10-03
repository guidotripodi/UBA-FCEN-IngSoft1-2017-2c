!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #CabinMoving category: #'Elevator-Ejercicio'!
Object subclass: #CabinMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:54:45'!
doorOpen: aElevatorController

	.! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:47:08'!
isMoving
		^true .! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:45:47'!
isStopped
		^false .! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:53:52'!
doorOpen: aElevatorController
	self subclassResponsibility.! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:19:07'!
isMoving
		self subclassResponsibility .! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:19:16'!
isStopped
		self subclassResponsibility .! !


!classDefinition: #CabinStopped category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:57:34'!
doorOpen: aElevatorController
 aElevatorController cabinDoorOpenFinish.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:21:16'!
isMoving
^false.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:20:59'!
isStopped
^true.! !


!classDefinition: #Moving category: #'Elevator-Ejercicio'!
CabinState subclass: #Moving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Moving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:21:37'!
isMoving
^true.! !

!Moving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:21:50'!
isStopped
^false.! !


!classDefinition: #DoorState category: #'Elevator-Ejercicio'!
Object subclass: #DoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:31:07'!
isClose
	^self subclassResponsibility.! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:31:19'!
isClosing
	^self subclassResponsibility.! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:31:29'!
isOpen
	^self subclassResponsibility.! !

!DoorState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:31:45'!
isOpening
	^self subclassResponsibility.! !


!classDefinition: #DoorClosed category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:12:50'!
isClose
^true.! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:12:11'!
isClosing
^false.! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:13:00'!
isOpen
^false.! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:12:11'!
isOpening
^false.! !


!classDefinition: #DoorClosing category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:12:23'!
isClose
^false.! !

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:13:12'!
isClosing
^true.! !

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:13:19'!
isOpen
^false.! !

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:12:23'!
isOpening
^false.! !


!classDefinition: #DoorOpen category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorOpen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:11:04'!
isClose
^false.! !

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:11:11'!
isClosing
^false.! !

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:10:54'!
isOpen
^true.! !

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:11:19'!
isOpening
^false.! !


!classDefinition: #DoorOpening category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:15:45'!
isClose
	^false.! !

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:08:32'!
isClosing
	^false.! !

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:56:32'!
isOpen
	^false.! !

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:08:44'!
isOpening
	^true.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinState cabinDoorState cabinFloorNumber floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:44:07'!
cabinDoorClosed
	state := WorkingState  new.
	cabinState := CabinMoving new.
	cabinDoorState := DoorClosed  new.
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 21:20:25'!
cabinDoorClosing
cabinDoorState := DoorClosing new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 21:25:35'!
cabinDoorOpen
     cabinDoorState := DoorOpen new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:59:08'!
cabinDoorOpenFinish

	    "  floorsToGo  isEmpty  ifTrue: [ state := IdleState new ] ifFalse: [state :=  WorkingState  new].
     cabinState := CabinStopped new.
     cabinDoorState := DoorOpen new.
"! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 21:05:55'!
cabinDoorOpened
	
    floorsToGo  isEmpty  ifTrue: [ state := IdleState new ] ifFalse: [state :=  WorkingState  new].
     cabinState := CabinStopped new.
     cabinDoorState := DoorOpen new.
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:33:57'!
cabinFloorNumber
 ^cabinFloorNumber .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:28:03'!
cabinOnFloor: floor
     cabinState := CabinStopped new.
     cabinDoorState := DoorOpening new.
	cabinFloorNumber := floor.
	floorsToGo remove: floor.
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 21:22:20'!
closeCabinDoor
	
	"self isCabinDoorOpened ifTrue:   [ floorsToGo isEmpty ifTrue: [	state := IdleState new.] ifFalse: [state := WorkingState new.] .]  ."
	state closeCabinDoor: self.
	cabinState := CabinStopped new.

	

! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:46:09'!
goUpPushedFromFloor: aInteger
	floorsToGo add: aInteger.
	state _ WorkingState new.
	cabinState _ CabinStopped new.
	cabinDoorState _ DoorClosing new.
	cabinFloorNumber _ 0.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:46:09'!
initialize
	state _ IdleState new.
	cabinState _ CabinStopped new.
	cabinDoorState _ DoorOpen new.
	cabinFloorNumber _ 0.
	floorsToGo _ OrderedCollection new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:16:02'!
isCabinDoorClosed
	^cabinDoorState isClose .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:16:11'!
isCabinDoorClosing
	^cabinDoorState isClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:16:24'!
isCabinDoorOpened
	^cabinDoorState isOpen.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:16:56'!
isCabinDoorOpening
 	^cabinDoorState isOpening .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:22:06'!
isCabinMoving
	^cabinState isMoving .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:22:19'!
isCabinStopped
	^cabinState isStopped .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:15:07'!
isCabinWaitingForPeople
^true.

! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:17:45'!
isIdle
	^state isIdle .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:17:56'!
isWorking
  	^state isWorking .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:11:50'!
openCabinDoor
	self isCabinMoving  ifFalse: [self isIdle ifFalse: [cabinDoorState := DoorOpening new.]	ifTrue: [cabinDoorState := DoorOpen new.]].
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 20:18:34'!
waitForPeopleTimedOut
	
	state := WorkingState new.
	cabinState := CabinStopped  new.
	cabinDoorState := DoorClosing  new.! !


!classDefinition: #State category: #'Elevator-Ejercicio'!
Object subclass: #State
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:42:27'!
isIdle
		self subclassResponsibility .! !

!State methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:42:44'!
isWorking
		self subclassResponsibility .! !


!classDefinition: #IdleState category: #'Elevator-Ejercicio'!
State subclass: #IdleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!IdleState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 21:24:28'!
closeCabinDoor: aElevatorController
aElevatorController cabinDoorOpen.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:47:00'!
isIdle
	^true.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:47:14'!
isWorking
	^false.! !


!classDefinition: #WorkingState category: #'Elevator-Ejercicio'!
State subclass: #WorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!WorkingState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 21:23:20'!
closeCabinDoor: aElevatorController
aElevatorController cabinDoorClosing
! !

!WorkingState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:45:06'!
isIdle
	^false.! !

!WorkingState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:44:28'!
isWorking
	^true.! !
