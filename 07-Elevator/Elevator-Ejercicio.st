!classDefinition: #EventedFloorCollection category: #'Elevator-Ejercicio'!
OrderedCollection subclass: #EventedFloorCollection
	instanceVariableNames: 'master'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!EventedFloorCollection methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 18:14:25'!
errorNotFound: anObject
	"Actually, this should raise a special Exception not just an error."

	 ElevatorEmergency signal .! !

!EventedFloorCollection methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:00:55'!
for: aController
	master := aController .! !

!EventedFloorCollection methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 19:13:38'!
remove: aFloor.
	self isEmpty ifTrue: master notifyEmpty.
	super remove: aFloor . ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EventedFloorCollection class' category: #'Elevator-Ejercicio'!
EventedFloorCollection class
	instanceVariableNames: ''!

!EventedFloorCollection class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:03:29'!
for: aMaster

| instancia |
	instancia:= self new.
	instancia for: aMaster.
	^instancia! !


!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorEmergency methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 00:08:24'!
messageText
	^'Sensor de cabina desincronizado'! !


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

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:41:46'!
doorOpening: aCabinController 
	.! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:47:08'!
isMoving
		^true .! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:45:47'!
isStopped
		^false .! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:06:49'!
stopped: aCabinController 
	aCabinController toState: CabinStopped .! !


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

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:24:52'!
doorOpen: aElevatorController
 aElevatorController doorOpenedFinish.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:44:55'!
doorOpening: aCabinController 
	aCabinController doorOpeningFinish .! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:21:16'!
isMoving
^false.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 19:20:59'!
isStopped
^true.! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:41:03'!
moving: aCabinController 
	aCabinController toState: CabinMoving .! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:32:25'!
stopped: aCabinController 
	.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinStopped class' category: #'Elevator-Ejercicio'!
CabinStopped class
	instanceVariableNames: ''!

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:29:14'!
doorOpen: aCabinController 
	aCabinController doorOpenedFinish .! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:37:44'!
doorOpening: aCabinController 
	aCabinController doorOpeningFinish.! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 01:04:09'!
isMoving
	^false.! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:54:10'!
isStopped
	^true.! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 00:57:31'!
isStopped: aCabinController 
	^true.! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 01:09:08'!
moving
	self shouldBeImplemented.! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 01:12:37'!
moving: aCabinController 
	aCabinController toState: CabinMoving .! !

!CabinStopped class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:42:33'!
openCabinDoor: aCabinController 
	aCabinController openCabinDoorFinish.! !


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


!classDefinition: #Controller category: #'Elevator-Ejercicio'!
Object subclass: #Controller
	instanceVariableNames: 'state masterController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Controller methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 10:32:16'!
for: aMasterController
	masterController := aMasterController .
	! !

!Controller methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:16:07'!
toState: aStateClass
	state:= aStateClass  new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Controller class' category: #'Elevator-Ejercicio'!
Controller class
	instanceVariableNames: ''!

!Controller class methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 10:37:03'!
for: aMasterController
	|controller|
	controller := self new.
	controller for: aMasterController.
	^controller.! !


!classDefinition: #CabinController category: #'Elevator-Ejercicio'!
Controller subclass: #CabinController
	instanceVariableNames: 'floorController doorController elevatorController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:02:24'!
doorClosed
	doorController cabinDoorClosed .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:35:08'!
doorClosing
	doorController cabinDoorClosing .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:21:22'!
doorOpened
	state doorOpen: self.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:25:40'!
doorOpenedFinish
	doorController cabinDoorOpened .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:37:02'!
doorOpening
	state doorOpening: self.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:38:19'!
doorOpeningFinish
	doorController cabinDoorOpening .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:38:31'!
initialize
	state := CabinStopped new .
	floorController := FloorController for: self.
	doorController := DoorController for: self.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:16:42'!
isDoorClose
	^doorController isClose .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:16:19'!
isDoorClosing
	^doorController isClosing .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:12:22'!
isDoorOpen
	^doorController isOpen .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:15:56'!
isDoorOpening
	^doorController isOpening .! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 01:03:52'!
isMoving
	^state isMoving.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:53:28'!
isStopped
	^state isStopped.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 11:05:18'!
