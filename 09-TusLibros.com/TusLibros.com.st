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

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 18:37:21'!
test11CashierOnlyAcceptsValidCreditCard
	| editorial cashier creditCard cart product aMonthOfYear |
	editorial := Editorial withName: 'Yenny'.	
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	product := Object new.
	editorial add: product .
	cart add: product copies: 4.
	aMonthOfYear := GregorianMonthOfYear  current previous .
	creditCard := CreditCard withExpiration: aMonthOfYear.
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

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 22:03:03'!
test13ListItemsCart
	| aCatalog editorial aCart listItems product product2 |
	editorial _ Editorial withName: 'Yenny'.
	aCatalog _ OrderedCollection new.
	aCart _ Cart fromEditorial: editorial.
	product := 4356.
	product2  := 8741.
	editorial add: product withPrice: 5 .
	editorial add: product2 withPrice: 1 .
	aCatalog add: product.
	aCatalog add: product2.
	aCart add: product copies: 2.
	aCart add: product2 copies: 6.
	aCart add: product copies: 3.
	
	listItems := aCart listItemsWithQuantities.
	self deny: listItems isEmpty.
	self assert:  [listItems includes: {product.5}].
	self assert:  [listItems includes: {product2.6}].
	

! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 18:23:17'!
test14CashierCalculatesTotal

	| cart editorialCatalogue cashier editorial product product2 |
	editorial _ Editorial withName: 'Yenny'.
	editorialCatalogue := Dictionary new.

	product := 4356.
	product2 := 1234.
	editorial add: product withPrice: 420 .
	editorial add: product2 withPrice: 2 .
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	cart add: product copies: 3.
	cart add: product2 copies: 3.
	self assert: (cashier assess: cart) = 1266.
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 20:09:48'!
test15CheckOutWithNonExpiredCreditCard

	| cart  creditCard editorial cashier product product2 |
	editorial := Editorial withName: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	product := 4356.
	product2 := 1234.
	editorial add: product withPrice: 420 .
	editorial add: product2 withPrice: 2 .
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	cart add: product copies: 3.
	cart add: product2 copies: 3.
	self assert: (cashier checkout: cart using: creditCard) = 1266.! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:04:38'!
test16DebitStringInterfaceToCorrect

	| cart  creditCard editorial cashier product product2 total convertToString aDate stringDate |
	editorial := Editorial withName: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	aDate := GregorianMonthOfYear  current.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  aDate.
	stringDate := aDate monthNumber printString, aDate year number printString.
	product := 4356.
	product2 := 1234.
	editorial add: product withPrice: 420 .
	editorial add: product2 withPrice: 2 .
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	cart add: product copies: 3.
	cart add: product2 copies: 3.
	total := cashier checkout: cart using: creditCard.
	convertToString := '?creditCardNumber=','1122334455','&','creditCardExpiration=',stringDate ,'&','creditCardOwner=XXX', '&','transactionAmount=',total printString.
	
	self assert: [(cashier generateTransactionMessage: total with: creditCard ) = convertToString ].! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:20:37'!
test17CreditCardOutOfFoundsProducesError

	| cart  creditCard editorial cashier product product2 total convertToString aDate stringDate mp |
	editorial := Editorial withName: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	aDate := GregorianMonthOfYear  current.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  aDate.
	stringDate := aDate monthNumber printString, aDate year number printString.
	product := 4356.
	product2 := 1234.
	editorial add: product withPrice: 420 .
	editorial add: product2 withPrice: 2 .
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	cart add: product copies: 3.
	cart add: product2 copies: 3.
	total := cashier checkout: cart using: creditCard.
	convertToString := '?creditCardNumber=','1122334455','&','creditCardExpiration=',stringDate ,'&','creditCardOwner=XXX', '&','transactionAmount=',total printString.
	
	mp := MPProcesorSimulator new.
	mp addAsCardOutOfFounds: creditCard .
	
	self 
		should: [ mp debitOperation: total with: creditCard . ]
		raise: Error  
		withExceptionDo: [ :anError | 
			self assert: anError  messageText = MPProcesorSimulator creditCardOutOfFoundsErrorDescription ].
	! !

