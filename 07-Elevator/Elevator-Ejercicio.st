!classDefinition: #EventedFloorCollection category: #'Elevator-Ejercicio'!
OrderedCollection subclass: #EventedFloorCollection
	instanceVariableNames: 'master'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!EventedFloorCollection methodsFor: 'RemoveFloor' stamp: 'yn 10/11/2017 00:11:31'!
remove: aFloor.
	super remove: aFloor . 
	self isEmpty ifTrue: master notifyEmpty.! !


!EventedFloorCollection methodsFor: 'Error' stamp: 'yn 10/11/2017 00:36:17'!
errorNotFound: anObject

	 CabinSensorEmergency signal .! !


!EventedFloorCollection methodsFor: 'create' stamp: 'yn 10/11/2017 00:13:00'!
for: aController
	master := aController .! !

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

!ElevatorEmergency methodsFor: 'MessageError' stamp: 'ELR 10/8/2017 23:45:30'!
messageText
	^'Sensor de cabina desincronizado'.! !


!classDefinition: #CabinSensorEmergency category: #'Elevator-Ejercicio'!
ElevatorEmergency subclass: #CabinSensorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinSensorEmergency methodsFor: 'MessageError' stamp: 'ELR 10/8/2017 20:44:47'!
messageText
	^'Sensor de cabina desincronizado'! !


!classDefinition: #DoorSensorEmergency category: #'Elevator-Ejercicio'!
ElevatorEmergency subclass: #DoorSensorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorSensorEmergency methodsFor: 'MessageError' stamp: 'ELR 10/8/2017 20:44:17'!
messageText
	^'Sensor de puerta desincronizado'! !


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

!CabinMoving methodsFor: 'DoorState' stamp: 'yn 10/2/2017 20:54:45'!
doorOpen: aElevatorController

	.! !

!CabinMoving methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:41:46'!
doorOpening: aCabinController 
	.! !


!CabinMoving methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:30:53'!
notifyEmpty: aCabinController 
	"If the cabin is Mooving nothing can happen until it stops"! !


!CabinMoving methodsFor: 'State' stamp: 'yn 10/11/2017 00:31:52'!
isMoving
		^true .! !

!CabinMoving methodsFor: 'State' stamp: 'yn 10/11/2017 00:31:23'!
isStopped
		^false .! !

!CabinMoving methodsFor: 'State' stamp: 'yn 10/11/2017 00:31:58'!
moving: aCabinController 
	.! !

!CabinMoving methodsFor: 'State' stamp: 'yn 10/11/2017 00:31:41'!
stopped: aCabinController 
	aCabinController toState: CabinStopped .! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'DoorState' stamp: 'yn 10/2/2017 20:53:52'!
doorOpen: aElevatorController
	self subclassResponsibility.! !

!CabinState methodsFor: 'DoorState' stamp: 'yn 10/2/2017 19:19:07'!
isMoving
		self subclassResponsibility .! !

!CabinState methodsFor: 'DoorState' stamp: 'yn 10/2/2017 19:19:16'!
isStopped
		self subclassResponsibility .! !


!classDefinition: #CabinStopped category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStopped methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:24:52'!
doorOpen: aElevatorController
 aElevatorController doorOpenedFinish.! !

!CabinStopped methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:44:55'!
doorOpening: aCabinController 
	aCabinController doorOpeningFinish .! !


!CabinStopped methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:29:21'!
notifyEmpty: aCabinController 
	aCabinController notifyStoppedAndNoMoreFloors.! !


!CabinStopped methodsFor: 'State' stamp: 'yn 10/11/2017 00:29:40'!
isMoving
^false.! !

!CabinStopped methodsFor: 'State' stamp: 'yn 10/11/2017 00:29:47'!
isStopped
^true.! !

!CabinStopped methodsFor: 'State' stamp: 'yn 10/11/2017 00:29:59'!
moving: aCabinController 
	aCabinController toState: CabinMoving .! !