notifyEmpty
	masterController notifyEmpty.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:20:32'!
onFloor: aFloorNumber 
	floorController onFloor: aFloorNumber .
	doorController cabinDoorOpening .
	masterController toState: WorkingState .
	state stopped: self.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:32:07'!
stopped
	state stopped: self.! !


!CabinController methodsFor: 'accessing' stamp: 'ELR 10/8/2017 01:39:22'!
floorNumber
	^floorController floorNumber .! !

!CabinController methodsFor: 'accessing' stamp: 'ELR 10/8/2017 03:15:12'!
goUpPushedFromFloor: aFloorNumber
	floorController goUpPushedFromFloor: aFloorNumber.
	doorController cabinDoorClosing.! !

!CabinController methodsFor: 'accessing' stamp: 'ELR 10/8/2017 03:17:20'!
moving
	doorController cabinDoorClosed .
	state moving: self.! !


!classDefinition: #DoorController category: #'Elevator-Ejercicio'!
Controller subclass: #DoorController
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:16:54'!
cabinDoorClosed
	state cabinDoorClosed: self.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:06:06'!
cabinDoorClosing
	state cabinDoorClosing: self.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:32:43'!
cabinDoorOpened
	state cabinDoorOpened: self.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:09:17'!
cabinDoorOpening
     state cabinDoorOpening: self.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 22:59:57'!
isClose
	^state isClose.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:00:06'!
isClosing
	^state isClosing.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 22:59:19'!
isOpen
	^state isOpen.! !

!DoorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:00:16'!
isOpening
	^state isOpening.! !


!DoorController methodsFor: 'nil' stamp: 'ELR 10/7/2017 22:44:02'!
initialize
	state:= DoorOpen new.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Controller subclass: #ElevatorController
	instanceVariableNames: 'cabinController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:05:12'!
cabinDoorClosed
	state := WorkingState  new.
	cabinController  moving.
	
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:06:21'!
cabinDoorClosing
	cabinController doorClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:04:22'!
cabinDoorOpen
     cabinController doorOpened .
	state idle: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 10:37:58'!
cabinDoorOpened
	.
	cabinController stopped.
	cabinController doorOpened .
"    floorsToGo  isEmpty  ifTrue: [ state := IdleState new ] ifFalse: [state :=  WorkingState  new].
     cabinState := CabinStopped new.
     doorController cabinDoorOpened.
"! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 00:46:41'!
cabinFloorNumber
 ^cabinController floorNumber.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:15:24'!
cabinOnFloor: floor
     cabinController onFloor: floor.
     
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 22:35:36'!
closeCabinDoor
	
	"self isCabinDoorOpened ifTrue:   [ floorsToGo isEmpty ifTrue: [	state := IdleState new.] ifFalse: [state := WorkingState new.] .]  ."
	state closeCabinDoor: self.

	

! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:03:21'!
closeCabinDoorCheck
	cabinController doorClosing .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:15:01'!
goUpPushedFromFloor: aInteger
	cabinController goUpPushedFromFloor: aInteger.
	state _ WorkingState new.
	
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 10:34:07'!
initialize
	state _ IdleState new.
	cabinController _ CabinController for: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:09:27'!
isCabinDoorClosed
	^cabinController isDoorClose.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:09:42'!
isCabinDoorClosing
	^cabinController isDoorClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:09:55'!
isCabinDoorOpened
	^cabinController isDoorOpen.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:10:08'!
isCabinDoorOpening
 	^cabinController isDoorOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 01:03:27'!
isCabinMoving
	^cabinController isMoving .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 00:52:19'!
isCabinStopped
	^cabinController isStopped .! !

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

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:04:52'!
notifyEmpty
	state idle: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:47:18'!
openCabinDoor
	"self isCabinMoving  ifFalse: [self isIdle ifFalse: [doorController openingCabinDoor]	ifTrue: [doorController openCabinDoor]]."
	state openCabinDoor: self.
		! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:26:43'!
openCabinDoorFinish
	cabinController doorOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:36:18'!
openingCabinDoorCheck
	cabinController doorOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:11:11'!
openingCabinDoorFinish
	cabinController openingDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:33:10'!