!TestTusLibrosCom methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 23:05:13'!
test18CreditCardInvalidProducesError

	| cart  creditCard editorial cashier product product2 total convertToString aDate stringDate mp |
	editorial := Editorial withName: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	aDate := GregorianMonthOfYear  current.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  aDate.
	stringDate := aDate monthNumber printString, aDate year number printString.
	product := 4356.
	product2 := 1234.
	editorial add: product withPrice: 420 .
	editorial add: product2 withPrice: 2 .
	cashier := Cashier from: editorial.
	cart := Cart fromEditorial: editorial .
	cart add: product copies: 3.
	cart add: product2 copies: 3.
	total := cashier checkout: cart using: creditCard.
	convertToString := 'creditCardNumber=','1122334455','&','creditCardExpiration=',stringDate ,'&','creditCardOwner=XXX', '&','transactionAmount=',total printString.
	
	mp := MPProcesorSimulator new.
	mp addAs: creditCard .
	self 
		should: [ mp debitOperation: total with: creditCard .  ]
		raise: Error  
		withExceptionDo: [ :anError | 
			self assert: anError  messageText = MPProcesorSimulator creditCardInvalidFoundsErrorDescription ].
	! !


!classDefinition: #TestXXX category: #'TusLibros.com'!
TestCase subclass: #TestXXX
	instanceVariableNames: 'editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:35:16'!
SigninUserStore: anStore clientId: anUser pass: aPass
	
	
	anStore createUser: anUser pass: aPass.
	anStore signIn: anUser password: aPass.
	^anUser 
	! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:19:03'!
StoreAndEditorial
	|  store |
	editorial := Editorial withName: 'Yenny'.
	
	store:= Store from: editorial.
	^store
! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:21:18'!
productExistsFromEditorial: aISBNProduct 
	editorial add: aISBNProduct .
	^aISBNProduct .! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:31:25'!
productExistsFromEditorial: aISBNProduc withPrice: aPrice 
	editorial add: aISBNProduc withPrice: aPrice .
	^aISBNProduc .
	! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:08:33'!
test01CartCantBeCreatedByInvalidPass
	| store user |
	store _ self StoreAndEditorial.
	
	user := 'hola'.
	
self 
		should: [ store signIn: 'hola' password: 'pepito']
		raise: Error  
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidUserErrorMessage. 
			self deny: (store hasCartFrom: user)].
		! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:08:53'!
test02CartCantBeCreatedByUserWithInvalidPass
	| store user |
	store _ self StoreAndEditorial.
	
	store createUser: 'hola' pass: 'chau'.
	
self 
		should: [ store signIn: 'hola' password: 'pepito']
		raise: Error  
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidPassErrorMessage. 
			self deny: (store hasCartFrom: user)].
		! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:36:13'!
test03CartCantBeCreatedByStoreUser
	| store anUser |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' . 
	self assert: (store hasCartFrom: anUser) 
			! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:36:23'!
test04CartsIdObteinedAtCreationIdentifiesTheCartInTheStore
	| store anUser cart |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	cart _ store usersCart: anUser .
	self assert: ((store getCartFromId: (cart id)) = cart)
			! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:36:36'!
test05CanAddValidProductToCart
	| store anUser cart product |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	
	product _ self productExistsFromEditorial: '123456'.
	
	store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	cart _ store usersCart: anUser.

	self assert: ((cart products) size = 2).
			! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:36:56'!
test06CantAddInValidProductToCart
	| store anUser cart product |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	product _ '123456'.

	cart _ store usersCart: anUser.
	self
		should: [store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidProductErrorDescription.
			self assert: ((cart products) size = 0).
				]
	! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:44:29'!
test07CanListProductToCart
	| store anUser cart product list1 list2 product2 |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	
	product _ self productExistsFromEditorial: '123456'.
	product2 _ self productExistsFromEditorial: '456798'.
	cart _ store usersCart: anUser.

store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 6 .
	
	
	list1 _ cart listItemsWithQuantities.
	list2 _ store listProductsByCartId: (store usersCart: anUser) id .
	
	self assert: (list1 = list2).
	
	self deny: list1 isEmpty.
	self assert:  [list1 includes: {product.2}].
	self assert:  [list1 includes: {product2.6}].
	! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:37:08'!
test08StoreCanCheckOutWithCreditCard
	| store anUser product product2 |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	product _ self productExistsFromEditorial: '123456' withPrice: 420.
	product2 _ self productExistsFromEditorial: '456798' withPrice: 2. 
	store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 6 .
	self assert: (store checkout:(store usersCart: anUser) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current) = 852.
	
	! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:37:15'!
