!classDefinition: #TegTest category: #Teg!
TestCase subclass: #TegTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Teg'!

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:18:53'!
test01Teg1vs1GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 1.
	teg juegoAtacante: 2. 
	teg juegoDefensor: 1. 
	
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosAtacantes = 0.! !

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

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:01:57'!
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
	self assert: teg ejercitosAtacantes = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:02:06'!
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
	self assert: teg ejercitosAtacantes = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:02:17'!
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
	self assert: teg ejercitosAtacantes = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:02:56'!
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
	self assert: teg ejercitosAtacantes = 0.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:04:00'!
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
	self assert: teg ejercitosAtacantes = 1.! !

!TegTest methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:04:30'!
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
	self assert: teg ejercitosAtacantes = 2.! !


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

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 18:12:11'!
initialize

	dadosAtacante := SortedCollection new.
	dadosDefensor := SortedCollection new.
	! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:38:55'!
juegoAtacante: valorDado
	
	dadosAtacante add: valorDado .! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 17:39:10'!
juegoDefensor: valorDado
	
	dadosDefensor add: valorDado .! !

!Teg methodsFor: 'as yet unclassified' stamp: 'yn 10/25/2017 20:53:14'!
juegoTeg

	| dadoAtack dadoDefense |
	dadoAtack := dado1Atacante.
	dadoDefense := dado1Defensor .
	dadoDefense >= dadoAtack ifTrue: [ejercitosAtacante - 1 ] ifFalse: [ejercitosDefensor - 1]. 
	! !