!CabinStopped methodsFor: 'State' stamp: 'yn 10/11/2017 00:29:52'!
stopped: aCabinController 
	.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinStopped class' category: #'Elevator-Ejercicio'!
CabinStopped class
	instanceVariableNames: ''!

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 03:29:14'!
doorOpen: aCabinController 
	aCabinController doorOpenedFinish .! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 03:37:44'!
doorOpening: aCabinController 
	aCabinController doorOpeningFinish.! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 01:04:09'!
isMoving
	^false.! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 03:54:10'!
isStopped
	^true.! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 00:57:31'!
isStopped: aCabinController 
	^true.! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 01:09:08'!
moving
	self shouldBeImplemented.! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 01:12:37'!
moving: aCabinController 
	aCabinController toState: CabinMoving .! !

!CabinStopped class methodsFor: 'State' stamp: 'ELR 10/8/2017 02:42:33'!
openCabinDoor: aCabinController 
	aCabinController openCabinDoorFinish.! !


!classDefinition: #Moving category: #'Elevator-Ejercicio'!
CabinState subclass: #Moving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Moving methodsFor: 'State' stamp: 'yn 10/2/2017 19:21:37'!
isMoving
^true.! !

!Moving methodsFor: 'State' stamp: 'yn 10/2/2017 19:21:50'!
isStopped
^false.! !


!classDefinition: #Controller category: #'Elevator-Ejercicio'!
Object subclass: #Controller
	instanceVariableNames: 'state masterController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!Controller methodsFor: 'State' stamp: 'ELR 10/8/2017 10:32:16'!
for: aMasterController
	masterController := aMasterController .
	! !

!Controller methodsFor: 'State' stamp: 'ELR 10/7/2017 23:16:07'!
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

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 23:52:56'!
doorClosed
	floorController notifyDoorClosedRequest .
	doorController cabinDoorClosed .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 14:35:08'!
doorClosing
	doorController cabinDoorClosing .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:21:22'!
doorOpened
	state doorOpen: self.! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:25:40'!
doorOpenedFinish
	doorController cabinDoorOpened .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:37:02'!
doorOpening
	state doorOpening: self.! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:38:19'!
doorOpeningFinish
	doorController cabinDoorOpening .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 14:38:31'!
initialize
	state := CabinStopped new .
	floorController := FloorController for: self.
	doorController := DoorController for: self.! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:16:42'!
isDoorClose
	^doorController isClose .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:16:19'!
isDoorClosing
	^doorController isClosing .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:12:22'!
isDoorOpen
	^doorController isOpen .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 03:15:56'!
isDoorOpening
	^doorController isOpening .! !

!CabinController methodsFor: 'DoorState' stamp: 'ELR 10/8/2017 22:52:06'!
onFloor: aFloorNumber 
	state stopped: self.
	floorController onFloor: aFloorNumber .
	doorController cabinDoorOpening .
	! !


!CabinController methodsFor: 'accessing' stamp: 'ELR 10/8/2017 01:39:22'!
floorNumber
	^floorController floorNumber .! !

!CabinController methodsFor: 'accessing' stamp: 'ELR 10/8/2017 03:15:12'!
goUpPushedFromFloor: aFloorNumber
	floorController goUpPushedFromFloor: aFloorNumber.
	doorController cabinDoorClosing.! !

!CabinController methodsFor: 'accessing' stamp: 'yn 10/11/2017 00:34:22'!
moving
	state moving: self.! !


!CabinController methodsFor: 'State' stamp: 'yn 10/11/2017 00:32:51'!
isMoving
	^state isMoving.! !

!CabinController methodsFor: 'State' stamp: 'yn 10/11/2017 00:33:00'!
isStopped
	^state isStopped.! !

!CabinController methodsFor: 'State' stamp: 'yn 10/11/2017 00:33:12'!
stopped
	state stopped: self.! !