test09StoreCanListUsersPurchases
	| store anUser product product2 |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	product _ self productExistsFromEditorial: '123456' withPrice: 420.
	product2 _ self productExistsFromEditorial: '456798' withPrice: 2. 
	"Compra numero 0"
	self
		should: [store listPurchasesFromClientId: anUser pass: 'chau'.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store purchasesListError.	].
	
	
	"Compra numero 1"
	store addToCartId: (store usersCart: anUser) id product: product quantity: 5 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 1 .
	store checkout:(store usersCart: anUser) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: ((store listPurchasesFromClientId: anUser pass: 'chau') size) = 1.
	
	"Compra numero 2"
	store signIn: anUser password: 'chau'.
	store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 6 .
	store checkout:(store usersCart: anUser) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: (store listPurchasesFromClientId: anUser pass: 'chau') size = 2.! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 20:39:24'!
test10StoreCanListSeveralUsersPurchases
	| store anUser product product2 anUser2 |
		store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	product _ self productExistsFromEditorial: '123456' withPrice: 420.
	product2 _ self productExistsFromEditorial: '456798' withPrice: 2. 


		
	"Compra numero 1 user pepe"
	store addToCartId: (store usersCart: anUser) id product: product quantity: 5 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 1 .
	store checkout:(store usersCart: anUser) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: ((store listPurchasesFromClientId: anUser pass: 'chau') size) = 1.
	
	"Compra numero 1 user hola"
	
	anUser2 _ self SigninUserStore: store clientId: 'hola' pass: 'hola' .
	store addToCartId: (store usersCart: anUser2) id product: product quantity: 5 .
	store addToCartId: (store usersCart: anUser2) id product: product2 quantity: 1 .
	store checkout:(store usersCart: anUser2) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: ((store listPurchasesFromClientId: anUser2 pass: 'hola') size) = 1.
	
	
	"Compra numero 2 user pepe"
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 6 .
	store checkout:(store usersCart: anUser) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: (store listPurchasesFromClientId: anUser pass: 'chau') size = 2.
	
	
	"Compra numero 2 user hola"
	anUser2 _ self SigninUserStore: store clientId: 'hola' pass: 'hola' .
	store addToCartId: (store usersCart: anUser2) id product: product quantity: 8 .
	store addToCartId: (store usersCart: anUser2) id product: product2 quantity: 5 .
	store checkout:(store usersCart: anUser2) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: ((store listPurchasesFromClientId: anUser2 pass: 'hola') size) = 2.! !

!TestXXX methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 12:08:28'!
test11StoreCarts30MinutesOlderBecomeInvalidForTheStore
	| store anUser product clock cart |
	editorial _ Editorial withName: 'Yenny'.
	clock _ FakeCalendar new.
	store _ Store
		from: editorial
		withTimeFrom: clock.
	anUser _ self
		SigninUserStore: store
		clientId: 'pepe'
		pass: 'chau'.
	clock goForwardMinutes: 31.
	product _ self
		productExistsFromEditorial: '123456'
		withPrice: 420.
	cart _ store usersCart: anUser.
	self
		should: [
			store
				addToCartId: (store usersCart: anUser) id
				product: product
				quantity: 5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Store invalidCartErrorMessage ].
	self assert: cart products size = 0.! !


!classDefinition: #Cart category: #'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'editorial products size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'adding' stamp: 'ELR 10/27/2017 18:31:53'!
add: aProduct 
	(editorial includes: aProduct) ifFalse: [^self error: Cart invalidProductErrorDescription ].
	products add: aProduct.! !

!Cart methodsFor: 'adding' stamp: 'ELR 10/27/2017 18:36:28'!
add: aProduct copies: aCuantity 
	aCuantity timesRepeat: [self add: aProduct] .! !


!Cart methodsFor: 'accesing' stamp: 'ELR 10/27/2017 17:55:09'!
editorial
	^editorial.! !

!Cart methodsFor: 'accesing' stamp: 'ELR 10/27/2017 18:19:41'!
includes: aProduct 
	^products  includes: aProduct .! !

!Cart methodsFor: 'accesing' stamp: 'yn 10/29/2017 21:50:55'!
listItemsWithQuantities
	|listOfItems|
	
	listOfItems := OrderedCollection new.
	
	(products asSet) do: [ :item | 
		listOfItems add: { item. (products occurrencesOf: item) }. ].
	
	^listOfItems.
! !

!Cart methodsFor: 'accesing' stamp: 'ELR 10/27/2017 19:23:59'!
products
	^products! !

!Cart methodsFor: 'accesing' stamp: 'ELR 10/27/2017 18:38:39'!
stockOf: aProduct 
	^products occurrencesOf: aProduct ! !


!Cart methodsFor: 'check' stamp: 'yn 10/29/2017 15:14:05'!
isEmpty
	^products size = 0.! !


!Cart methodsFor: 'initialize' stamp: 'ELR 10/27/2017 17:54:07'!
editorial: editorialName 
	editorial _ editorialName.! !

!Cart methodsFor: 'initialize' stamp: 'ELR 10/27/2017 18:19:07'!
initialize
	products := OrderedCollection new .! !

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
	instanceVariableNames: 'editorial catalog total stringToOperation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ELR 10/27/2017 19:24:52'!
assess: aCart 
	| bill |
	bill := 0.00 .
	aCart products do:[:each | bill:= bill + (editorial priceFor: each)].
	^bill.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 20:07:49'!
checkout: aCart using: aCreditCard 
	
	| cart creditCard |
	cart := aCart.
	creditCard := aCreditCard.
	
	cart isEmpty 
		ifTrue: [ ^self error: Cashier CashierEmptyCartErrorDescription  ].
		
	(creditCard isExpired: GregorianMonthOfYear  current)
		ifTrue: [ ^self error: Cashier invalidCreditCardErrorDescription  ].
		
		total _ self assess: cart.
		
		^total.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 22:15:31'!
editorial: anEditorial 
	editorial _ anEditorial .
	catalog = Dictionary new.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:04:17'!
generateTransactionMessage: aTotal with: aCreditCard 
	| expirationCreditCard numberCreditCard ownerCreditCard totalOperation convertToString |
	totalOperation _ aTotal.
	ownerCreditCard _ aCreditCard  owner.
	numberCreditCard _ aCreditCard  numberCard.
	expirationCreditCard _ aCreditCard expiration .
	
	convertToString := '?creditCardNumber=',numberCreditCard,'&','creditCardExpiration=',expirationCreditCard monthNumber printString, expirationCreditCard  year number printString ,'&','creditCardOwner=',ownerCreditCard ,'&','transactionAmount=',totalOperation printString .
	stringToOperation _ convertToString .
	^convertToString.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'yn 10/29/2017 22:25:53'!
totalCart
	^total.! !

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

!CreditCard methodsFor: 'dataInitialize' stamp: 'yn 10/30/2017 18:40:59'!
expiration: aGregorianMonthOfYear 
	expiration := aGregorianMonthOfYear! !

!CreditCard methodsFor: 'dataInitialize' stamp: 'yn 10/29/2017 15:29:23'!
numberCard: aNumberCard 
	numberCard _ aNumberCard .! !

!CreditCard methodsFor: 'dataInitialize' stamp: 'yn 10/29/2017 15:30:01'!
owner: aOwner
	owner _ aOwner .! !


!CreditCard methodsFor: 'check' stamp: 'yn 10/30/2017 20:06:22'!
isExpired: aGregorianDate
	^expiration < aGregorianDate .! !


!CreditCard methodsFor: 'accesing' stamp: 'yn 10/30/2017 20:08:40'!
expiration
	^expiration.! !

!CreditCard methodsFor: 'accesing' stamp: 'yn 10/29/2017 15:30:44'!
numberCard
 ^numberCard.! !

!CreditCard methodsFor: 'accesing' stamp: 'yn 10/29/2017 15:30:29'!
owner
	^owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 18:47:05'!
numberCard: aNumberCard owner: aOwner withExpiration: aGregorianMonthOfYear
	| card |
	card _ self new.
	card expiration: aGregorianMonthOfYear.
	card numberCard: aNumberCard .
	card owner: aOwner .
	^card.
	
	! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 18:40:39'!
withExpiration: aGregorianMonthOfYear 
	
	| aCard |
	aCard := self new.
	aCard expiration: aGregorianMonthOfYear .
	^aCard.! !

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

!Editorial methodsFor: 'adding' stamp: 'ELR 10/27/2017 18:13:36'!
add: anProduct
	products add: anProduct.
	! !

!Editorial methodsFor: 'adding' stamp: 'ELR 10/27/2017 19:15:22'!
add: aProduct withPrice: aPrice 
	self add: aProduct .
	catalog at: aProduct put: aPrice.! !


!Editorial methodsFor: 'initialize' stamp: 'yn 10/29/2017 22:13:31'!
catalog
	^catalog.! !

!Editorial methodsFor: 'initialize' stamp: 'ELR 10/27/2017 19:06:48'!
employ: aCashier 
	cashier _ aCashier.! !

!Editorial methodsFor: 'initialize' stamp: 'ELR 10/27/2017 19:06:27'!
employs: aCashier 
	^cashier = aCashier .! !