waitForPeopleTimedOut
	
	state := WorkingState new.
	cabinController stopped.
	cabinController doorClosing .! !


!classDefinition: #FloorController category: #'Elevator-Ejercicio'!
Controller subclass: #FloorController
	instanceVariableNames: 'floorsToGo floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!FloorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 01:43:44'!
floorNumber
	^floor ! !

!FloorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 18:35:39'!
goUpPushedFromFloor: aFloorNumber 
	
	floor to: aFloorNumber do:[:passingFloor | floorsToGo add: passingFloor] .
	floorsToGo remove: floor.! !

!FloorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 10:59:15'!
initialize
	floor _ 0.
	floorsToGo _ EventedFloorCollection for: self.! !

!FloorController methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 11:04:50'!
notifyEmpty
	masterController notifyEmpty.! !


!FloorController methodsFor: 'accessing' stamp: 'ELR 10/8/2017 19:09:49'!
onFloor: aFloorNumber 

	floorsToGo remove: aFloorNumber .
	floor:=aFloorNumber .! !


!classDefinition: #DoorState category: #'Elevator-Ejercicio'!
Object subclass: #DoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorState methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 21:22:05'!
closeCabinDoor: aElevatorController
	self subclassResponsibility .
! !

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

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:18:01'!
cabinDoorClosed: aDoorController 
	.! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:10:25'!
cabinDoorClosing: aDoorController 
	 .! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:33:54'!
cabinDoorOpened: aController
	aController toState: DoorOpen .! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:14:12'!
cabinDoorOpening: aDoorController 
	aDoorController toState: DoorOpening .! !

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 21:25:28'!
closeCabinDoor: anElevatorController 
	.! !

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

!DoorClosed methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:58:52'!
openingCabinDoor: aDoorController 
	aDoorController toState: DoorOpening .! !


!classDefinition: #DoorClosing category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:32:37'!
cabinDoorClosed: aDoorController 
	aDoorController toState: DoorClosed .! !

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:33:39'!
cabinDoorOpened: aDoorController 
	aDoorController  toState: DoorOpen .! !

!DoorClosing methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:40:07'!
cabinDoorOpening: aDoorController 
	aDoorController toState: DoorOpening .! !

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

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:10:46'!
cabinDoorClosed: aController
	aController toState: DoorClosed.! !

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:32:01'!
cabinDoorClosing: aDoorController 
	aDoorController  toState: DoorClosing .! !

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:37:00'!
cabinDoorOpened: aDoorController 
	.! !

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:10:13'!
cabinDoorOpening: aDoorController 
	.! !

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

!DoorOpen methodsFor: 'as yet unclassified' stamp: 'ELR 10/7/2017 23:03:27'!
self
	self shouldBeImplemented.! !


!classDefinition: #DoorOpening category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:30:48'!
cabinDoorClose: aDoorController 
	 .! !

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 15:33:20'!
cabinDoorClosing: aDoorController 
	 .! !

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:17:55'!
cabinDoorOpened: aDoorController 
	aDoorController  toState: DoorOpen .! !

!DoorOpening methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:55:33'!
cabinDoorOpening: anElevatorController 
	.! !

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

!IdleState methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:16:03'!
idle: controller
	.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:47:00'!
isIdle
	^true.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:47:14'!
isWorking
	^false.! !

!IdleState methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:51:58'!
openCabinDoor: anElevatorController 
	anElevatorController openCabinDoorFinish .! !


!classDefinition: #WorkingState category: #'Elevator-Ejercicio'!
State subclass: #WorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!WorkingState methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 14:59:19'!
closeCabinDoor: anElevatorController
	anElevatorController closeCabinDoorCheck.
	! !

!WorkingState methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 02:34:24'!
idle: elevatorController.
	elevatorController  toState: IdleState .
	! !

!WorkingState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:45:06'!
isIdle
	^false.! !

!WorkingState methodsFor: 'as yet unclassified' stamp: 'yn 10/2/2017 18:44:28'!
isWorking
	^true.! !

!WorkingState methodsFor: 'as yet unclassified' stamp: 'ELR 10/8/2017 03:01:08'!
openCabinDoor: anElevatorController 
	anElevatorController openingCabinDoorCheck.! !