!CabinController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:33:20'!
notifyDoorOpened
	floorController notifyDoorOpened.! !

!CabinController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:33:25'!
notifyEmpty
	state notifyEmpty: self.
	! !

!CabinController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:33:32'!
notifyNoMoreFloorsAndDoorsOpened.
	masterController notifyNoMoreFloorsAndDoorsOpened.! !

!CabinController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:33:44'!
notifyStoppedAndNoMoreFloors
	doorController cabinDoorOpening .
	masterController notifyStoppedAndNoMoreFloors.! !


!classDefinition: #DoorController category: #'Elevator-Ejercicio'!
Controller subclass: #DoorController
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/7/2017 23:16:54'!
cabinDoorClosed
	state cabinDoorClosed: self.! !

!DoorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 15:06:06'!
cabinDoorClosing
	state cabinDoorClosing: self.! !

!DoorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 23:33:11'!
cabinDoorOpened
	state cabinDoorOpened: self.
	masterController notifyDoorOpened.! !

!DoorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 02:09:17'!
cabinDoorOpening
     state cabinDoorOpening: self.! !


!DoorController methodsFor: 'initialize' stamp: 'ELR 10/7/2017 22:44:02'!
initialize
	state:= DoorOpen new.! !


!DoorController methodsFor: 'State' stamp: 'yn 10/11/2017 00:26:13'!
isClose
	^state isClose.! !

!DoorController methodsFor: 'State' stamp: 'yn 10/11/2017 00:26:20'!
isClosing
	^state isClosing.! !

!DoorController methodsFor: 'State' stamp: 'yn 10/11/2017 00:26:26'!
isOpen
	^state isOpen.! !

!DoorController methodsFor: 'State' stamp: 'yn 10/11/2017 00:26:31'!
isOpening
	^state isOpening.! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Controller subclass: #ElevatorController
	instanceVariableNames: 'cabinController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 21:52:29'!
cabinDoorClosed
	cabinController doorClosed .
	cabinController  moving.
	
	! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:06:21'!
cabinDoorClosing
	cabinController doorClosing.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 15:04:22'!
cabinDoorOpen
     cabinController doorOpened .
	state idle: self.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 22:31:40'!
cabinDoorOpened
	
	cabinController stopped.
	cabinController doorOpened .
! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 00:46:41'!
cabinFloorNumber
 ^cabinController floorNumber.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 14:15:24'!
cabinOnFloor: floor
     cabinController onFloor: floor.
     
! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'yn 10/11/2017 00:35:41'!
closeCabinDoor
	
	state closeCabinDoor: self.

	

! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 15:03:21'!
closeCabinDoorCheck
	cabinController doorClosing .! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:15:01'!
goUpPushedFromFloor: aInteger
	cabinController goUpPushedFromFloor: aInteger.
	state _ WorkingState new.
	
! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 10:34:07'!
initialize
	state _ IdleState new.
	cabinController _ CabinController for: self.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:09:27'!
isCabinDoorClosed
	^cabinController isDoorClose.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:09:42'!
isCabinDoorClosing
	^cabinController isDoorClosing.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:09:55'!
isCabinDoorOpened
	^cabinController isDoorOpen.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:10:08'!
isCabinDoorOpening
 	^cabinController isDoorOpening.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 01:03:27'!
isCabinMoving
	^cabinController isMoving .! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 00:52:19'!
isCabinStopped
	^cabinController isStopped .! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'yn 10/2/2017 20:15:07'!
isCabinWaitingForPeople
^true.

! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'yn 10/11/2017 00:35:51'!
openCabinDoor
	state openCabinDoor: self.
		! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:26:43'!
openCabinDoorFinish
	cabinController doorOpened.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:36:18'!
openingCabinDoorCheck
	cabinController doorOpening.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:11:11'!
openingCabinDoorFinish
	cabinController openingDoor.! !