!Editorial methodsFor: 'initialize' stamp: 'ELR 10/27/2017 19:05:33'!
initialize
	products := OrderedCollection new.
	catalog := Dictionary new.

	! !

!Editorial methodsFor: 'initialize' stamp: 'ELR 10/27/2017 18:10:17'!
name: aName
	name _ aName .! !


!Editorial methodsFor: 'accesing' stamp: 'ELR 10/27/2017 18:10:54'!
name
	^name.! !


!Editorial methodsFor: 'check' stamp: 'ELR 10/27/2017 18:15:48'!
includes: aProduct 
	^products includes: aProduct .! !

!Editorial methodsFor: 'check' stamp: 'ELR 10/27/2017 18:54:45'!
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


!classDefinition: #FakeCalendar category: #'TusLibros.com'!
Object subclass: #FakeCalendar
	instanceVariableNames: 'nowTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!FakeCalendar methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:29:05'!
goForwardMinutes: numberOfMinutes
	
	nowTime _ self now + numberOfMinutes .
	! !

!FakeCalendar methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:33:11'!
initialize
	 nowTime _ 1.! !

!FakeCalendar methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:29:14'!
now
	 ^nowTime .! !


!classDefinition: #MPProcesorSimulator category: #'TusLibros.com'!
Object subclass: #MPProcesorSimulator
	instanceVariableNames: 'outOfFoundsList invalidList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!MPProcesorSimulator methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:19:01'!
addAs: aInvalidCard
	
	invalidList add: aInvalidCard .! !

!MPProcesorSimulator methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:20:01'!
addAsCardOutOfFounds: aCreditCardOutOfFounds
	
	outOfFoundsList add: aCreditCardOutOfFounds .! !

!MPProcesorSimulator methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:27:20'!
debitOperation: aTotalOperation with: aCreditCard
	
	(outOfFoundsList includes: aCreditCard ) ifTrue: [^self error: MPProcesorSimulator creditCardOutOfFoundsErrorDescription].
	
	(invalidList includes: aCreditCard ) ifTrue: [^self error: MPProcesorSimulator creditCardInvalidFoundsErrorDescription].
	! !

!MPProcesorSimulator methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:17:25'!
initialize
	
	outOfFoundsList := OrderedCollection new.	
	invalidList := OrderedCollection  new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPProcesorSimulator class' category: #'TusLibros.com'!
MPProcesorSimulator class
	instanceVariableNames: ''!

!MPProcesorSimulator class methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 21:14:49'!
creditCardInvalidFoundsErrorDescription
	^'Tarjeta Robada'.! !

!MPProcesorSimulator class methodsFor: 'as yet unclassified' stamp: 'yn 10/30/2017 20:54:06'!
creditCardOutOfFoundsErrorDescription
	^'Fondos Insuficientes'.! !


!classDefinition: #Store category: #'TusLibros.com'!
Object subclass: #Store
	instanceVariableNames: 'editorial users usersCart catalog cashier historicPurchases timeProvider'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:26:30'!
addToCartId: aCartId product: aProduct quantity: aCopies 
	| cart |
	cart _ self getCartFromId: aCartId. 
	cart add: aProduct copies:aCopies.! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 19:34:29'!
checkout: aCartId withNumberCard: aCreditCardNumber owner: aName withExpiration: aGregorianMonthOfYear 
	| cart aCreditCard total userId carts |
	cart _ self getCartFromId: aCartId.
	aCreditCard _ CreditCard numberCard: aCreditCardNumber owner: aName withExpiration: aGregorianMonthOfYear.
	 
	total _ cashier checkout:  cart using: aCreditCard.
	userId _ self userOfCart: cart.
	carts _ OrderedCollection new.
	carts add: cart.
	"historicPurchases at: userId put: carts. "
	(historicPurchases includesKey: userId )ifFalse: [historicPurchases at: userId put: carts] ifTrue: [historicPurchases keysAndValuesDo: [:aKey :aValue |   aKey  = userId ifTrue: [aValue add: cart]]].
	^total
! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/2/2017 20:27:17'!
createUser: anUser pass: anPass 
	users  at: anUser put: anPass .! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:11:17'!
editorial
^editorial 
	! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:50:49'!
for: anEditorial 
	editorial _ anEditorial .
	catalog _ anEditorial  catalog. 
	cashier _ Cashier from: editorial.! !

