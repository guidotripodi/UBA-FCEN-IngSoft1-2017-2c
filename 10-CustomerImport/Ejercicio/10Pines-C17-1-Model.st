Object subclass: #Address	instanceVariableNames: 'id streetName streetNumber town zipCode province'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Address methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 11/1/2016 10:06'!isAt: aStreetName

	^streetName = aStreetName ! !!Address methodsFor: 'zip code' stamp: 'HernanWilkinson 10/28/2016 16:13'!zipCode

	^zipCode! !!Address methodsFor: 'zip code' stamp: 'HernanWilkinson 10/28/2016 16:08'!zipCode: aZipCode
 
	zipCode := aZipCode! !!Address methodsFor: 'province' stamp: 'HernanWilkinson 10/28/2016 16:11'!province

	^province! !!Address methodsFor: 'province' stamp: 'HernanWilkinson 10/28/2016 16:08'!province: aProvince
 
	province := aProvince
	! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 16:12'!streetNumber

	^streetNumber ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 16:12'!streetName

	^streetName ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 13:27'!streetName: aStreetName
 
	streetName := aStreetName ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 13:27'!streetNumber: aStreetNumber
 
	streetNumber := aStreetNumber ! !!Address methodsFor: 'twon' stamp: 'HernanWilkinson 10/28/2016 16:12'!town

	^town! !!Address methodsFor: 'twon' stamp: 'HernanWilkinson 10/28/2016 16:07'!town: aTown
 
	town := aTown! !Object subclass: #Customer	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Customer methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 11/1/2016 18:03'!addressesIsEmpty
	
	^addresses isEmpty! !!Customer methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 11/1/2016 10:05'!addressAt: aStreetName ifNone: noneClosure 
	
	^addresses detect: [ :anAddress | anAddress isAt: aStreetName ] ifNone: noneClosure ! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 13:10'!identificationType: anIdentificationType 

	identificationType := anIdentificationType! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 16:13'!identificationNumber
	
	^identificationNumber ! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 13:10'!identificationNumber: anIdentificationNumber
 
	identificationNumber := anIdentificationNumber! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 16:13'!identificationType
	
	^identificationType ! !!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 10/28/2016 13:25'!addresses

	^ addresses! !!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 10/28/2016 13:27'!addAddress: anAddress 

	addresses add: anAddress ! !!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 11/1/2016 09:43'!numberOfAddresses
	
	^addresses size! !!Customer methodsFor: 'importing' stamp: 'ip 11/6/2017 21:19'!importCustomers: anObject
	"
	self importCustomers
	"

	test importCustomers: nil! !!Customer methodsFor: 'importing' stamp: 'ip 11/6/2017 21:53'!addressAt: aStreetName
	^ self addresses
		detect: [ :anAddress | anAddress streetName = aStreetName ]! !!Customer methodsFor: 'initialization' stamp: 'HernanWilkinson 10/28/2016 13:26'!initialize

	super initialize.
	addresses := OrderedCollection new.! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 16:15'!firstName
	
	^firstName ! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 16:15'!lastName

	^lastName ! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 13:09'!lastName: aLastName
 
	lastName := aLastName
! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 13:09'!firstName: aName
 
	firstName := aName! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Customer class	instanceVariableNames: ''!!Customer class methodsFor: 'importing' stamp: 'HernanWilkinson 11/1/2016 08:39'!importCustomers

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
		! !Object subclass: #CustomerImport	instanceVariableNames: 'line readStream session record newCustomer'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerImport methodsFor: 'initialization' stamp: 'HernanWilkinson 11/1/2016 15:40'!initializeOn: aReadStream on: aSession

	readStream := aReadStream.
	session := aSession.! !!CustomerImport methodsFor: 'importing' stamp: 'BrianBokser 11/9/2017 20:10'!parseRecord
	record := line substrings: {$,}! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:30'!importAddress	| newAddress |	self validAdress.	newAddress := Address new.	newAddress streetName: record second.	newAddress streetNumber: record third asInteger.	newAddress town: record fourth.	newAddress zipCode: record fifth asInteger.	newAddress province: record sixth.	^ newCustomer addAddress: newAddress! !!CustomerImport methodsFor: 'importing' stamp: 'HernanWilkinson 11/1/2016 17:51'!import

	[ self canImportNextLine ] whileTrue: [ 
		self convertLineToRecord.
		self importRecord ]! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 14:48'!convertLineToRecord

	record := line substrings: {$,}.! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:30'!validAdress	record size ~= 6		ifTrue: [ self signalInvalidAddressRecord ].			newCustomer		ifNil: [ ^ self error: CustomerImport noCustomerForAddressErrorDescription ].! !!CustomerImport methodsFor: 'importing' stamp: 'BrianBokser 11/9/2017 19:27'!hasLineToProcess
	line := inputStream nextLine.
	^ line notNil! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:14'!canImportNextLine
	readStream ifNil: [^ self error: CustomerImport noCustomerForAddressErrorDescription ] .
	line := readStream nextLine.
	^ line notNil! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:23'!importRecord
	
	record first = 'C' ifTrue: [ ^self importCustomer ].
	record first = 'A' ifTrue: [ ^self importAddress ].		^ self error: CustomerImport noCustomerForAddressErrorDescription.! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:30'!importCustomer
	"record ~= 5 ifTrue: [^ self error: CustomerImport noCustomerForAddressErrorDescription].	si descomento esto explota no entiendo porq 	"
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!CustomerImport class	instanceVariableNames: ''!!CustomerImport class methodsFor: 'instance creation' stamp: 'HernanWilkinson 11/1/2016 15:40'!from: aReadStream on: aSession

	^self new initializeOn: aReadStream on: aSession! !!CustomerImport class methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:02'!noCustomerForAddressErrorDescription		^'Datos de entrada invalidos. No se encuentra Customer para la direccion ingresada. Muchas gracias vuelva prontos.'! !TestCase subclass: #CustomerImportTest	instanceVariableNames: 'importer system inputStream'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerImportTest methodsFor: 'customers' stamp: 'ivanpondal 11/14/2017 19:18'!allCustomers
	^ system selectAllCustomers! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'Anonymous 11/13/2017 20:29'!addressMapping
	^ system addressMapping! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'BrianBokser 11/16/2017 12:24'!setUp
	system := Environment current newCustomerSystem.
	system start.
	system beginTransaction! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 20:30'!customerMapping
	^ system customerMapping! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 21:06'!tearDown
	system commitTransaction.
	system stop! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:41'!validTestData	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444,A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:04'!emptyInput	^ ReadStream		on:			''! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:01'!invalidDataInput1AddressOnly	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:07'!invalidDataInputFormated	^ ReadStream		on:			'C,Pepe,Sanchez,D,22333444,FloresA,San Martin,3322,Olivos,1636,BsAs,PeruA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!CustomerImportTest methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:31'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	
	^ system customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber! !!CustomerImportTest methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:35'!importCustomersFrom: aInputStream
	| customer |	customer := CustomerImport from: aInputStream on: system.	customer import! !!CustomerImportTest methodsFor: 'asserting' stamp: 'HernanWilkinson 11/1/2016 10:56'!assert: customer isNamed: firstName lastName: lastName identfiedAs: idType withNumber: idNumber andNumberOfAddresses: addressesSize

	self assert: customer firstName equals: firstName.
	self assert: customer lastName equals: lastName.
	self assert: customer identificationType equals: idType.
	self assert: customer identificationNumber equals: idNumber.
	self assert: customer numberOfAddresses equals: addressesSize .! !!CustomerImportTest methodsFor: 'asserting' stamp: 'HernanWilkinson 11/1/2016 11:00'!assert: customer hasAddressAt: streetName number: streetNumber in: town zipCode: zipCode province: province

	| address |
	
	address := customer addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !!CustomerImportTest methodsFor: 'asserting' stamp: 'ivanpondal 11/14/2017 19:19'!assertPepeSanchezWasImportedCorrectly
	| customer idType idNumber |
	idType := 'D'.
	idNumber := '22333444'.
	customer := self
		customerIdentifiedAs: idType
		numbered: idNumber.
	self
		assert: customer
		isNamed: 'Pepe'
		lastName: 'Sanchez'
		identfiedAs: idType
		withNumber: idNumber
		andNumberOfAddresses: 2.
	self
		assert: customer
		hasAddressAt: 'San Martin'
		number: 3322
		in: 'Olivos'
		zipCode: 1636
		province: 'BsAs'.
	self
		assert: customer
		hasAddressAt: 'Maipu'
		number: 888
		in: 'Florida'
		zipCode: 1122
		province: 'Buenos Aires'! !!CustomerImportTest methodsFor: 'asserting' stamp: 'ivanpondal 11/14/2017 19:21'!assertJuanPerezWasImportedCorrectly
	| customer idType idNumber |
	idType := 'C'.
	idNumber := '23-25666777-9'.
	customer := self customerIdentifiedAs: idType numbered: idNumber.
	self
		assert: customer
		isNamed: 'Juan'
		lastName: 'Perez'
		identfiedAs: idType
		withNumber: idNumber
		andNumberOfAddresses: 1.
	self
		assert: customer
		hasAddressAt: 'Alem'
		number: 1122
		in: 'CABA'
		zipCode: 1001
		province: 'CABA'! !!CustomerImportTest methodsFor: 'asserting' stamp: 'guidotriopodi 11/16/2017 15:05'!assertCorrectNumberOfCustomersWereImported: aNumber self assert: (self allCustomers) size equals: aNumber ! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:14'!test03AddressWithNoCustomerShouldRaiseError	inputStream := self invalidDataInput1AddressOnly.self		should: [ self importCustomersFrom: inputStream ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noCustomerForAddressErrorDescription ]! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:05'!test02verifyImportCustomerCorrectlyForReadStream

	self importCustomersFrom: self validTestData.

	self assertCorrectNumberOfCustomersWereImported: 2.
	self assertPepeSanchezWasImportedCorrectly.
	self assertJuanPerezWasImportedCorrectly! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:03'!test04InputEmptyShouldntRaiseErrors	self importCustomersFrom: self emptyInput.	self assertCorrectNumberOfCustomersWereImported: 0.! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:06'!test01verifyImportCustomerCorrectlyForFIleStream	inputStream := FileStream		fileNamed: '/home/guido/Documentos/FACU/INGS1/pharo6.1/input.txt'.
	self importCustomersFrom: inputStream.
	self assertCorrectNumberOfCustomersWereImported: 2.
	self assertPepeSanchezWasImportedCorrectly.
	self assertJuanPerezWasImportedCorrectly! !Object subclass: #Environment	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Environment methodsFor: 'create' stamp: 'BrianBokser 11/16/2017 12:03'!newCustomerSystem
	self subclassResponsibility.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Environment class	instanceVariableNames: ''!!Environment class methodsFor: 'accessing' stamp: 'BrianBokser 11/16/2017 12:05'!current
	| currentEnvironmentClass |
	currentEnvironmentClass := Environment allSubclasses detect: [ :anEnvirommentClass | anEnvirommentClass isCurrent  ] ifNone: [ Error signal: 'No current Environment' ].
	^ currentEnvironmentClass new.! !Environment subclass: #DevelopmentEnviroment	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!DevelopmentEnviroment methodsFor: 'create' stamp: 'guidotriopodi 11/16/2017 14:55'!newCustomerSystem
	^ TransientSystem new.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!DevelopmentEnviroment class	instanceVariableNames: ''!!DevelopmentEnviroment class methodsFor: 'testing' stamp: 'BrianBokser 11/16/2017 11:57'!isCurrent
	^ true.! !Environment subclass: #IntegrationEnvironment	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!IntegrationEnvironment methodsFor: 'create' stamp: 'guidotriopodi 11/16/2017 14:55'!newCustomerSystem
	^ PersistentSystem new.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!IntegrationEnvironment class	instanceVariableNames: ''!!IntegrationEnvironment class methodsFor: 'testing' stamp: 'BrianBokser 11/16/2017 12:02'!isCurrent
	^ false.! !Object subclass: #System	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!System methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!beginTransaction
	self subclassResponsibility! !!System methodsFor: 'setup-teardown' stamp: 'guidotriopodi 11/16/2017 15:31'!customerIdentifiedAs: anIdentificationType numbered: anIdentificationNumber
	self subclassResponsibility! !!System methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!selectAllCustomers
	self subclassResponsibility! !!System methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!start
	self subclassResponsibility! !!System methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!commitTransaction
	self subclassResponsibility! !!System methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!persist: aCustomer
	self subclassResponsibility! !!System methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!stop
	self subclassResponsibility! !System subclass: #PersistentSystem	instanceVariableNames: 'session'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!PersistentSystem methodsFor: 'setup-teardown' stamp: 'Anonymous 11/13/2017 20:29'!addressMapping
	^ ClassMapping
		withDefaultTableNameFor: Address
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #streetName)
				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
				with: (EmbededMapping withDefaultFieldNameFor: #town)
				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
				with: (EmbededMapping withDefaultFieldNameFor: #province))! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:15'!beginTransaction
	session beginTransaction! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:15'!initializeSession
	session :=
			(DataBaseSession
				for: (Array with: self addressMapping with: self customerMapping))! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 21:04'!initialize
	super initialize.
	self initializeSession.! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:15'!start
	session open! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:16'!persist: aCustomer 
	session persist: aCustomer! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:16'!commitTransaction
	session commit! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 20:30'!customerMapping
	^ ClassMapping
		withDefaultTableNameFor: Customer
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #firstName)
				with: (EmbededMapping withDefaultFieldNameFor: #lastName)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address))! !!PersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:17'!stop
	session close! !!PersistentSystem methodsFor: 'customers' stamp: 'ivanpondal 11/14/2017 19:18'!selectAllCustomers
	^ session selectAllOfType: Customer! !!PersistentSystem methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:32'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	| customers |
	customers := session
		select: [ :aCustomer | 
			aCustomer identificationType = anIdentifycationType
				and: [ aCustomer identificationNumber = anIdentificationNumber ] ]
		ofType: Customer.
	^ customers anyOne! !System subclass: #TransientSystem	instanceVariableNames: 'customers session'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!TransientSystem methodsFor: 'customers' stamp: 'ivanpondal 11/14/2017 19:26'!selectAllCustomers
	^ customers! !!TransientSystem methodsFor: 'importing' stamp: 'ip 11/13/2017 21:07'!beginTransaction! !!TransientSystem methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:32'!customerIdentifiedAs: anIdentificationType numbered: anIdentificationNumber
	| identifiedCustomers |
	identifiedCustomers := customers
		select: [ :aCustomer | 
			aCustomer identificationType = anIdentificationType
				and: [ aCustomer identificationNumber = anIdentificationNumber ] ].
	^ identifiedCustomers first! !!TransientSystem methodsFor: 'importing' stamp: 'ip 11/13/2017 21:07'!start
! !!TransientSystem methodsFor: 'importing' stamp: 'ivanpondal 11/14/2017 19:12'!commitTransaction
! !!TransientSystem methodsFor: 'importing' stamp: 'ip 11/13/2017 21:10'!persist: aCustomer 
	customers add: aCustomer! !!TransientSystem methodsFor: 'importing' stamp: 'ivanpondal 11/14/2017 19:13'!stop
! !!TransientSystem methodsFor: 'initialization' stamp: 'ip 11/13/2017 21:11'!initialize
	super initialize.
	customers := OrderedCollection new.! !