!ElevatorController methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 14:33:10'!
waitForPeopleTimedOut
	
	state := WorkingState new.
	cabinController stopped.
	cabinController doorClosing .! !


!ElevatorController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:20:42'!
notifyEmpty
	state idle: self.! !

!ElevatorController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:20:52'!
notifyNoMoreFloorsAndDoorsOpened.
	state notifyNoMoreFloorsAndDoorsOpened: self.! !

!ElevatorController methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:21:01'!
notifyStoppedAndNoMoreFloors
	state notifyStoppedAndNoMoreFloors: self.! !


!ElevatorController methodsFor: 'State' stamp: 'yn 10/11/2017 00:21:40'!
isIdle
	^state isIdle .! !

!ElevatorController methodsFor: 'State' stamp: 'yn 10/11/2017 00:21:48'!
isWorking
  	^state isWorking .! !


!classDefinition: #FloorController category: #'Elevator-Ejercicio'!
Controller subclass: #FloorController
	instanceVariableNames: 'floorsToGo floor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!FloorController methodsFor: 'Notify' stamp: 'ELR 10/8/2017 01:43:44'!
floorNumber
	^floor ! !

!FloorController methodsFor: 'Notify' stamp: 'ELR 10/8/2017 20:35:35'!
goUpPushedFromFloor: aFloorNumber 
	
	floor to: aFloorNumber do:[:passingFloor | floorsToGo add: passingFloor] .
	floorsToGo remove: floor.! !

!FloorController methodsFor: 'Notify' stamp: 'ELR 10/8/2017 23:53:38'!
notifyDoorClosedRequest
	floorsToGo isEmpty ifTrue: [ DoorSensorEmergency signal ].! !

!FloorController methodsFor: 'Notify' stamp: 'ELR 10/8/2017 23:36:28'!
notifyDoorOpened.
	floorsToGo isEmpty ifTrue: [masterController notifyNoMoreFloorsAndDoorsOpened].! !

!FloorController methodsFor: 'Notify' stamp: 'ELR 10/8/2017 11:04:50'!
notifyEmpty
	masterController notifyEmpty.! !


!FloorController methodsFor: 'accessing' stamp: 'yn 10/11/2017 00:09:28'!
onFloor: aFloorNumber 
    
	((floor = (aFloorNumber -1) ) or: (floor = (aFloorNumber +1) )) ifFalse: [CabinSensorEmergency signal].
	floorsToGo remove: aFloorNumber .
	floor:=aFloorNumber .! !


!FloorController methodsFor: 'initialize' stamp: 'yn 10/11/2017 00:19:31'!
initialize
	floor _ 0.
	floorsToGo _ EventedFloorCollection for: self.! !


!classDefinition: #DoorState category: #'Elevator-Ejercicio'!
Object subclass: #DoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorState methodsFor: 'StateDoor' stamp: 'ELR 10/7/2017 21:22:05'!
closeCabinDoor: aElevatorController
	self subclassResponsibility .
! !

!DoorState methodsFor: 'StateDoor' stamp: 'yn 10/2/2017 19:31:07'!
isClose
	^self subclassResponsibility.! !

!DoorState methodsFor: 'StateDoor' stamp: 'yn 10/2/2017 19:31:19'!
isClosing
	^self subclassResponsibility.! !

!DoorState methodsFor: 'StateDoor' stamp: 'yn 10/2/2017 19:31:29'!
isOpen
	^self subclassResponsibility.! !

!DoorState methodsFor: 'StateDoor' stamp: 'yn 10/2/2017 19:31:45'!
isOpening
	^self subclassResponsibility.! !


!classDefinition: #DoorClosed category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorClosed methodsFor: 'CabinDoorState' stamp: 'ELR 10/8/2017 23:56:12'!
cabinDoorClosed: aDoorController 
	DoorSensorEmergency signal.! !

