!classDefinition: #TestTusLibrosCom category: #'TusLibros.com'!
TestCase subclass: #TestTusLibrosCom
	instanceVariableNames: 'editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:55:51'!
test01CanCreateACartFromAnEditorial
	| cart |
	cart:= Cart fromEditorial: 'Yenny'.
	self assert: cart editorial = 'Yenny'.! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:46:34'!
test02CanCreateAEmptyCart
	| cart |
	cart _ self createCart: 'Yenny'.
	self assert: cart isEmpty.! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'ELR 10/27/2017 18:08:19'!
test03EditorialsHasNames
	
	| editorial |
	editorial := Editorial withName: 'Yenny'.
	self assert: editorial name = 'Yenny'.! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'ELR 10/27/2017 18:12:45'!
test04EditorialHasProducts
	| editorial product |
	editorial := Editorial withName: 'Yenny'.
	product := Object new.
	editorial add: product.
	
	self assert: [editorial includes: product].! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:50:51'!
test05CanAddValidEditorialsProductToCart
	| cart product |
	
	cart _ self createCart: 'Yenny'.
	product _ self productFromEditorial: Object new.
	cart add: product.
	self assert: [cart includes: product ].
	
	! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:56:43'!
test06CantAddNonEditorialsProductsToCartEditorialCart
	| cart product |
	cart _ self createCart: 'Yenny'.
	product _ Object new.
		
	self
		should: [ cart add: product ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidProductErrorDescription ]
	
	! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:57:19'!
test07CanAddSeveralValidEditorialsProductToCart
	| cart product |
	cart _ self createCart: 'Yenny'.
	product _ self productFromEditorial: Object new.
	cart add: product copies: 4.
	self assert: [cart includes: product ].
	self assert: (cart stockOf: product ) = 4 .
	
	! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'ELR 10/27/2017 18:50:41'!
test08AllSellingEditorialProductsHaveAPriceAsociated
	| product editorial |
	editorial := Editorial withName: 'Yenny'.
	product := Object new.
	editorial add: product withPrice: 5 .
	
	self assert: [(editorial priceFor: product) = 5].
	
	
	! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'ELR 10/27/2017 19:03:57'!
test09EditorialHasCashiers
	| editorial cashier |
	editorial := Editorial withName: 'Yenny'.	
	cashier := Cashier from: editorial.
	editorial employ: cashier.
	self assert: [editorial employs: cashier].
	
	
	! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'ELR 10/27/2017 19:11:37'!
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

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:58:44'!
test11CashierOnlyAcceptsValidCreditCard
	|  cashier creditCard cart product aMonthOfYear |
	cart _ self createCart: 'Yenny'.
	product _ self productFromEditorial: Object new.
	cashier := Cashier from: editorial.
	cart add: product copies: 4.
	aMonthOfYear := GregorianMonthOfYear  current previous .
	creditCard := CreditCard withExpiration: aMonthOfYear.
	self 
		should: [ cashier checkout: cart using: creditCard. ]
		raise: Error  
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier invalidCreditCardErrorDescription ].
		
		! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 14:59:45'!
test12CashierRejectsEmptyCart

	| cart  creditCard cashier |
	cart _ self createCart: 'Yenny'.
	cashier := Cashier from: editorial.
	creditCard := CreditCard new.
	
	self 
		should: [ cashier checkout: cart using: creditCard. ]
		raise: Error  
		withExceptionDo: [ :anError | 
			self assert: anError  messageText = Cashier CashierEmptyCartErrorDescription ].! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 15:11:42'!
test13ListItemsCart
	| aCatalog aCart listItems product product2 |
	aCart _ self createCart: 'Yenny'.
	aCatalog _ OrderedCollection new.
	product := 4356.
	product2  := 8741.
	self addProductWithPriceFromEditorial: editorial product: product withPrice: 5.
	self addProductWithPriceFromEditorial: editorial product: product2 withPrice: 1.
	aCatalog add: product.
	aCatalog add: product2.
	self addProductToCart: aCart  product: product copies: 2.
	self addProductToCart: aCart  product: product2 copies: 6.
	self addProductToCart: aCart  product: product copies: 3.	
	listItems := aCart listItemsWithQuantities.
	self deny: listItems isEmpty.
	self assert:  [listItems includes: {product.5}].
	self assert:  [listItems includes: {product2.6}].
	

! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 15:16:33'!
test14CashierCalculatesTotal

	| cart editorialCatalogue cashier  product product2 |
	cart _ self createCart: 'Yenny'.
	editorialCatalogue := Dictionary new.
	cashier := Cashier from: editorial.
	product := 4356.
	product2 := 1234.
	self addProductWithPriceFromEditorial: editorial product: product withPrice: 420.
	self addProductWithPriceFromEditorial: editorial product: product2 withPrice: 2.
	self addProductToCart: cart  product: product copies: 3.
	self addProductToCart: cart  product: product2 copies: 3.
	self assert: (cashier assess: cart) = 1266.
	! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 15:17:17'!
test15CheckOutWithNonExpiredCreditCard

	| cart  creditCard cashier product product2 |
	cart _ self createCart: 'Yenny'.
	cashier := Cashier from: editorial.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	product := 4356.
	product2 := 1234.
	self addProductWithPriceFromEditorial: editorial product: product withPrice: 420.
	self addProductWithPriceFromEditorial: editorial product: product2 withPrice: 2.
	self addProductToCart: cart  product: product copies: 3.
	self addProductToCart: cart  product: product2 copies: 3.
	self assert: (cashier checkout: cart using: creditCard) = 1266.! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 15:18:39'!
test16DebitStringInterfaceToCorrect

	| cart  creditCard  cashier product product2 total convertToString aDate stringDate |
	cart _ self createCart: 'Yenny'.
	cashier := Cashier from: editorial.
	aDate := GregorianMonthOfYear  current.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  aDate.
	stringDate := aDate monthNumber printString, aDate year number printString.
	product := 4356.
	product2 := 1234.
	self addProductWithPriceFromEditorial: editorial product: product withPrice: 420.
	self addProductWithPriceFromEditorial: editorial product: product2 withPrice: 2.
	self addProductToCart: cart  product: product copies: 3.
	self addProductToCart: cart  product: product2 copies: 3.
	total := cashier checkout: cart using: creditCard.
	convertToString := '?creditCardNumber=','1122334455','&','creditCardExpiration=',stringDate ,'&','creditCardOwner=XXX', '&','transactionAmount=',total printString.
	
	self assert: [(cashier generateTransactionMessage: total with: creditCard ) = convertToString ].! !

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 15:20:33'!
test17CreditCardOutOfFoundsProducesError

	| cart  creditCard  cashier product product2 total convertToString aDate stringDate mp |
	cart _ self createCart: 'Yenny'.
	cashier := Cashier from: editorial.
	aDate := GregorianMonthOfYear  current.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  aDate.
	stringDate := aDate monthNumber printString, aDate year number printString.
	product := 4356.
	product2 := 1234.
	self addProductWithPriceFromEditorial: editorial product: product withPrice: 420.
	self addProductWithPriceFromEditorial: editorial product: product2 withPrice: 2.
	self addProductToCart: cart  product: product copies: 3.
	self addProductToCart: cart  product: product2 copies: 3.
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

!TestTusLibrosCom methodsFor: 'TestCart' stamp: 'yn 11/5/2017 15:21:18'!
test18CreditCardInvalidProducesError

	| cart  creditCard cashier product product2 total convertToString aDate stringDate mp |
	cart _ self createCart: 'Yenny'.
	cart := Cart fromEditorial: editorial.
	cashier := Cashier from: editorial.
	aDate := GregorianMonthOfYear  current.
	creditCard := CreditCard numberCard: '1122334455' owner: 'XXX' withExpiration:  aDate.
	stringDate := aDate monthNumber printString, aDate year number printString.
	product := 4356.
	product2 := 1234.
	self addProductWithPriceFromEditorial: editorial product: product withPrice: 420.
	self addProductWithPriceFromEditorial: editorial product: product2 withPrice: 2.
	self addProductToCart: cart  product: product copies: 3.
	self addProductToCart: cart  product: product2 copies: 3.
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


!TestTusLibrosCom methodsFor: 'SetUp' stamp: 'yn 11/5/2017 15:11:49'!
addProductToCart: aCart product: aProduct copies: aCopies 
	aCart add: aProduct copies: aCopies .
	! !

!TestTusLibrosCom methodsFor: 'SetUp' stamp: 'yn 11/5/2017 15:05:53'!
addProductWithPriceFromEditorial: anEditorial product: aProduct withPrice: aPrice 
	anEditorial add: aProduct withPrice: aPrice .! !

!TestTusLibrosCom methodsFor: 'SetUp' stamp: 'yn 11/5/2017 14:55:19'!
createCart: aEditorial
	editorial _ Editorial withName: aEditorial .
	^Cart fromEditorial: editorial .! !

!TestTusLibrosCom methodsFor: 'SetUp' stamp: 'yn 11/5/2017 14:50:04'!
productFromEditorial:  aProduct
	editorial add: aProduct.
	^aProduct .! !


!classDefinition: #TestXXX category: #'TusLibros.com'!
TestCase subclass: #TestXXX
	instanceVariableNames: 'editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TestXXX methodsFor: 'Store' stamp: 'yn 11/4/2017 20:35:16'!
SigninUserStore: anStore clientId: anUser pass: aPass
	
	
	anStore createUser: anUser pass: aPass.
	anStore signIn: anUser password: aPass.
	^anUser 
	! !

!TestXXX methodsFor: 'Store' stamp: 'yn 11/4/2017 20:19:03'!
StoreAndEditorial
	|  store |
	editorial := Editorial withName: 'Yenny'.
	
	store:= Store from: editorial.
	^store
! !

!TestXXX methodsFor: 'Store' stamp: 'yn 11/4/2017 20:21:18'!
productExistsFromEditorial: aISBNProduct 
	editorial add: aISBNProduct .
	^aISBNProduct .! !

!TestXXX methodsFor: 'Store' stamp: 'yn 11/4/2017 20:31:25'!
productExistsFromEditorial: aISBNProduc withPrice: aPrice 
	editorial add: aISBNProduc withPrice: aPrice .
	^aISBNProduc .
	! !


!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:08:33'!
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

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:08:53'!
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

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:36:13'!
test03CartCantBeCreatedByStoreUser
	| store anUser |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' . 
	self assert: (store hasCartFrom: anUser) 
			! !

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:36:23'!
test04CartsIdObteinedAtCreationIdentifiesTheCartInTheStore
	| store anUser cart |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	cart _ store usersCart: anUser .
	self assert: ((store getCartFromId: (cart id)) = cart)
			! !

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:36:36'!
test05CanAddValidProductToCart
	| store anUser cart product |
	store _ self StoreAndEditorial.
	anUser _ self SigninUserStore: store clientId: 'pepe' pass: 'chau' .
	
	product _ self productExistsFromEditorial: '123456'.
	
	store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	cart _ store usersCart: anUser.

	self assert: ((cart products) size = 2).
			! !

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:36:56'!
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

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:44:29'!
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

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/4/2017 20:37:08'!
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

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/6/2017 14:59:46'!
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
	self assert: ((store listPurchasesTotalFromClientId: anUser pass: 'chau') ) = 2102.0.
	
	
	"Compra numero 2"
	store signIn: anUser password: 'chau'.
	store addToCartId: (store usersCart: anUser) id product: product quantity: 2 .
	store addToCartId: (store usersCart: anUser) id product: product2 quantity: 6 .
	store checkout:(store usersCart: anUser) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: (store listPurchasesFromClientId: anUser pass: 'chau') size = 2.
	self assert: ((store listPurchasesTotalFromClientId: anUser pass: 'chau') ) = 2954.0.
	! !

!TestXXX methodsFor: 'TestStore' stamp: 'yn 11/6/2017 15:44:11'!
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
	self assert: ((store listPurchasesTotalFromClientId: anUser pass: 'chau') ) = 2954.0.
	
	"Compra numero 2 user hola"
	anUser2 _ self SigninUserStore: store clientId: 'hola' pass: 'hola' .
	store addToCartId: (store usersCart: anUser2) id product: product quantity: 8 .
	store addToCartId: (store usersCart: anUser2) id product: product2 quantity: 5 .
	store checkout:(store usersCart: anUser2) id withNumberCard: '1122334455' owner: 'XXX' withExpiration:  GregorianMonthOfYear  current.
	self assert: ((store listPurchasesFromClientId: anUser2 pass: 'hola') size) = 2.
	self assert: ((store listPurchasesTotalFromClientId: anUser2 pass: 'hola') ) = 5472.0.! !

