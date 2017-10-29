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

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:20:39'!
test11CashierOnlyAcceptsValidCreditCard
	| editorial cashier creditCard cart product |
	editorial := Editorial withName: 'Yenny'.	
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	product := Object new.
	editorial add: product .
	cart add: product copies: 4.
	
	creditCard := CreditCard newExpired.
	self 
		should: [ cashier checkout: cart using: creditCard. ]
		raise: Error  
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier invalidCreditCardErrorDescription ].
		
		! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:21:35'!
test12CashierRejectsEmptyCart

	| cart  creditCard editorial cashier |
	editorial := Editorial withName: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	creditCard := CreditCard new.
	
	self 
		should: [ cashier checkout: cart using: creditCard. ]
		raise: Error  
		withExceptionDo: [ :anError | 
			self assert: anError  messageText = Cashier CashierEmptyCartErrorDescription ].! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:36:49'!
test13CheckOut

	| cart  creditCard editorial cashier numberCard owner toMonth toYear product |
	editorial := Editorial withName: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	owner := 'XXX'.
	numberCard := '1122334455'.
	toMonth :=  '11'.
	toYear := '2020'.
	creditCard := CreditCard numberCard: numberCard owner: owner withExpirationMonth:  toMonth year: toYear .
	product := Object new.
	editorial add: product .
	cart add: product copies: 4.
	"cashier checkout: cart using: creditCard. 
	Quedo hardcore del anterior test hay que verlo manana :D"
	
	! !


!classDefinition: #Cart category: #'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'editorial products size'
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

!Cart methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:14:05'!
isEmpty
	^products size = 0.! !

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

!Cashier methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:08:27'!
checkout: aCart using: aCreditCard 
	
	| cart creditCard |
	cart := aCart.
	creditCard := aCreditCard.
	
	cart isEmpty 
		ifTrue: [ ^self error: Cashier CashierEmptyCartErrorDescription  ].
		
	creditCard isExpired 
		ifTrue: [ ^self error: Cashier invalidCreditCardErrorDescription  ].! !

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

!Cashier class methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:09:34'!
CashierEmptyCartErrorDescription
	^'No es posible hacer checkout de un carrito vacio'.! !

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
	instanceVariableNames: 'toMonth toYear expiration numberCard owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:26:32'!
initExpired
	expiration := Date yesterday.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:22:47'!
isExpired
	^expiration < Date today.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:37:16'!
month: aGregorianMonth year: aGregorianYear 
	toMonth _ aGregorianMonth .
	toYear _ aGregorianYear .
	
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:30:44'!
numberCard
 ^numberCard.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:29:23'!
numberCard: aNumberCard 
	numberCard _ aNumberCard .! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:30:29'!
owner
	^owner.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:30:01'!
owner: aOwner
	owner _ aOwner .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:04:10'!
newExpired
	^ self new initExpired. ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 15:28:26'!
numberCard: aNumberCard owner: aOwner withExpirationMonth: aGregorianMonth year: aGregorianYear 
	| card |
	card _ self new.
	card month: aGregorianMonth  year: aGregorianYear .
	card numberCard: aNumberCard .
	card owner: aOwner .
	^card.
	
	! !

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