!Store methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 13:07:41'!
getCartFromId: aId 
	| aCart |
	usersCart  do: [:each|   each id = aId ifTrue: [ aCart _ each]].
	(((aCart createdAt) distanceTo: timeProvider now) > (30 minutes )) ifTrue: [^self error: Store invalidCartErrorMessage ].
	^aCart .
	
	! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/2/2017 20:18:58'!
hasCartFrom: anUser
 	^usersCart includesKey: anUser 
	! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 20:11:42'!
initialize

	users  _ Dictionary new.
	usersCart _ Dictionary  new.
	historicPurchases _ Dictionary new.
	
	! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:39:16'!
listProductsByCartId: aCartId 
	| cart |
	cart _ self getCartFromId: aCartId. 
	^cart listItemsWithQuantities .! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 19:24:01'!
listPurchasesFromClientId: aClientId pass: aPassword 


	| listClientPurchases |
	self signIn: aClientId password: aPassword .
	(historicPurchases includesKey: aClientId )ifFalse: [^ self error: Store purchasesListError ].
	listClientPurchases := OrderedCollection new.
	historicPurchases keysAndValuesDo: [:aKey :aValue |   aKey  = aClientId ifTrue: [ listClientPurchases  _ aValue]].
	
	^listClientPurchases .! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 18:45:23'!
signIn: anUser password: anPass 
	(users includesKey: anUser) ifTrue:[
			((users at: anUser)  = anPass) ifTrue: [usersCart  at: anUser  put: (StoreCart fromStore: self).] ifFalse: [^ self error: Store invalidPassErrorMessage]	
			] ifFalse: [^self error: Store invalidUserErrorMessage].
			! !

!Store methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:23:13'!
time
	^timeProvider now.! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/4/2017 19:02:07'!
userOfCart: aStoreCart 
	usersCart  keysAndValuesDo: [:aKey :aValue |   aValue  = aStoreCart ifTrue: [ ^(aKey)]].! !

!Store methodsFor: 'as yet unclassified' stamp: 'yn 11/2/2017 20:52:53'!
usersCart: aUser 
	^usersCart at: aUser.! !

!Store methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:13:27'!
withTimeFrom: aCalendar 
	timeProvider _ aCalendar.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #'TusLibros.com'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 12:11:20'!
from: anEditorial 
	| aStore |
	aStore _ self new.
	aStore for: anEditorial .
	aStore withTimeFrom: GregorianDateTime .
	^aStore.! !

!Store class methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:16:08'!
from: anEditorial withTimeFrom: aCalendarClass
	| aStore |
	aStore _ self from: anEditorial.
	aStore withTimeFrom: aCalendarClass.
	^aStore.! !

!Store class methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:47:20'!
invalidCartErrorMessage
	^'Carrito invalido'.! !

!Store class methodsFor: 'as yet unclassified' stamp: 'yn 11/2/2017 20:27:55'!
invalidPassErrorMessage
	^'Password incorrecta'.! !

!Store class methodsFor: 'as yet unclassified' stamp: 'yn 11/2/2017 20:07:27'!
invalidUserErrorMessage
	^'Usuario no registrado en el STORE'.! !

!Store class methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 20:05:51'!
purchasesListError
	^'Error a Listar'! !


!classDefinition: #StoreCart category: #'TusLibros.com'!
Object subclass: #StoreCart
	instanceVariableNames: 'store id cart createdTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!StoreCart methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:14:22'!
add: aProduct copies: aCopies 
	"No salio el DoesNotUnderstood"
	cart add: aProduct copies: aCopies .! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 11:56:39'!
createdAt
	^createdTime! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:24:43'!
createdAt: aTimeReification 
	createdTime _ aTimeReification .! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'yn 11/2/2017 21:06:58'!
id
	^self hash. ! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:54:22'!
isEmpty
	^cart isEmpty .! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:38:19'!
listItemsWithQuantities
	^cart listItemsWithQuantities .! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:16:40'!
products
	^cart products.! !

!StoreCart methodsFor: 'as yet unclassified' stamp: 'yn 11/3/2017 19:10:50'!
store: aStore 
	store _ aStore.  
	cart _ Cart fromEditorial: aStore editorial. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreCart class' category: #'TusLibros.com'!
StoreCart class
	instanceVariableNames: ''!

!StoreCart class methodsFor: 'as yet unclassified' stamp: 'ELR 11/5/2017 10:19:53'!
fromStore: aStore 
	| aStoreCart |
	aStoreCart _ self new.
	aStoreCart store: aStore.
	aStoreCart createdAt: aStore time.
	^aStoreCart.
	! !