!TestXXX methodsFor: 'TestStore' stamp: 'ELR 11/5/2017 14:10:17'!
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

!Cart class methodsFor: 'messageError' stamp: 'ELR 10/27/2017 18:29:53'!
invalidProductErrorDescription
	^'Producto no perteneciente a la editorial'.! !


!Cart class methodsFor: 'construct' stamp: 'ELR 10/27/2017 17:54:41'!
fromEditorial: anEditorialName 
	| aNewCart |
	aNewCart _ self new.
	aNewCart editorial: anEditorialName .
	^aNewCart .! !


!classDefinition: #Cashier category: #'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'editorial catalog total stringToOperation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'transaction' stamp: 'ELR 10/27/2017 19:24:52'!
assess: aCart 
	| bill |
	bill := 0.00 .
	aCart products do:[:each | bill:= bill + (editorial priceFor: each)].
	^bill.! !

!Cashier methodsFor: 'transaction' stamp: 'yn 10/30/2017 20:07:49'!
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

!Cashier methodsFor: 'transaction' stamp: 'yn 10/30/2017 21:04:17'!
generateTransactionMessage: aTotal with: aCreditCard 
	| expirationCreditCard numberCreditCard ownerCreditCard totalOperation convertToString |
	totalOperation _ aTotal.
	ownerCreditCard _ aCreditCard  owner.
	numberCreditCard _ aCreditCard  numberCard.
	expirationCreditCard _ aCreditCard expiration .
	
	convertToString := '?creditCardNumber=',numberCreditCard,'&','creditCardExpiration=',expirationCreditCard monthNumber printString, expirationCreditCard  year number printString ,'&','creditCardOwner=',ownerCreditCard ,'&','transactionAmount=',totalOperation printString .
	stringToOperation _ convertToString .
	^convertToString.! !

!Cashier methodsFor: 'transaction' stamp: 'yn 10/29/2017 22:25:53'!
totalCart
	^total.! !


!Cashier methodsFor: 'initialization' stamp: 'yn 10/29/2017 22:15:31'!
editorial: anEditorial 
	editorial _ anEditorial .
	catalog = Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'messageError' stamp: 'yn 10/29/2017 15:09:34'!
CashierEmptyCartErrorDescription
	^'No es posible hacer checkout de un carrito vacio'.! !

!Cashier class methodsFor: 'messageError' stamp: 'ELR 10/27/2017 19:37:55'!
invalidCreditCardErrorDescription
	^'Tarjeta vencida pa'.! !


!Cashier class methodsFor: 'construct' stamp: 'ELR 10/27/2017 19:02:24'!
from: anEditorial 
	| cashier |
	cashier _ self new.
	cashier editorial: anEditorial.
	^cashier.! !


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

!CreditCard class methodsFor: 'construct' stamp: 'yn 10/30/2017 18:47:05'!
numberCard: aNumberCard owner: aOwner withExpiration: aGregorianMonthOfYear
	| card |
	card _ self new.
	card expiration: aGregorianMonthOfYear.
	card numberCard: aNumberCard .
	card owner: aOwner .
	^card.
	
	! !

!CreditCard class methodsFor: 'construct' stamp: 'yn 10/30/2017 18:40:39'!
withExpiration: aGregorianMonthOfYear 
	
	| aCard |
	aCard := self new.
	aCard expiration: aGregorianMonthOfYear .
	^aCard.! !

!CreditCard class methodsFor: 'construct' stamp: 'ELR 10/27/2017 19:35:38'!
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

!Editorial class methodsFor: 'construct' stamp: 'ELR 10/27/2017 18:09:11'!
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

!FakeCalendar methodsFor: 'initialization' stamp: 'ELR 11/5/2017 14:07:24'!
initialize
	 nowTime _ 1 minutes.! !


!FakeCalendar methodsFor: 'testing' stamp: 'ELR 11/5/2017 10:29:14'!
now
	 ^nowTime .! !


!FakeCalendar methodsFor: 'setting' stamp: 'ELR 11/5/2017 14:07:34'!
goForwardMinutes: numberOfMinutes
	
	nowTime _ self now + numberOfMinutes minutes .
	! !


!classDefinition: #HistoricClient category: #'TusLibros.com'!
Object subclass: #HistoricClient
	instanceVariableNames: 'aStoreCarts totalHistoric'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!HistoricClient methodsFor: 'as yet unclassified' stamp: 'yn 11/6/2017 15:22:20'!
initialize
	aStoreCarts _ OrderedCollection new.
	totalHistoric _ 0! !

!HistoricClient methodsFor: 'as yet unclassified' stamp: 'yn 11/6/2017 15:27:00'!
storeCart
	^aStoreCarts .! !

!HistoricClient methodsFor: 'as yet unclassified' stamp: 'yn 11/6/2017 15:21:41'!
storeCart: aStoreCart 
	aStoreCarts add: aStoreCart .! !

!HistoricClient methodsFor: 'as yet unclassified' stamp: 'yn 11/6/2017 15:24:52'!
total
	^totalHistoric .! !

!HistoricClient methodsFor: 'as yet unclassified' stamp: 'yn 11/6/2017 15:23:28'!
total: aTotal 
	| subtotal |
	subtotal _ totalHistoric  + aTotal .
	totalHistoric _ subtotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HistoricClient class' category: #'TusLibros.com'!
HistoricClient class
	instanceVariableNames: ''!

!HistoricClient class methodsFor: 'as yet unclassified' stamp: 'yn 11/6/2017 15:21:15'!
from: aStoreCart 
	| aHistoricClient |
	aHistoricClient _ self new.
	aHistoricClient storeCart: aStoreCart.
	^aHistoricClient.! !


!classDefinition: #MPProcesorSimulator category: #'TusLibros.com'!
Object subclass: #MPProcesorSimulator
	instanceVariableNames: 'outOfFoundsList invalidList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!MPProcesorSimulator methodsFor: 'adding' stamp: 'yn 10/30/2017 21:19:01'!
addAs: aInvalidCard
	
	invalidList add: aInvalidCard .! !

!MPProcesorSimulator methodsFor: 'adding' stamp: 'yn 10/30/2017 21:20:01'!
addAsCardOutOfFounds: aCreditCardOutOfFounds
	
	outOfFoundsList add: aCreditCardOutOfFounds .! !


!MPProcesorSimulator methodsFor: 'initialization' stamp: 'yn 10/30/2017 21:17:25'!
initialize
	
	outOfFoundsList := OrderedCollection new.	
	invalidList := OrderedCollection  new.! !


!MPProcesorSimulator methodsFor: 'debit' stamp: 'yn 10/30/2017 21:27:20'!
debitOperation: aTotalOperation with: aCreditCard
	
	(outOfFoundsList includes: aCreditCard ) ifTrue: [^self error: MPProcesorSimulator creditCardOutOfFoundsErrorDescription].
	
	(invalidList includes: aCreditCard ) ifTrue: [^self error: MPProcesorSimulator creditCardInvalidFoundsErrorDescription].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPProcesorSimulator class' category: #'TusLibros.com'!
MPProcesorSimulator class
	instanceVariableNames: ''!

!MPProcesorSimulator class methodsFor: 'messageError' stamp: 'yn 10/30/2017 21:14:49'!
creditCardInvalidFoundsErrorDescription
	^'Tarjeta Robada'.! !

!MPProcesorSimulator class methodsFor: 'messageError' stamp: 'yn 10/30/2017 20:54:06'!
creditCardOutOfFoundsErrorDescription
	^'Fondos Insuficientes'.! !


!classDefinition: #Store category: #'TusLibros.com'!
Object subclass: #Store
	instanceVariableNames: 'editorial users usersCart catalog cashier historicPurchases timeProvider idCarts historicPurchasesTotal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Store methodsFor: 'lists' stamp: 'yn 11/3/2017 19:39:16'!
listProductsByCartId: aCartId 
	| cart |
	cart _ self getCartFromId: aCartId. 
	^cart listItemsWithQuantities .! !

!Store methodsFor: 'lists' stamp: 'yn 11/6/2017 15:34:12'!
listPurchasesFromClientId: aClientId pass: aPassword 


	| listClientPurchases |
	self signIn: aClientId password: aPassword .
	(historicPurchases includesKey: aClientId )ifFalse: [^ self error: Store purchasesListError ].
	listClientPurchases := OrderedCollection new.
	
	historicPurchases keysAndValuesDo: [:aKey :aValue |   aKey  = aClientId ifTrue: [ listClientPurchases _ aValue ]].
	
	^listClientPurchases.! !

