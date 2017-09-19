!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !


!NumeroTest methodsFor: 'setup' stamp: 'HernanWilkinson 5/7/2016 20:56'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	four := Entero with: 4.
	five := Entero with: 5.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !


!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'yn 9/8/2017 17:54:01'!
* aMultiplier
 "
	(aMultiplier isKindOf: Entero) ifTrue: [^self class with: value * aMultiplier integerValue].
	(aMultiplier isKindOf: Fraccion) ifTrue: [^(self * aMultiplier numerator )/aMultiplier denominator ].
	"
	^aMultiplier multipliqueEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 10:59:59'!
+ anAdder 
	"
	Sumar sin polimorfismo
	(anAdder isKindOf: (Entero)) ifTrue: [^self class with: value + anAdder integerValue] ifFalse: [^(self * anAdder denominator + anAdder numerator) / (anAdder denominator ) ]
	"
  ^anAdder sumarEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:33:52'!
/ aDivisor 
"
No polimorfica
	(aDivisor isKindOf: Entero) ifTrue: [^Fraccion with: self over: aDivisor].
	(aDivisor isKindOf: Fraccion) ifTrue: [^(self * aDivisor denominator) / aDivisor numerator].
	
"

^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:30:11'!
divideEntero: aDividend
	
	^Fraccion with: aDividend over: self ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:57:14'!
divideFraccion: aDividend
	
	^Fraccion with: ( aDividend numerator) over: self * aDividend denominator ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:01:37'!
sumarEntero: anEntero 
	^self class with: value + anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:13:49'!
sumarFraccion: aFraccion 
	^( aFraccion denominator * self  + aFraccion numerator) / (aFraccion denominator ) ! !


!Entero methodsFor: 'as yet unclassified' stamp: 'yn 9/8/2017 17:31:31'!
multipliqueEntero: aMulti

	^self class with: value * aMulti integerValue! !

!Entero methodsFor: 'as yet unclassified' stamp: 'yn 9/8/2017 17:31:23'!
multipliqueFraccion: aMulti

	^Fraccion with:  (self * aMulti numerator ) over: aMulti denominator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'HernanWilkinson 5/7/2016 22:53'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #Denominador category: #'Numero-Exercise'!
Entero subclass: #Denominador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Denominador methodsFor: 'as yet unclassified' stamp: 'ELR 9/11/2017 19:51:03'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Denominador class' category: #'Numero-Exercise'!
Denominador class
	instanceVariableNames: ''!

!Denominador class methodsFor: 'as yet unclassified' stamp: 'ELR 9/11/2017 19:13:31'!
with: anInteger
	"comment stating purpose of message"
     anInteger = 1 ifTrue: [  self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	anInteger = 0 ifTrue: [  self error: 'No se puede dividir por cero'  ].
	^self new  initalizeWith: anInteger ! !


!classDefinition: #Numerador category: #'Numero-Exercise'!
Entero subclass: #Numerador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numerador methodsFor: 'as yet unclassified' stamp: 'ELR 9/11/2017 19:51:16'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numerador class' category: #'Numero-Exercise'!
Numerador class
	instanceVariableNames: ''!

!Numerador class methodsFor: 'as yet unclassified' stamp: 'ELR 9/11/2017 19:14:02'!
with: anInteger
     anInteger = 0 ifTrue: [  self error: 'una fraccion no puede ser cero' ].
	^self new  initalizeWith: anInteger ! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'initialization' stamp: 'ELR 9/11/2017 19:14:38'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	"aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	"
	numerator := Numerador with: aNumerator integerValue .
	denominator := Denominador with: aDenominator integerValue .
	
	"
	aNumerator beTheNumeratorOf: self withTheDenominator: aDenominator .
"! !


!Fraccion methodsFor: 'comparing' stamp: 'ELR 9/11/2017 20:18:20'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject  denominator) integerValue = (denominator * anObject numerator) integerValue ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'yn 9/8/2017 17:00:02'!
* aMultiplier 

"
	(aMultiplier isKindOf: Entero) ifTrue: [^(numerator * aMultiplier) / denominator ].
	(aMultiplier isKindOf: Fraccion) ifTrue: [^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator) ].
	"
	^aMultiplier multipliqueFraccion: self
	
	
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:15:40'!
+ anAdder 
	
	
	"
	Forma no polimorfica
	
	sumadorFraccion:=[ :aFraccion |
	newNumerator := ( numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^newNumerator / newDenominator 
	].
	
	
	sumadorEntero:=[:aEntero | 
		^( denominator * aEntero  +  numerator) / ( denominator ) 
		].
	
	(anAdder isKindOf: (Fraccion)) ifTrue:[ (sumadorFraccion value: anAdder)] ifFalse:  [ (sumadorEntero value: anAdder )]
	"
	^anAdder sumarFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:44:32'!
/ aDivisor 
	
	^aDivisor divideFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:42:54'!
divideFraccion: aFraccion 
	^(self denominator * aFraccion numerator) / (self numerator * aFraccion denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:05:01'!
sumarEntero: anEntero 
	 ^(anEntero * denominator +  numerator) /  denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ELR 9/8/2017 11:10:01'!
sumarFraccion: aFraccion 

	
	| newDenominator newNumerator |
	newNumerator := ( numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^newNumerator / newDenominator 
	! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'arithmetic operation' stamp: 'ELR 9/8/2017 11:38:36'!
divideEntero: anEntero 
	^(self denominator * anEntero)/self numerator.! !


!Fraccion methodsFor: 'as yet unclassified' stamp: 'yn 9/8/2017 17:31:49'!
multipliqueEntero: anEntero

	^(self numerator * anEntero) / self denominator ! !

!Fraccion methodsFor: 'as yet unclassified' stamp: 'yn 9/8/2017 17:31:58'!
multipliqueFraccion: aFraccion

	^(self numerator * aFraccion numerator) / (self denominator * aFraccion denominator) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'ELR 9/11/2017 20:24:30'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDividend isZero ifTrue: [ ^aDividend ].

	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !