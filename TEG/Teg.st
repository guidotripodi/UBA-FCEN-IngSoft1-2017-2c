!classDefinition: #TegTest category: #Teg!
TestCase subclass: #TegTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Teg'!

!TegTest methodsFor: 'Test1vs1' stamp: 'yn 10/26/2017 11:53:02'!
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

!TegTest methodsFor: 'Test1vs1' stamp: 'yn 10/25/2017 17:58:41'!
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

!TegTest methodsFor: 'Test1vs1' stamp: 'yn 10/25/2017 17:58:34'!
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


!TegTest methodsFor: 'Test2vs1' stamp: 'yn 10/26/2017 13:20:16'!
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

!TegTest methodsFor: 'Test2vs1' stamp: 'yn 10/26/2017 13:20:24'!
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

!TegTest methodsFor: 'Test2vs1' stamp: 'yn 10/26/2017 13:20:33'!
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


!TegTest methodsFor: 'Test3vs1' stamp: 'yn 10/26/2017 13:21:39'!
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

!TegTest methodsFor: 'Test3vs1' stamp: 'yn 10/26/2017 13:21:48'!
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

!TegTest methodsFor: 'Test3vs1' stamp: 'yn 10/26/2017 13:21:57'!
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

!TegTest methodsFor: 'Test3vs1' stamp: 'yn 10/26/2017 13:28:37'!
test22Teg1vs3GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 2.
	self assert: teg ejercitosDefensores = 2.! !

!TegTest methodsFor: 'Test3vs1' stamp: 'yn 10/26/2017 13:44:06'!
test23Teg1vs3EmpateGanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 3.
	teg juegoAtacante: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosDefensores = 3.! !

!TegTest methodsFor: 'Test3vs1' stamp: 'yn 10/26/2017 13:45:15'!
test24Teg1vs3GanaDefensor
	| teg |
	teg := Teg new.
	teg atacantes: 2.
	teg defensores: 3.
	teg juegoAtacante: 2. 
	teg juegoDefensor: 3. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 1.
	self assert: teg ejercitosDefensores = 3.! !


!TegTest methodsFor: 'Test3vs2' stamp: 'yn 10/26/2017 13:22:04'!
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

!TegTest methodsFor: 'Test3vs2' stamp: 'yn 10/26/2017 13:22:11'!
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

!TegTest methodsFor: 'Test3vs2' stamp: 'yn 10/26/2017 13:22:19'!
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

!TegTest methodsFor: 'Test3vs2' stamp: 'yn 10/26/2017 13:22:28'!
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

!TegTest methodsFor: 'Test3vs2' stamp: 'yn 10/26/2017 13:26:49'!
test21Teg2vs3GanaAtacante
	| teg |
	teg := Teg new.
	teg atacantes: 3.
	teg defensores: 3.
	teg juegoAtacante: 3. 
	teg juegoAtacante: 3.  
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2. 
	teg juegoDefensor: 2.
	teg juegoTeg.
	
	self assert: teg ejercitosAtacantes = 3.
	self assert: teg ejercitosDefensores = 1.! !


!TegTest methodsFor: 'Test3vs3' stamp: 'yn 10/26/2017 13:22:36'!
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

!TegTest methodsFor: 'Test3vs3' stamp: 'yn 10/26/2017 13:22:42'!
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

!TegTest methodsFor: 'Test3vs3' stamp: 'yn 10/26/2017 13:22:49'!
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

!TegTest methodsFor: 'Test3vs3' stamp: 'yn 10/26/2017 13:22:56'!
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

!TegTest methodsFor: 'Test3vs3' stamp: 'yn 10/26/2017 13:23:02'!
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


!TegTest methodsFor: 'Test2vs2' stamp: 'yn 10/26/2017 13:21:07'!
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

!TegTest methodsFor: 'Test2vs2' stamp: 'yn 10/26/2017 13:21:17'!
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

!TegTest methodsFor: 'Test2vs2' stamp: 'yn 10/26/2017 13:21:30'!
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


!classDefinition: #Teg category: #Teg!
Object subclass: #Teg
	instanceVariableNames: 'ejercitosAtacante ejercitosDefensor dadosAtacante dadosDefensor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Teg'!

!Teg methodsFor: 'ret' stamp: 'yn 10/25/2017 17:32:01'!
ejercitosAtacantes
	^ejercitosAtacante.
	! !

!Teg methodsFor: 'ret' stamp: 'yn 10/25/2017 17:32:16'!
ejercitosDefensores
	^ejercitosDefensor.
	! !


!Teg methodsFor: 'comparacionYremocion' stamp: 'yn 10/26/2017 13:24:23'!
compara

	| dadoAtack dadoDefense |
				dadoAtack := dadosAtacante last.
				dadoDefense := dadosDefensor last .
				dadoDefense >= dadoAtack ifTrue: [ejercitosAtacante := ejercitosAtacante  - 1 .] 
				ifFalse: [ejercitosDefensor := ejercitosDefensor  - 1.]. ! !

!Teg methodsFor: 'comparacionYremocion' stamp: 'yn 10/26/2017 13:24:29'!
remueve


	dadosAtacante  removeLast .
				dadosDefensor removeLast .
! !

!Teg methodsFor: 'comparacionYremocion' stamp: 'yn 10/26/2017 13:24:35'!
remueveYcompara

	| dadoAtack dadoDefense |
	dadosAtacante  removeLast .
				dadosDefensor removeLast .
				dadoAtack := dadosAtacante last.
				dadoDefense := dadosDefensor last .
				dadoDefense >= dadoAtack ifTrue: [ejercitosAtacante := ejercitosAtacante  - 1 .] 
				ifFalse: [ejercitosDefensor := ejercitosDefensor  - 1.]. ! !


!Teg methodsFor: 'juego' stamp: 'yn 10/26/2017 13:36:55'!
juegoAtacante: valorDado
	
	dadosAtacante add: valorDado .! !

!Teg methodsFor: 'juego' stamp: 'yn 10/26/2017 13:37:03'!
juegoDefensor: valorDado
	
	dadosDefensor add: valorDado .! !

!Teg methodsFor: 'juego' stamp: 'yn 10/26/2017 14:55:23'!
juegoTeg
	
	
	ejercitosAtacante = 2 ifTrue: [ self compara .].	

		ejercitosAtacante = 3  ifTrue: [ejercitosDefensor = 1 
		ifTrue: [ self compara .]
		ifFalse: [ 
				self compara .	
				self remueve .
				self compara . ]  ].
	
	ejercitosAtacante > 3  ifTrue: [ejercitosDefensor = 1 
		ifTrue: [ self compara .]
		ifFalse: [ ejercitosDefensor = 2 
				ifTrue: [
				self compara .	
				self remueve .
				self compara . ] ifFalse:[
				"el defensor tiene 3 ejercitos"
				self compara .
				self remueve .
				self compara . 
				self remueve .
				self compara . ]] ].
	
! !


!Teg methodsFor: 'inicializacion' stamp: 'yn 10/26/2017 13:25:11'!
atacantes: aCant
	ejercitosAtacante := aCant .
	
	! !

!Teg methodsFor: 'inicializacion' stamp: 'yn 10/26/2017 13:25:19'!
defensores: aCant
	ejercitosDefensor := aCant .
	
	! !

!Teg methodsFor: 'inicializacion' stamp: 'yn 10/26/2017 13:25:00'!
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