!DoorClosed methodsFor: 'CabinDoorState' stamp: 'ELR 10/8/2017 15:10:25'!
cabinDoorClosing: aDoorController 
	 .! !

!DoorClosed methodsFor: 'CabinDoorState' stamp: 'ELR 10/7/2017 23:33:54'!
cabinDoorOpened: aController
	aController toState: DoorOpen .! !

!DoorClosed methodsFor: 'CabinDoorState' stamp: 'ELR 10/8/2017 02:14:12'!
cabinDoorOpening: aDoorController 
	aDoorController toState: DoorOpening .! !

!DoorClosed methodsFor: 'CabinDoorState' stamp: 'ELR 10/7/2017 21:25:28'!
closeCabinDoor: anElevatorController 
	.! !

!DoorClosed methodsFor: 'CabinDoorState' stamp: 'ELR 10/8/2017 02:58:52'!
openingCabinDoor: aDoorController 
	aDoorController toState: DoorOpening .! !


!DoorClosed methodsFor: 'State' stamp: 'yn 10/11/2017 00:28:27'!
isClose
^true.! !

!DoorClosed methodsFor: 'State' stamp: 'yn 10/11/2017 00:28:35'!
isClosing
^false.! !

!DoorClosed methodsFor: 'State' stamp: 'yn 10/11/2017 00:28:40'!
isOpen
^false.! !

!DoorClosed methodsFor: 'State' stamp: 'yn 10/11/2017 00:28:46'!
isOpening
^false.! !


!classDefinition: #DoorClosing category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorClosing methodsFor: 'DoorCabinState' stamp: 'ELR 10/7/2017 23:32:37'!
cabinDoorClosed: aDoorController 
	aDoorController toState: DoorClosed .! !

!DoorClosing methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 20:47:29'!
cabinDoorClosing: aDoorController 
	.! !

!DoorClosing methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:33:39'!
cabinDoorOpened: aDoorController 
	aDoorController  toState: DoorOpen .! !

!DoorClosing methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:40:07'!
cabinDoorOpening: aDoorController 
	aDoorController toState: DoorOpening .! !


!DoorClosing methodsFor: 'State' stamp: 'yn 10/11/2017 00:27:12'!
isClose
^false.! !

!DoorClosing methodsFor: 'State' stamp: 'yn 10/11/2017 00:27:25'!
isClosing
^true.! !

!DoorClosing methodsFor: 'State' stamp: 'yn 10/11/2017 00:27:18'!
isOpen
^false.! !

!DoorClosing methodsFor: 'State' stamp: 'yn 10/11/2017 00:27:32'!
isOpening
^false.! !


!classDefinition: #DoorOpen category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorOpen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorOpen methodsFor: 'DoorCabinState' stamp: 'ELR 10/7/2017 23:10:46'!
cabinDoorClosed: aController
	aController toState: DoorClosed.! !

!DoorOpen methodsFor: 'DoorCabinState' stamp: 'ELR 10/7/2017 23:32:01'!
cabinDoorClosing: aDoorController 
	aDoorController  toState: DoorClosing .! !

!DoorOpen methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 02:37:00'!
cabinDoorOpened: aDoorController 
	.! !

!DoorOpen methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 02:10:13'!
cabinDoorOpening: aDoorController 
	.! !


!DoorOpen methodsFor: 'State' stamp: 'yn 10/11/2017 00:24:48'!
isClose
^false.! !

!DoorOpen methodsFor: 'State' stamp: 'yn 10/11/2017 00:24:55'!
isClosing
^false.! !

!DoorOpen methodsFor: 'State' stamp: 'yn 10/11/2017 00:25:04'!
isOpen
^true.! !

!DoorOpen methodsFor: 'State' stamp: 'yn 10/11/2017 00:25:10'!
isOpening
^false.! !


