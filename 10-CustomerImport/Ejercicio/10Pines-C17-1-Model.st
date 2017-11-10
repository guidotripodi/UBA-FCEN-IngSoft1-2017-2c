Object subclass: #Address	instanceVariableNames: 'id streetName streetNumber town zipCode province'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-1-Model'!!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 13:27'!streetName: aStreetName
 
	streetName := aStreetName ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 16:12'!streetName

	^streetName ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 16:12'!streetNumber

	^streetNumber ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 13:27'!streetNumber: aStreetNumber
 
	streetNumber := aStreetNumber ! !!Address methodsFor: 'province' stamp: 'HernanWilkinson 10/28/2016 16:11'!province

	^province! !!Address methodsFor: 'province' stamp: 'HernanWilkinson 10/28/2016 16:08'!province: aProvince
 
	province := aProvince
	! !!Address methodsFor: 'zip code' stamp: 'HernanWilkinson 10/28/2016 16:13'!zipCode

	^zipCode! !!Address methodsFor: 'zip code' stamp: 'HernanWilkinson 10/28/2016 16:08'!zipCode: aZipCode
 
	zipCode := aZipCode! !!Address methodsFor: 'twon' stamp: 'HernanWilkinson 10/28/2016 16:07'!town: aTown
 
	town := aTown! !!Address methodsFor: 'twon' stamp: 'HernanWilkinson 10/28/2016 16:12'!town

	^town! !Object subclass: #Customer	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-1-Model'!!Customer methodsFor: 'initialization' stamp: 'HernanWilkinson 10/28/2016 13:26'!initialize

	super initialize.
	addresses := OrderedCollection new.! !!Customer methodsFor: 'importing' stamp: 'ip 11/6/2017 21:53'!addressAt: aStreetName
	^ self addresses
		detect: [ :anAddress | anAddress streetName = aStreetName ]! !!Customer methodsFor: 'importing' stamp: 'ip 11/6/2017 21:19'!importCustomers: anObject
	"
	self importCustomers
	"

	test importCustomers: nil! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 13:09'!firstName: aName
 
	firstName := aName! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 13:09'!lastName: aLastName
 
	lastName := aLastName
! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 16:15'!lastName

	^lastName ! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 16:15'!firstName
	
	^firstName ! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 16:13'!identificationNumber
	
	^identificationNumber ! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 13:10'!identificationNumber: anIdentificationNumber
 
	identificationNumber := anIdentificationNumber! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 13:10'!identificationType: anIdentificationType 

	identificationType := anIdentificationType! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 16:13'!identificationType
	
	^identificationType ! !!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 10/28/2016 13:25'!addresses

	^ addresses! !!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 10/28/2016 13:27'!addAddress: anAddress 

	addresses add: anAddress ! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Customer class	instanceVariableNames: ''!!Customer class methodsFor: 'importing' stamp: 'HernanWilkinson 11/1/2016 08:39'!importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |
	
	inputStream := FileStream fileNamed: 'input.txt'.
	session := DataBaseSession for: (Array 
		with: (ClassMapping 
			withDefaultTableNameFor: Address 
			mappingAll: (Array 
				with: (EmbededMapping withDefaultFieldNameFor: #streetName)
				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
				with: (EmbededMapping withDefaultFieldNameFor: #town)
				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
				with: (EmbededMapping withDefaultFieldNameFor: #province))) 
		with: (ClassMapping 
			withDefaultTableNameFor: Customer 
			mappingAll: (Array 
				with: (EmbededMapping withDefaultFieldNameFor: #firstName)
				with: (EmbededMapping withDefaultFieldNameFor: #lastName)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address)))).
	session open.
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [ 
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line substrings: {$,}.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].
		
		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line substrings: { $, }.
			newAddress := Address new.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asInteger. 
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asInteger.
			newAddress province: addressData fourth.
			newCustomer addAddress: newAddress. ].
			
			line := inputStream nextLine. ].
			
		session commit.
		session close.
		
		inputStream close.
		! !Object subclass: #CustomerImport	instanceVariableNames: 'session'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-1-Model'!!CustomerImport methodsFor: 'importing' stamp: 'Anonymous 11/9/2017 20:33'!createCustomerFromDataLine: customerData	| newCustomer |	newCustomer := Customer new.	newCustomer firstName: customerData second.	newCustomer lastName: customerData third.	newCustomer identificationType: customerData fourth.	newCustomer identificationNumber: customerData fifth.	^ newCustomer! !!CustomerImport methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 20:53'!addAddressFromDataLine: line toACustomer: newCustomer	| addressData newAddress |	newCustomer ifNil: [^ self error: CustomerImport  noCustomerForAddressErrorDescription ] .	addressData := line substrings: {$,}.	newAddress := self createAddressFromDataLine: addressData.	newCustomer addAddress: newAddress! !!CustomerImport methodsFor: 'importing' stamp: 'Anonymous 11/9/2017 20:35'!importCustomers: anInputStream	| newCustomer line |	line := anInputStream nextLine.	[ line notNil ]		whileTrue: [ (line beginsWith: 'C')				ifTrue: [ newCustomer := self						persistNewCustomerFromDataLine: line						into: session ].			(line beginsWith: 'A')				ifTrue:					[ self addAddressFromDataLine: line toACustomer: newCustomer ].			line := anInputStream nextLine ]! !!CustomerImport methodsFor: 'importing' stamp: 'Anonymous 11/9/2017 20:33'!persistNewCustomerFromDataLine: line into: session	| newCustomer customerData |	customerData := line substrings: {$,}.	newCustomer := self createCustomerFromDataLine: customerData.	session persist: newCustomer.	^ newCustomer! !!CustomerImport methodsFor: 'importing' stamp: 'Anonymous 11/9/2017 20:33'!createAddressFromDataLine: addressData	| newAddress |	newAddress := Address new.	newAddress streetName: addressData second.	newAddress streetNumber: addressData third asInteger.	newAddress town: addressData fourth.	newAddress zipCode: addressData fifth asInteger.	newAddress province: addressData sixth.	^ newAddress! !!CustomerImport methodsFor: 'importing' stamp: 'Anonymous 11/9/2017 20:35'!persistNewCustomerFromDataLine: line	| newCustomer customerData |	customerData := line substrings: {$,}.	newCustomer := self createCustomerFromDataLine: customerData.	session persist: newCustomer.	^ newCustomer! !!CustomerImport methodsFor: 'as yet unclassified' stamp: 'Anonymous 11/9/2017 20:37'!session: aDataBaseSession 	session := aDataBaseSession! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!CustomerImport class	instanceVariableNames: ''!!CustomerImport class methodsFor: 'importing' stamp: 'Anonymous 11/9/2017 20:33'!with: session	| ci |	ci := self new.	ci session: session.	^ci! !!CustomerImport class methodsFor: 'as yet unclassified' stamp: 'GuidoTripodi 11/9/2017 20:49'!noCustomerForAddressErrorDescription	^'Datos de entrada invalidos. No se encuentra Customer para la direccion ingresada. Muchas gracias vuelva prontos.'	! !TestCase subclass: #CustomerImporterTest	instanceVariableNames: 'session anInputStream inputStream'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-1-Model'!!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 21:08'!test04InputEmptyShouldntRaiseErrors	inputStream := self emptyInput.	self importCustomersAndAddresses.	self assertCorrectNumberOfCustomersWereImported: 0.! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 21:08'!test02verifyImportCustomerCorrectlyForReadStream	inputStream := self validDataInput.	self importCustomersAndAddresses.	self assertCorrectNumberOfCustomersWereImported: 2.	self assertCustomerPepeSanchezWasImportedCorrectly.	self assertCustomerJuanPerezWasImportedCorrectly! !!CustomerImporterTest methodsFor: 'importing' stamp: 'Anonymous 11/8/2017 19:09'!assertCustomer: aCustomer hasFirstName: aFirstName hasLastName: aLastName hasIdentificationType: aIdentificationType hasIdentificationNumber: aIdentificationNumber
	self assert: aCustomer firstName equals: aFirstName.
	self assert: aCustomer lastName equals: aLastName.
	self assert: aCustomer identificationType equals: aIdentificationType.
	self assert: aCustomer identificationNumber equals: aIdentificationNumber.
! !!CustomerImporterTest methodsFor: 'importing' stamp: 'Anonymous 11/8/2017 19:07'!assertCustomerJuanPerezWasImportedCorrectly
	| aCustomer aCustomerAddress |
	aCustomer := self
		customerAt: session
		withIdentificationNumber: '23-25666777-9'
		withIdentificationType: 'C'.
	self
		assertCustomer: aCustomer
		hasFirstName: 'Juan'
		hasLastName: 'Perez'
		hasIdentificationType: 'C'
		hasIdentificationNumber: '23-25666777-9'.
	self assert: aCustomer addresses size equals: 1.
	aCustomerAddress := aCustomer addressAt: 'Alem'.		self
		assertCustomerAddress: aCustomerAddress
		hasStreetName: 'Alem'
		hasStreetNumber: 1122
		hasTown: 'CABA'
		hasZipCode: 1001		province: 'CABA'.! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 20:41'!validDataInput	^ ReadStream		on:			'C,Pepe,Sanchez,D,22333444A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 20:38'!importCustomersAndAddresses	| importCustomer |	importCustomer := CustomerImport with: session.	importCustomer importCustomers: inputStream! !!CustomerImporterTest methodsFor: 'importing' stamp: 'Anonymous 11/8/2017 19:06'!assertCustomerPepeSanchezWasImportedCorrectly
	| aCustomer aCustomerAddress |
	aCustomer := self
		customerAt: session
		withIdentificationNumber: '22333444'
		withIdentificationType: 'D'.
	self
		assertCustomer: aCustomer
		hasFirstName: 'Pepe'
		hasLastName: 'Sanchez'
		hasIdentificationType: 'D'
		hasIdentificationNumber: '22333444'.
	self assert: aCustomer addresses size equals: 2.
	aCustomerAddress := aCustomer addressAt: 'San Martin'.
	self
		assertCustomerAddress: aCustomerAddress
		hasStreetName: 'San Martin'
		hasStreetNumber: 3322
		hasTown: 'Olivos'
		hasZipCode: 1636		province: 'BsAs'.
	aCustomerAddress := aCustomer addressAt: 'Maipu'.	self
		assertCustomerAddress: aCustomerAddress
		hasStreetName: 'Maipu'
		hasStreetNumber: 888
		hasTown: 'Florida'
		hasZipCode: 1122		province: 'Buenos Aires'.	! !!CustomerImporterTest methodsFor: 'importing' stamp: 'Anonymous 11/8/2017 18:43'!customerAt: aSession withIdentificationNumber: anIdentificationNumber withIdentificationType: anIdentificationType
	^ (aSession
		select:  
			[ :aCustomer | aCustomer identificationNumber = anIdentificationNumber and: aCustomer identificationType = anIdentificationType ]
		ofType: Customer) anyOne.		! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 20:53'!test03AddressWithNoCustomerShouldRaiseError	inputStream := self invalidDataInput1AddressOnly.self		should: [ self importCustomersAndAddresses ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noCustomerForAddressErrorDescription ]! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 20:43'!invalidDataInput1AddressOnly	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !!CustomerImporterTest methodsFor: 'importing' stamp: 'ip 11/6/2017 21:19'!tearDown
	inputStream close.
	session commit.
	session close.! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 21:08'!test01verifyImportCustomerCorrectlyForFIleStream	inputStream := FileStream		fileNamed: '/home/guido/Documentos/FACU/INGS1/pharo6.1/input.txt'.	self importCustomersAndAddresses.	self assertCorrectNumberOfCustomersWereImported: 2.	self assertCustomerPepeSanchezWasImportedCorrectly.	self assertCustomerJuanPerezWasImportedCorrectly! !!CustomerImporterTest methodsFor: 'importing' stamp: 'Anonymous 11/8/2017 19:09'!assertCustomerAddress: aCustomerAddress hasStreetName: aStreetName hasStreetNumber: aStreetNumber hasTown: aTown hasZipCode: aZipCode province: aProvince
	self assert: aCustomerAddress streetName equals: aStreetName.
	self assert: aCustomerAddress streetNumber equals: aStreetNumber.
	self assert: aCustomerAddress town equals: aTown.
	self assert: aCustomerAddress zipCode equals: aZipCode.
	self assert: aCustomerAddress province equals: aProvince.! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 20:56'!emptyInput	^ ReadStream		on:			''					! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 21:08'!assertCorrectNumberOfCustomersWereImported: aNumber
	self assert: (session selectAllOfType: Customer) size equals: aNumber 	! !!CustomerImporterTest methodsFor: 'importing' stamp: 'Anonymous 11/8/2017 18:43'!setUp
	session := DataBaseSession
		for:
			(Array
				with:
					(ClassMapping
						withDefaultTableNameFor: Address
						mappingAll:
							(Array
								with: (EmbededMapping withDefaultFieldNameFor: #streetName)
								with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
								with: (EmbededMapping withDefaultFieldNameFor: #town)
								with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
								with: (EmbededMapping withDefaultFieldNameFor: #province)))
				with:
					(ClassMapping
						withDefaultTableNameFor: Customer
						mappingAll:
							(Array
								with: (EmbededMapping withDefaultFieldNameFor: #firstName)
								with: (EmbededMapping withDefaultFieldNameFor: #lastName)
								with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
								with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
								with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address)))).
	session open.
	session beginTransaction.! !!CustomerImporterTest methodsFor: 'importing' stamp: 'GuidoTripodi 11/9/2017 21:01'!invalidDataInputFormated	^ ReadStream		on:			'C,Pepe,Sanchez,D,22333444,FloresA,San Martin,3322,Olivos,1636,BsAs,PeruA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !