!classDefinition: #TegTest category: #Teg!
TestCase subclass: #TegTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Teg'!

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 11:53:02'!
test01Teg1vs1GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoDefensor: 1. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:58:41'!
test02Teg1vs1GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 1.
	teg juegoAtacante: 3. 
	teg juegoDefensor: 5. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosAtacantes = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:58:34'!
test03Teg1vs1EmpateGanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 1.
	teg juegoAtacante: 5. 
	teg juegoDefensor: 5. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosAtacantes = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:12:05'!
test04Teg2vs1GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 1. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:12:09'!
test05Teg2vs1GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 4. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:12:12'!
test06Teg2vs1EmpateGanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 2. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:12:15'!
test07Teg2vs2GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 2.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 1. 
	teg juegoDefensor: 1. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:12:19'!
test08Teg2vs2Gana1y1
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 2.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 1. 
	teg juegoDefensor: 3. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:12:22'!
test08Teg2vs2GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 2.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 3. 
	teg juegoDefensor: 3. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosDefensores = 2.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:17:00'!
test09Teg3vs1GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 1. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 4.
	self assert: teg ejercitosDefensores = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:17:33'!
test10Teg3vs1GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 5. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:17:59'!
test11Teg3vs1EmpateGanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 2. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:19:04'!
test12Teg3vs2GanaAtaque
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 2.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 1. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 4.
	self assert: teg ejercitosDefensores = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:22:36'!
test13Teg3vs2Gana1y1
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 2.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:23:52'!
test14Teg3vs2GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 2.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 4. 
	teg juegoDefensor: 4. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 2.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:24:13'!
test15Teg3vs2EmpateGanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 2.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 2. 
	teg juegoAtacante: 2. 
	teg juegoDefensor: 3. 
	teg juegoDefensor: 2. 
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 2.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:34:15'!
test16Teg3vs3GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 4.
	self assert: teg ejercitosDefensores = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:36:12'!
test17Teg3vs3EmpateGanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoDefensor: 3. 
	teg juegoDefensor: 3. 
	teg juegoDefensor: 3.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosDefensores = 3.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:36:24'!
test18Teg3vs3Gana1y2
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 3. 
	teg juegoDefensor: 3.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 2.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:36:33'!
test19Teg3vs3Gana2y1
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 3.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:37:28'!
test20Teg3vs3GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 4.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3. 
	teg juegoDefensor: 4. 
	teg juegoDefensor: 4. 
	teg juegoDefensor: 4.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosDefensores = 3.! !


!classDefinition: #Teg category: #Teg!
Object subclass: #Teg
	instanceVariableNames: 'ejercitosAtacante ejercitosDefensor dadosAtacante dadosDefensor dado1Atacante dado1Defensor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Teg'!

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:33:12'!
atacantes: aCant
	ejercitosAtacante := aCant .
	
	! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 13:07:49'!
compara

	| dadoAtack dadoDefense |
				dadoAtack := dadosAtacante last.
				dadoDefense := dadosDefensor last .
				dadoDefense >= dadoAtack ifTrue: [ejercitosAtacante := ejercitosAtacante  - 1 .] 
				ifFalse: [ejercitosDefensor := ejercitosDefensor  - 1.]. ! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:33:25'!
defensores: aCant
	ejercitosDefensor := aCant .
	
	! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:32:01'!
ejercitosAtacantes
	^ejercitosAtacante.
	! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:32:16'!
ejercitosDefensores
	^ejercitosDefensor.
	! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 11:49:50'!
initialize
	ejercitosAtacante := 0.
	ejercitosDefensor := 0.
	dadosAtacante := 0.
	dadosDefensor := 0.
	dado1Atacante := 0.
	dado1Defensor := 0.
	dadosAtacante := SortedCollection new.
	dadosDefensor := SortedCollection new.
	! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 11:50:56'!
juegoAtacante: valorDado
	
	dadosAtacante add: valorDado .
	dado1Atacante  := valorDado .! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 11:51:12'!
juegoDefensor: valorDado
	
	dadosDefensor add: valorDado .
	dado1Defensor  := valorDado .! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 13:12:47'!
juegoTeg
	
	
	ejercitosAtacante = 2 ifTrue: [ ejercitosDefensor = 1 
		ifTrue: [self compara .] 
		ifFalse: [self compara .
				self remueve .
				self compara . ]] .

	ejercitosAtacante >= 3  ifTrue: [ejercitosDefensor = 1 ifTrue: [ejercitosDefensor = 1 
		ifTrue: [ self compara .]] 
		ifFalse: [ ejercitosDefensor = 2 
				ifTrue: [
				self compara .	
				self remueve .
				self compara . ] ifFalse:[
				self compara .
				self remueve .
				self compara . 
				self remueve .
				self compara . ]] ]

! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 13:07:35'!
remueve


	dadosAtacante  removeLast .
				dadosDefensor removeLast .
! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/26/2017 12:55:12'!
remueveYcompara

	| dadoAtack dadoDefense |
	dadosAtacante  removeLast .
				dadosDefensor removeLast .
				dadoAtack := dadosAtacante last.
				dadoDefense := dadosDefensor last .
				dadoDefense >= dadoAtack ifTrue: [ejercitosAtacante := ejercitosAtacante  - 1 .] 
				ifFalse: [ejercitosDefensor := ejercitosDefensor  - 1.]. ! !