!classDefinition: #DoorOpening category: #'Elevator-Ejercicio'!
DoorState subclass: #DoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!DoorOpening methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 15:30:48'!
cabinDoorClose: aDoorController 
	 .! !

!DoorOpening methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 15:33:20'!
cabinDoorClosing: aDoorController 
	 .! !

!DoorOpening methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 02:17:55'!
cabinDoorOpened: aDoorController 
	aDoorController  toState: DoorOpen .! !

!DoorOpening methodsFor: 'DoorCabinState' stamp: 'ELR 10/8/2017 03:55:33'!
cabinDoorOpening: anElevatorController 
	.! !


!DoorOpening methodsFor: 'State' stamp: 'yn 10/11/2017 00:23:35'!
isClose
	^false.! !

!DoorOpening methodsFor: 'State' stamp: 'yn 10/11/2017 00:23:42'!
isClosing
	^false.! !

!DoorOpening methodsFor: 'State' stamp: 'yn 10/11/2017 00:23:55'!
isOpen
	^false.! !

!DoorOpening methodsFor: 'State' stamp: 'yn 10/11/2017 00:23:48'!
isOpening
	^true.! !


!classDefinition: #State category: #'Elevator-Ejercicio'!
Object subclass: #State
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!State methodsFor: 'State' stamp: 'yn 10/2/2017 18:42:27'!
isIdle
		self subclassResponsibility .! !

!State methodsFor: 'State' stamp: 'yn 10/2/2017 18:42:44'!
isWorking
		self subclassResponsibility .! !


!classDefinition: #IdleState category: #'Elevator-Ejercicio'!
State subclass: #IdleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!IdleState methodsFor: 'CabinDoor' stamp: 'ELR 10/8/2017 23:30:46'!
closeCabinDoor: aElevatorController
	.! !

!IdleState methodsFor: 'CabinDoor' stamp: 'ELR 10/8/2017 02:51:58'!
openCabinDoor: anElevatorController 
	anElevatorController openCabinDoorFinish .! !


!IdleState methodsFor: 'State' stamp: 'yn 10/11/2017 00:17:14'!
idle: controller
	.! !

!IdleState methodsFor: 'State' stamp: 'yn 10/11/2017 00:17:23'!
isIdle
	^true.! !

!IdleState methodsFor: 'State' stamp: 'yn 10/11/2017 00:17:35'!
isWorking
	^false.! !


!IdleState methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:36:34'!
notifyNoMoreFloorsAndDoorsOpened: anElevatorController 
! !

!IdleState methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:36:41'!
notifyStoppedAndNoMoreFloors: anElevatorController 
	anElevatorController toState: WorkingState .! !


!classDefinition: #WorkingState category: #'Elevator-Ejercicio'!
State subclass: #WorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!WorkingState methodsFor: 'State' stamp: 'yn 10/11/2017 00:14:04'!
idle: elevatorController.
	elevatorController  toState: IdleState .
	! !

!WorkingState methodsFor: 'State' stamp: 'yn 10/11/2017 00:13:49'!
isIdle
	^false.! !

!WorkingState methodsFor: 'State' stamp: 'yn 10/11/2017 00:13:57'!
isWorking
	^true.! !


!WorkingState methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:14:23'!
notifyNoMoreFloorsAndDoorsOpened: aController
	aController toState: IdleState .
	! !

!WorkingState methodsFor: 'Notify' stamp: 'yn 10/11/2017 00:36:59'!
notifyStoppedAndNoMoreFloors: anElevatorController 
! !


!WorkingState methodsFor: 'CabinDoor' stamp: 'yn 10/11/2017 00:15:13'!
closeCabinDoor: anElevatorController
	anElevatorController closeCabinDoorCheck.
	! !

!WorkingState methodsFor: 'CabinDoor' stamp: 'yn 10/11/2017 00:15:20'!
openCabinDoor: anElevatorController 
	anElevatorController openingCabinDoorCheck.! !
