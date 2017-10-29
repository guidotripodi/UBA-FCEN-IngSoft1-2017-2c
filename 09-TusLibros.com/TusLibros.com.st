!classDefinition: #TestTusLibrosCom category: #'TusLibros.com'!
TestCase subclass: #TestTusLibrosCom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 17:52:27'!
test01CanCreateACartFromAnEditorial
	| cart |
	cart:= Cart fromEditorial: 'Yenny'.
	self assert: cart editorial = 'Yenny'.! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 17:57:38'!
test02CanCreateAEmptyCart
	| cart |
	cart:= Cart fromEditorial: 'Yenny'.
	self assert: cart isEmpty.! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:08:19'!
test03EditorialsHasNames
	
	| editorial |
	editorial := Editorial withName: 'Yenny'.
	self assert: editorial name = 'Yenny'.! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:12:45'!
test04EditorialHasProducts
	| editorial product |
	editorial := Editorial withName: 'Yenny'.
	product := Object new.
	editorial add: product.
	
	self assert: [editorial includes: product].! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:17:43'!
test05CanAddValidEditorialsProductToCart
	| cart product editorial |
	editorial := Editorial withName: 'Yenny'.
	cart:= Cart fromEditorial: editorial.
	product := Object new.
	editorial add: product.
	cart add: product.
	self assert: [cart includes: product ].
	
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:32:19'!
test06CantAddNonEditorialsProductsToCartEditorialCart
	| cart product editorial |
	editorial _ Editorial withName: 'Yenny'.
	cart _ Cart fromEditorial: editorial.
	product _ Object new.
		
	self
		should: [ cart add: product ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidProductErrorDescription ]
	
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:37:16'!
test07CanAddSeveralValidEditorialsProductToCart
	| cart product editorial |
	editorial := Editorial withName: 'Yenny'.
	cart:= Cart fromEditorial: editorial.
	product := Object new.
	editorial add: product .
	cart add: product copies: 4.
	self assert: [cart includes: product ].
	self assert: (cart stockOf: product ) = 4 .
	
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:50:41'!
test08AllSellingEditorialProductsHaveAPriceAsociated
	| product editorial |
	editorial := Editorial withName: 'Yenny'.
	product := Object new.
	editorial add: product withPrice: 5 .
	
	self assert: [(editorial priceFor: product) = 5].
	
	
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:03:57'!
test09EditorialHasCashiers
	| editorial cashier |
	editorial := Editorial withName: 'Yenny'.	
	cashier := Cashier from: editorial.
	editorial employ: cashier.
	self assert: [editorial employs: cashier].
	
	
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:11:37'!
test10EditorialCashiersCanCalculatePurchasePrice
	| editorial cashier cart product |
	editorial := Editorial withName: 'Yenny'.	
	cashier := Cashier from: editorial.
	editorial employ: cashier.
	
	cart:= Cart fromEditorial: editorial.
	product := Object new.
	editorial add: product withPrice: 5 .
	cart add: product copies: 4.
	
	self assert: (cashier assess: cart ) = 20.
	
	
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:33:37'!
test11CashierOnlyAcceptsValidCreditCard
	| editorial cashier card toMonth toYear |
	editorial := Editorial withName: 'Yenny'.	
	cashier := Cashier from: editorial.

	toMonth:= GregorianMonth new.
	toYear:= GregorianYear  new.
	
	card := CreditCard withExpirationMonth: toMonth year: toYear .

	
	
	self
		should: [ cashier useCreditCard: card]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier invalidCreditCardErrorDescription ]
	
	
	
	! !


!classDefinition: #Cart category: #'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'editorial products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:31:53'!
add: aProduct 
	(editorial includes: aProduct) ifFalse: [^self error: Cart invalidProductErrorDescription ].
	products add: aProduct.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:36:28'!
add: aProduct copies: aCuantity 
	aCuantity timesRepeat: [self add: aProduct] .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 17:55:09'!
editorial
	^editorial.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 17:54:07'!
editorial: editorialName 
	editorial _ editorialName.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:19:41'!
includes: aProduct 
	^products  includes: aProduct .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:19:07'!
initialize
	products := OrderedCollection new .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 17:58:04'!
isEmpty
	^true.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:23:59'!
products
	^products! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:38:39'!
stockOf: aProduct 
	^products occurrencesOf: aProduct ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 17:54:41'!
fromEditorial: anEditorialName 
	| aNewCart |
	aNewCart _ self new.
	aNewCart editorial: anEditorialName .
	^aNewCart .! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:29:53'!
invalidProductErrorDescription
	^'Producto no perteneciente a la editorial'.! !


!classDefinition: #Cashier category: #'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:24:52'!
assess: aCart 
	| bill |
	bill := 0.00 .
	aCart products do:[:each | bill:= bill + (editorial priceFor: each)].
	^bill.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:02:44'!
editorial: anEditorial 
	editorial _ anEditorial .! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:44:26'!
useCreditCard: card
	| monthNow yearNow |
	yearNow := GregorianYear new.
	monthNow := GregorianMonth new.
	
	card year >= yearNow ifTrue: [ card year = yearNow ifTrue: [card month < monthNow ifTrue: [self error: Cashier invalidCreditCardErrorDescription ]] ] ifFalse: [self error: Cashier invalidCreditCardErrorDescription ] 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:02:24'!
from: anEditorial 
	| cashier |
	cashier _ self new.
	cashier editorial: anEditorial.
	^cashier.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:37:55'!
invalidCreditCardErrorDescription
	^'Tarjeta vencida pa'.! !


!classDefinition: #CreditCard category: #'TusLibros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'toMonth toYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:37:16'!
month: aGregorianMonth year: aGregorianYear 
	toMonth _ aGregorianMonth .
	toYear _ aGregorianYear .
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:35:38'!
withExpirationMonth: aGregorianMonth year: aGregorianYear 
	| card |
	card _ self new.
	card month: aGregorianMonth  year: aGregorianYear .
	^card.
	
	! !


!classDefinition: #Editorial category: #'TusLibros.com'!
Object subclass: #Editorial
	instanceVariableNames: 'name products catalog cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:13:36'!
add: anProduct
	products add: anProduct.
	! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:15:22'!
add: aProduct withPrice: aPrice 
	self add: aProduct .
	catalog at: aProduct put: aPrice.! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:06:48'!
employ: aCashier 
	cashier _ aCashier.! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:06:27'!
employs: aCashier 
	^cashier = aCashier .! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:15:48'!
includes: aProduct 
	^products includes: aProduct .! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:05:33'!
initialize
	products := OrderedCollection new.
	catalog := Dictionary new.

	! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:10:54'!
name
	^name.! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:10:17'!
name: aName
	name _ aName .! !

!Editorial methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:54:45'!
priceFor: aProduct
	^catalog at: aProduct .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Editorial class' category: #'TusLibros.com'!
Editorial class
	instanceVariableNames: ''!

!Editorial class methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 18:09:11'!
withName: aName 
	| editorial |
	editorial _ self new.
	editorial name: aName .
	^editorial.! !