!Store methodsFor: 'lists' stamp: 'yn 11/6/2017 15:24:34'!
listPurchasesTotalFromClientId: aClientId pass: aPassword 


	| totalPurchases |
	self signIn: aClientId password: aPassword .
	(historicPurchasesTotal includesKey: aClientId )ifFalse: [^ self error: Store purchasesListError ].
	totalPurchases _ 0.
	historicPurchasesTotal keysAndValuesDo: [:aKey :aValue |   aKey  = aClientId ifTrue: [ totalPurchases _ aValue total]].
	
	^totalPurchases.! !


!Store methodsFor: 'testing' stamp: 'yn 11/3/2017 19:11:17'!
editorial
^editorial 
	! !

!Store methodsFor: 'testing' stamp: 'ELR 11/5/2017 10:23:13'!
time
	^timeProvider now.! !


!Store methodsFor: 'initialization' stamp: 'yn 11/3/2017 19:50:49'!
for: anEditorial 
	editorial _ anEditorial .
	catalog _ anEditorial  catalog. 
	cashier _ Cashier from: editorial.! !

!Store methodsFor: 'initialization' stamp: 'yn 11/5/2017 21:58:17'!
idCarts: aIdCart 
	idCarts _ aIdCart .! !

!Store methodsFor: 'initialization' stamp: 'yn 11/6/2017 14:36:15'!
initialize

	users  _ Dictionary new.
	usersCart _ Dictionary  new.
	historicPurchases _ Dictionary new.
	historicPurchasesTotal _ Dictionary new.
	
	! !

!Store methodsFor: 'initialization' stamp: 'ELR 11/5/2017 10:13:27'!
withTimeFrom: aCalendar 
	timeProvider _ aCalendar.! !


!Store methodsFor: 'adding' stamp: 'yn 11/3/2017 19:26:30'!
addToCartId: aCartId product: aProduct quantity: aCopies 
	| cart |
	cart _ self getCartFromId: aCartId. 
	cart add: aProduct copies:aCopies.! !

!Store methodsFor: 'adding' stamp: 'yn 11/5/2017 21:55:59'!
idNext
	idCarts _ idCarts  + 1.
	^idCarts ! !


!Store methodsFor: 'users' stamp: 'yn 11/2/2017 20:27:17'!
createUser: anUser pass: anPass 
	users  at: anUser put: anPass .! !

!Store methodsFor: 'users' stamp: 'yn 11/2/2017 20:18:58'!
hasCartFrom: anUser
 	^usersCart includesKey: anUser 
	! !

!Store methodsFor: 'users' stamp: 'yn 11/4/2017 18:45:23'!
signIn: anUser password: anPass 
	(users includesKey: anUser) ifTrue:[
			((users at: anUser)  = anPass) ifTrue: [usersCart  at: anUser  put: (StoreCart fromStore: self).] ifFalse: [^ self error: Store invalidPassErrorMessage]	
			] ifFalse: [^self error: Store invalidUserErrorMessage].
			! !

!Store methodsFor: 'users' stamp: 'yn 11/4/2017 19:02:07'!
userOfCart: aStoreCart 
	usersCart  keysAndValuesDo: [:aKey :aValue |   aValue  = aStoreCart ifTrue: [ ^(aKey)]].! !

!Store methodsFor: 'users' stamp: 'yn 11/2/2017 20:52:53'!
usersCart: aUser 
	^usersCart at: aUser.! !


!Store methodsFor: 'cart' stamp: 'yn 11/6/2017 15:30:48'!
checkout: aCartId withNumberCard: aCreditCardNumber owner: aName withExpiration: aGregorianMonthOfYear 
	| cart aCreditCard total userId carts totals historicClient |
	cart _ self getCartFromId: aCartId.
	aCreditCard _ CreditCard numberCard: aCreditCardNumber owner: aName withExpiration: aGregorianMonthOfYear.
	 
	total _ cashier checkout:  cart using: aCreditCard.
	userId _ self userOfCart: cart.
	carts _ OrderedCollection new.
	carts add: cart.
	totals _ OrderedCollection new.
	totals add: total.
	historicClient _ HistoricClient from: cart.
	historicClient total: total.
	(historicPurchases includesKey: userId )ifFalse: [historicPurchases at: userId put: carts] ifTrue: [historicPurchases keysAndValuesDo: [:aKey :aValue |   aKey  = userId ifTrue: [aValue add: cart]]].
	(historicPurchasesTotal includesKey: userId )ifFalse: [historicPurchasesTotal at: userId put: historicClient] ifTrue: [historicPurchasesTotal keysAndValuesDo: [:aKey :aValue |   aKey  = userId ifTrue: [ aValue total: total].
			aValue storeCart: cart.]].
	^total
! !

!Store methodsFor: 'cart' stamp: 'ELR 11/5/2017 14:10:03'!
getCartFromId: aId 
	| aCart comparison |
	usersCart  do: [:each|   each id = aId ifTrue: [ aCart _ each]].
	comparison _ ((timeProvider now - (aCart createdAt)) > 30 minutes).
	comparison ifTrue: [^self error: Store invalidCartErrorMessage ].
	^aCart .
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #'TusLibros.com'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'constructor' stamp: 'yn 11/5/2017 22:00:10'!
from: anEditorial 
	| aStore |
	aStore _ self new.
	aStore for: anEditorial .
	aStore withTimeFrom: DateAndTime .
	aStore idCarts: 1 .
	^aStore.! !

!Store class methodsFor: 'constructor' stamp: 'yn 11/5/2017 22:03:53'!
from: anEditorial withTimeFrom: aCalendarClass
	| aStore |
	aStore _ self from: anEditorial.
	aStore withTimeFrom: aCalendarClass.
	^aStore.! !


!Store class methodsFor: 'messageError' stamp: 'ELR 11/5/2017 10:47:20'!
invalidCartErrorMessage
	^'Carrito invalido'.! !

!Store class methodsFor: 'messageError' stamp: 'yn 11/2/2017 20:27:55'!
invalidPassErrorMessage
	^'Password incorrecta'.! !

!Store class methodsFor: 'messageError' stamp: 'yn 11/2/2017 20:07:27'!
invalidUserErrorMessage
	^'Usuario no registrado en el STORE'.! !

!Store class methodsFor: 'messageError' stamp: 'yn 11/3/2017 20:05:51'!
purchasesListError
	^'Error a Listar'! !


!classDefinition: #StoreCart category: #'TusLibros.com'!
Object subclass: #StoreCart
	instanceVariableNames: 'store id cart createdTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!StoreCart methodsFor: 'listItem' stamp: 'yn 11/3/2017 19:38:19'!
listItemsWithQuantities
	^cart listItemsWithQuantities .! !


!StoreCart methodsFor: 'adding' stamp: 'yn 11/5/2017 15:22:22'!
add: aProduct copies: aCopies 
	cart add: aProduct copies: aCopies .! !


!StoreCart methodsFor: 'testing' stamp: 'ELR 11/5/2017 11:56:39'!
createdAt
	^createdTime! !

!StoreCart methodsFor: 'testing' stamp: 'yn 11/5/2017 21:47:24'!
id
	^id. ! !

!StoreCart methodsFor: 'testing' stamp: 'yn 11/3/2017 19:54:22'!
isEmpty
	^cart isEmpty .! !

!StoreCart methodsFor: 'testing' stamp: 'yn 11/3/2017 19:16:40'!
products
	^cart products.! !


!StoreCart methodsFor: 'initialization' stamp: 'ELR 11/5/2017 10:24:43'!
createdAt: aTimeReification 
	createdTime _ aTimeReification .! !

!StoreCart methodsFor: 'initialization' stamp: 'yn 11/5/2017 21:53:17'!
createdId: aIdCart 
	id _ aIdCart .! !

!StoreCart methodsFor: 'initialization' stamp: 'yn 11/3/2017 19:10:50'!
store: aStore 
	store _ aStore.  
	cart _ Cart fromEditorial: aStore editorial. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreCart class' category: #'TusLibros.com'!
StoreCart class
	instanceVariableNames: ''!

!StoreCart class methodsFor: 'constructor' stamp: 'yn 11/5/2017 21:48:05'!
fromStore: aStore 
	| aStoreCart |
	aStoreCart _ self new.
	aStoreCart store: aStore.
	aStoreCart createdAt: aStore time.
	aStoreCart createdId: aStore idNext.
	^aStoreCart.
	! !
