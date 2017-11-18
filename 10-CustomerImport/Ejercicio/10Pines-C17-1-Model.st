Object subclass: #Address	instanceVariableNames: 'id streetName streetNumber town zipCode province'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Address methodsFor: 'twon' stamp: 'HernanWilkinson 10/28/2016 16:07'!town: aTown 	town := aTown! !!Address methodsFor: 'twon' stamp: 'HernanWilkinson 10/28/2016 16:12'!town	^town! !!Address methodsFor: 'province' stamp: 'HernanWilkinson 10/28/2016 16:08'!province: aProvince 	province := aProvince	! !!Address methodsFor: 'province' stamp: 'HernanWilkinson 10/28/2016 16:11'!province	^province! !!Address methodsFor: 'zip code' stamp: 'HernanWilkinson 10/28/2016 16:13'!zipCode	^zipCode! !!Address methodsFor: 'zip code' stamp: 'HernanWilkinson 10/28/2016 16:08'!zipCode: aZipCode 	zipCode := aZipCode! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 16:12'!streetNumber	^streetNumber ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 16:12'!streetName	^streetName ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 13:27'!streetName: aStreetName 	streetName := aStreetName ! !!Address methodsFor: 'street' stamp: 'HernanWilkinson 10/28/2016 13:27'!streetNumber: aStreetNumber 	streetNumber := aStreetNumber ! !Object subclass: #ClassMapping	instanceVariableNames: 'mappedClass mappings tableName'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!ClassMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 11/1/2016 00:40'!map: anObject using: aDataBaseSession	| record |	self toDo: 'se puede optimizar usando array para registros y guardando definicion de tabla una vez'.	record := Dictionary new.		self mapIdOf: anObject into: record using: aDataBaseSession.	self mapEmbededOf: anObject into: record.	"agrego aca el registro y no luego de mapear el id para que lo agrege completo. Lo agrego antes de mapear las rel one to many 	porque si usuara una db de verdad habria foreign key constrain"	aDataBaseSession add: record on: self tableName.	self mapOneToManyRelationshipsOf: anObject using: aDataBaseSession! !!ClassMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 11/1/2016 00:42'!unmap: aRecord using: aDataBaseSession	| unMappedObject |	unMappedObject := mappedClass basicNew.	self unmapIdOf: aRecord into: unMappedObject.	self unmap: aRecord into: unMappedObject using: aDataBaseSession.	^ unMappedObject! !!ClassMapping methodsFor: 'initialization' stamp: 'HernanWilkinson 10/31/2016 23:25'!initializeFor: aClass into: aTableName mappingAll: aCollectionOfMappings	mappedClass := aClass.	tableName := aTableName.	mappings := aCollectionOfMappings ! !!ClassMapping methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 00:40'!mapOneToManyRelationshipsOf: anObject using: aDataBaseSession	mappings do: [ :aMapping | aMapping mapOneToManyRelationshipsOf: anObject using: aDataBaseSession ]! !!ClassMapping methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 00:40'!mapIdOf: anObject into: record using: aDataBaseSession	| newId |	newId := aDataBaseSession newIdFor: anObject.	anObject instVarNamed: #id put: newId.	record at: #id put: newId! !!ClassMapping methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 00:43'!unmap: aRecord into: unMappedObject using: aDataBaseSession	mappings do: [ :aMapping | aMapping unmap: aRecord into: unMappedObject using: aDataBaseSession ]! !!ClassMapping methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 00:43'!unmapIdOf: aRecord into: unMappedObject	unMappedObject instVarNamed: #id put: (aRecord at: #id)! !!ClassMapping methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 00:40'!mapEmbededOf: anObject into: record	mappings do: [ :aMapping | aMapping embeded: anObject into: record ]! !!ClassMapping methodsFor: 'testing' stamp: 'HernanWilkinson 10/31/2016 23:02'!isFor: aClass	^mappedClass = aClass! !!ClassMapping methodsFor: 'table' stamp: 'HernanWilkinson 10/31/2016 23:25'!tableName		^tableName ! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!ClassMapping class	instanceVariableNames: ''!!ClassMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/31/2016 23:23'!withDefaultTableNameFor: aClass mappingAll: aCollectionOfMappings	^self for: aClass into: (self defaultTableNameFor: aClass) mappingAll: aCollectionOfMappings		! !!ClassMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 11/1/2016 00:44'!defaultTableNameFor: aClass		^aClass name asString! !!ClassMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/31/2016 23:24'!for: aClass into: aTableName mappingAll: aCollectionOfMappings	self assertValidTableName: aTableName.	self assertHasIdInstanceVariable: aClass.	self assertValidMappings: aCollectionOfMappings for: aClass.		^self new initializeFor: aClass into: aTableName mappingAll: aCollectionOfMappings		! !!ClassMapping class methodsFor: 'assertions' stamp: 'HernanWilkinson 10/31/2016 19:26'!assertValidMappings: aCollectionOfMappings for: aClass 	self toDo: 'Lo mejor seria recolectar todos los erroes de mapeo y no parar en el primero'.	aCollectionOfMappings do: [ :aMapping | aMapping assertIsValidFor: aClass ]	! !!ClassMapping class methodsFor: 'assertions' stamp: 'HernanWilkinson 10/31/2016 23:41'!assertValidTableName: aTableName	aTableName trimBoth isEmpty ifTrue: [ self error: 'Table name can not be empty' ]! !!ClassMapping class methodsFor: 'assertions' stamp: 'HernanWilkinson 10/31/2016 21:15'!assertHasIdInstanceVariable: aClass 		(aClass hasInstVarNamed: #id) ifFalse: [ self error: ('<1s> has no id instance variable' expandMacrosWith: aClass name) ]! !Object subclass: #Customer	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 10/28/2016 13:27'!addAddress: anAddress 	addresses add: anAddress ! !!Customer methodsFor: 'addresses' stamp: 'HernanWilkinson 10/28/2016 13:25'!addresses	^ addresses! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 13:10'!identificationType: anIdentificationType 	identificationType := anIdentificationType! !!Customer methodsFor: 'identification' stamp: 'GUidoTripodi 11/18/2017 16:25'!addressAt: aStreetName ifNone: noneClosure 
	
	^addresses detect: [ :anAddress | anAddress streetName = aStreetName ] ifNone: noneClosure ! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 13:10'!identificationNumber: anIdentificationNumber 	identificationNumber := anIdentificationNumber! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 16:13'!identificationNumber		^identificationNumber ! !!Customer methodsFor: 'identification' stamp: 'HernanWilkinson 10/28/2016 16:13'!identificationType		^identificationType ! !!Customer methodsFor: 'initialization' stamp: 'HernanWilkinson 10/28/2016 13:26'!initialize	super initialize.	addresses := OrderedCollection new.! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 16:15'!lastName	^lastName ! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 13:09'!lastName: aLastName 	lastName := aLastName! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 16:15'!firstName		^firstName ! !!Customer methodsFor: 'name' stamp: 'HernanWilkinson 10/28/2016 13:09'!firstName: aName 	firstName := aName! !!Customer methodsFor: 'name' stamp: 'GUidoTripodi 11/18/2017 16:29'!persistInto: aSystem	aSystem persistCustomer: self.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Customer class	instanceVariableNames: ''!!Customer class methodsFor: 'importing' stamp: 'HernanWilkinson 11/1/2016 08:39'!importCustomers	"	self importCustomers	"	| inputStream session newCustomer line |		inputStream := FileStream fileNamed: 'input.txt'.	session := DataBaseSession for: (Array 		with: (ClassMapping 			withDefaultTableNameFor: Address 			mappingAll: (Array 				with: (EmbededMapping withDefaultFieldNameFor: #streetName)				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)				with: (EmbededMapping withDefaultFieldNameFor: #town)				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)				with: (EmbededMapping withDefaultFieldNameFor: #province))) 		with: (ClassMapping 			withDefaultTableNameFor: Customer 			mappingAll: (Array 				with: (EmbededMapping withDefaultFieldNameFor: #firstName)				with: (EmbededMapping withDefaultFieldNameFor: #lastName)				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address)))).	session open.	session beginTransaction.	line := inputStream nextLine.	[ line notNil ] whileTrue: [ 		(line beginsWith: 'C') ifTrue: [ | customerData |			customerData := line substrings: {$,}.			newCustomer := Customer new.			newCustomer firstName: customerData second.			newCustomer lastName: customerData third.			newCustomer identificationType: customerData fourth.			newCustomer identificationNumber: customerData fourth.			session persist: newCustomer ].				(line beginsWith: 'A') ifTrue: [ | addressData newAddress |			addressData := line substrings: { $, }.			newAddress := Address new.			newAddress streetName: addressData second.			newAddress streetNumber: addressData third asInteger. 			newAddress town: addressData fourth.			newAddress zipCode: addressData fifth asInteger.			newAddress province: addressData fourth.			newCustomer addAddress: newAddress. ].						line := inputStream nextLine. ].					session commit.		session close.				inputStream close.		! !Object subclass: #CustomerImport	instanceVariableNames: 'line readStream system record newCustomer'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerImport methodsFor: 'importing' stamp: 'guidotripodi 11/17/2017 17:07'!validAdress	record size ~= 6		ifTrue: [ self error: CustomerImport noCustomerForAddressErrorDescription ].			newCustomer		ifNil: [ ^ self error: CustomerImport noCustomerForAddressErrorDescription ].! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 14:48'!convertLineToRecord

	record := line substrings: {$,}.! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 21:37'!importAddress	| newAddress |	self validAdress.	newAddress := Address new.	newAddress streetName: record second.	newAddress streetNumber: record third asInteger.	newAddress town: record fourth.	newAddress zipCode: record fifth asInteger.	newAddress province: record sixth.	^ newCustomer addAddress: newAddress! !!CustomerImport methodsFor: 'importing' stamp: 'HernanWilkinson 11/1/2016 17:51'!import

	[ self canImportNextLine ] whileTrue: [ 
		self convertLineToRecord.
		self importRecord ]! !!CustomerImport methodsFor: 'importing' stamp: 'guidotripodi 11/17/2017 17:07'!importCustomer
	record  size ~= 5 ifTrue: [^ self error: CustomerImport noCustomerForAddressErrorDescription].	
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	system persist: newCustomer! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:23'!importRecord
	
	record first = 'C' ifTrue: [ ^self importCustomer ].
	record first = 'A' ifTrue: [ ^self importAddress ].		^ self error: CustomerImport noCustomerForAddressErrorDescription.! !!CustomerImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:14'!canImportNextLine
	readStream ifNil: [^ self error: CustomerImport noCustomerForAddressErrorDescription ] .
	line := readStream nextLine.
	^ line notNil! !!CustomerImport methodsFor: 'importing' stamp: 'BrianBokser 11/9/2017 20:10'!parseRecord
	record := line substrings: {$,}! !!CustomerImport methodsFor: 'importing' stamp: 'BrianBokser 11/9/2017 19:27'!hasLineToProcess
	line := inputStream nextLine.
	^ line notNil! !!CustomerImport methodsFor: 'initialization' stamp: 'guidotripodi 11/17/2017 17:07'!initializeFromSystem: aSystem 	system  := aSystem .! !!CustomerImport methodsFor: 'initialization' stamp: 'guidotripodi 11/17/2017 17:07'!initializeOn: aReadStream on: aSession

	readStream := aReadStream.
	system := aSession.! !!CustomerImport methodsFor: 'as yet unclassified' stamp: 'guidotripodi 11/17/2017 17:16'!importCustomerFromStream: aReadStream 	readStream := aReadStream .	self import .! !!CustomerImport methodsFor: 'as yet unclassified' stamp: 'guidotripodi 11/17/2017 17:13'!importCustomerFromRecord: aRecord	record := aRecord  .	self import .! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!CustomerImport class	instanceVariableNames: ''!!CustomerImport class methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:02'!noCustomerForAddressErrorDescription		^'Datos de entrada invalidos. No se encuentra Customer para la direccion ingresada. Muchas gracias vuelva prontos.'! !!CustomerImport class methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 21:27'!fromSystem: aSystem 	^self new initializeFromSystem: aSystem ! !!CustomerImport class methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 14:44'!noExistCustomer	^'El customer solicitado no existe.'! !!CustomerImport class methodsFor: 'instance creation' stamp: 'HernanWilkinson 11/1/2016 15:40'!from: aReadStream on: aSession

	^self new initializeOn: aReadStream on: aSession! !TestCase subclass: #CustomerImportTest	instanceVariableNames: 'importer system inputStream'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerImportTest methodsFor: 'asserting' stamp: 'guidotriopodi 11/16/2017 15:05'!assertCorrectNumberOfCustomersWereImported: aNumber self assert: (self allCustomers) size equals: aNumber ! !!CustomerImportTest methodsFor: 'asserting' stamp: 'HernanWilkinson 11/1/2016 11:00'!assert: customer hasAddressAt: streetName number: streetNumber in: town zipCode: zipCode province: province

	| address |
	
	address := customer addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !!CustomerImportTest methodsFor: 'asserting' stamp: 'ivanpondal 11/14/2017 19:21'!assertJuanPerezWasImportedCorrectly
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
		province: 'CABA'! !!CustomerImportTest methodsFor: 'asserting' stamp: 'ivanpondal 11/14/2017 19:19'!assertPepeSanchezWasImportedCorrectly
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
		province: 'Buenos Aires'! !!CustomerImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 16:23'!assert: customer isNamed: firstName lastName: lastName identfiedAs: idType withNumber: idNumber andNumberOfAddresses: addressesSize

	self assert: customer firstName equals: firstName.
	self assert: customer lastName equals: lastName.
	self assert: customer identificationType equals: idType.
	self assert: customer identificationNumber equals: idNumber.
	self assert: (customer addresses size) equals: addressesSize .! !!CustomerImportTest methodsFor: 'customers' stamp: 'ivanpondal 11/14/2017 19:18'!allCustomers
	^ system selectAllCustomers! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:05'!test02verifyImportCustomerCorrectlyForReadStream

	self importCustomersFrom: self validTestData.

	self assertCorrectNumberOfCustomersWereImported: 2.
	self assertPepeSanchezWasImportedCorrectly.
	self assertJuanPerezWasImportedCorrectly! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:06'!test01verifyImportCustomerCorrectlyForFIleStream	inputStream := FileStream		fileNamed: '/home/guido/Documentos/FACU/INGS1/pharo6.1/input.txt'.
	self importCustomersFrom: inputStream.
	self assertCorrectNumberOfCustomersWereImported: 2.
	self assertPepeSanchezWasImportedCorrectly.
	self assertJuanPerezWasImportedCorrectly! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:03'!test04InputEmptyShouldntRaiseErrors	self importCustomersFrom: self emptyInput.	self assertCorrectNumberOfCustomersWereImported: 0.! !!CustomerImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 15:14'!test03AddressWithNoCustomerShouldRaiseError	inputStream := self invalidDataInput1AddressOnly.self		should: [ self importCustomersFrom: inputStream ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noCustomerForAddressErrorDescription ]! !!CustomerImportTest methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:35'!importCustomersFrom: aInputStream
	| customer |	customer := CustomerImport from: aInputStream on: system.	customer import! !!CustomerImportTest methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:31'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	
	^ system customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'BrianBokser 11/16/2017 12:24'!setUp
	system := Environment current newCustomerSystem.
	system start.
	system beginTransaction! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'Anonymous 11/13/2017 20:29'!addressMapping
	^ system addressMapping! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 20:30'!customerMapping
	^ system customerMapping! !!CustomerImportTest methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 21:06'!tearDown
	system commitTransaction.
	system stop! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:01'!invalidDataInput1AddressOnly	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:07'!invalidDataInputFormated	^ ReadStream		on:			'C,Pepe,Sanchez,D,22333444,FloresA,San Martin,3322,Olivos,1636,BsAs,PeruA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:41'!validTestData	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444,A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!CustomerImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 15:04'!emptyInput	^ ReadStream		on:			''! !Object subclass: #CustomerSystem	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 14:11'!findCustomerByType: aType andIdentification: aIndentification
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 15:18'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber 
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!commitTransaction
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 15:30'!persistObject: aPersistableObject 
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!selectAllCustomers
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!start
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'guidotriopodi 11/16/2017 15:31'!customerIdentifiedAs: anIdentificationType numbered: anIdentificationNumber
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!beginTransaction
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!persist: aCustomer
	self subclassResponsibility! !!CustomerSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:28'!stop
	self subclassResponsibility! !CustomerSystem subclass: #CustomerPersistentSystem	instanceVariableNames: 'session'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerPersistentSystem methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:32'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	| customers |
	customers := session
		select: [ :aCustomer | 
			aCustomer identificationType = anIdentifycationType
				and: [ aCustomer identificationNumber = anIdentificationNumber ] ]
		ofType: Customer.
	^ customers anyOne! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 16:49'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber 	| suppliers |
	suppliers := session
		select: [ :aSupplier | 
			aSupplier identificationType = anIdentifycationType
				and: [ aSupplier identificationNumber = anIdentificationNumber ] ]
		ofType: Customer.
	^ suppliers anyOne! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 16:52'!findCustomerByType: aType andIdentification: aIndentification	^ self customerIdentifiedAs: aType  numbered: aIndentification . ! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:16'!commitTransaction
	session commit! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 21:04'!initialize
	super initialize.
	self initializeSession.! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ip 11/13/2017 20:30'!customerMapping
	^ ClassMapping
		withDefaultTableNameFor: Customer
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #firstName)
				with: (EmbededMapping withDefaultFieldNameFor: #lastName)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address))! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 16:38'!initializeSession
	session :=
			(DataBaseSession
				for: (Array with: self addressMapping with: self customerMapping with: self supplierMapping  ))! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 16:47'!persistObject: aPersistableObject 		self persist: aPersistableObject .! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'Anonymous 11/13/2017 20:29'!addressMapping
	^ ClassMapping
		withDefaultTableNameFor: Address
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #streetName)
				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
				with: (EmbededMapping withDefaultFieldNameFor: #town)
				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
				with: (EmbededMapping withDefaultFieldNameFor: #province))! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:15'!start
	session open! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 16:02'!supplierMapping
	^ ClassMapping
		withDefaultTableNameFor: Supplier 
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #name)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address)				with: (OneToManyMapping withDefaultFieldNameFor: #customers ofType: Customer))! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:15'!beginTransaction
	session beginTransaction! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:16'!persist: aCustomer 
	session persist: aCustomer! !!CustomerPersistentSystem methodsFor: 'setup-teardown' stamp: 'ivanpondal 11/14/2017 19:17'!stop
	session close! !!CustomerPersistentSystem methodsFor: 'customers' stamp: 'ivanpondal 11/14/2017 19:18'!selectAllCustomers
	^ session selectAllOfType: Customer! !CustomerSystem subclass: #CustomerTransientSystem	instanceVariableNames: 'customers session suppliers'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!CustomerTransientSystem methodsFor: 'customers' stamp: 'GUidoTripodi 11/18/2017 14:43'!findCustomerByType: aType andIdentification: aIndentification
		| collectionCustomer |	collectionCustomer := OrderedCollection new.	collectionCustomer := ( customers select:[:customer | customer identificationType = aType and: ( customer identificationNumber = aIndentification )]).	collectionCustomer isEmpty ifFalse: [ ^(collectionCustomer first) ] ifTrue: [^ self error: CustomerImport noExistCustomer].! !!CustomerTransientSystem methodsFor: 'customers' stamp: 'ivanpondal 11/14/2017 19:26'!selectAllCustomers
	^ customers! !!CustomerTransientSystem methodsFor: 'initialization' stamp: 'GUidoTripodi 11/18/2017 15:20'!initialize
	super initialize.
	customers := OrderedCollection new.	suppliers := OrderedCollection new.! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 15:33'!persistCustomer: aCustomer 
	customers add: aCustomer! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'ivanpondal 11/14/2017 19:12'!commitTransaction
! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'ip 11/13/2017 21:07'!start
! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 15:32'!persistObject: aPersistableObject 
	"customers add: aCustomer"	aPersistableObject persistInto: self.! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'ip 11/13/2017 21:07'!beginTransaction! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'ip 11/13/2017 21:10'!persist: aCustomer 
	customers add: aCustomer! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 15:32'!customerIdentifiedAs: anIdentificationType numbered: anIdentificationNumber
	| identifiedCustomers |
	identifiedCustomers := customers
		select: [ :aCustomer | 
			aCustomer identificationType = anIdentificationType
				and: [ aCustomer identificationNumber = anIdentificationNumber ] ].
	^ identifiedCustomers first! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'ivanpondal 11/14/2017 19:13'!stop
! !!CustomerTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 15:33'!persistSupplier: aSupplier 
	suppliers  add: aSupplier! !!CustomerTransientSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 15:55'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber	| identifiedSuppliers |	identifiedSuppliers := suppliers		select: [ :aSupplier | aSupplier identificationType = anIdentifycationType and: 			aSupplier identificationNumber				= anIdentificationNumber. ].	^ identifiedSuppliers first! !Object subclass: #DataBaseSession	instanceVariableNames: 'configuration tables id cache'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!DataBaseSession methodsFor: 'persistence - private' stamp: 'HernanWilkinson 10/28/2016 16:35'!defineIdOf: anObject	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !!DataBaseSession methodsFor: 'persistence - private' stamp: 'HernanWilkinson 10/28/2016 16:41'!delay	(Delay forMilliseconds: 100) wait! !!DataBaseSession methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 01:16'!unmapRecordIdentifiedAs: anId ofType: aClass	| record table mapper |	mapper := self mapperFor: aClass.	table := self tableNamed: mapper tableName.	record := table at: id ifAbsent: [ self error: ('Object identified as <1s> does not exist' expandMacrosWith: anId printString) ].		^ mapper unmap: record using: self! !!DataBaseSession methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 01:14'!mapperFor: aClass	self toDo: 'se puede mejorar performanco usando un dictionary'.	^configuration		detect: [ :aClassMapper | aClassMapper isFor: aClass ] 		ifNone: [ self error: ('There is no mapper for <1s>' expandMacrosWith: aClass name) ]! !!DataBaseSession methodsFor: 'mapping - private' stamp: 'HernanWilkinson 11/1/2016 01:15'!relatedOfType: aRelatedClass for: anOwner	| table relatedIds |		table := self relationTableFor: anOwner class relatedTo: aRelatedClass.	relatedIds := table at: (self idOf: anOwner) ifAbsent: [ ^#() ].		^relatedIds collect: [ :aRelatedId | self objectIdentifiedAs: aRelatedId ofType: aRelatedClass ]		! !!DataBaseSession methodsFor: 'selecting' stamp: 'HernanWilkinson 10/31/2016 22:17'!selectAllOfType: aClass 		^self select: [ :anObject | true ] ofType: aClass! !!DataBaseSession methodsFor: 'selecting' stamp: 'HernanWilkinson 11/1/2016 01:15'!objectIdentifiedAs: anId ofType: aClass	self assertInTransaction.	self delay.		^ cache at: anId ifAbsentPut: [ self unmapRecordIdentifiedAs: anId ofType: aClass ]! !!DataBaseSession methodsFor: 'selecting' stamp: 'HernanWilkinson 11/1/2016 01:26'!select: aCondition ofType: aClass	| mapper table |	self assertInTransaction.	self delay.		mapper := self mapperFor: aClass.	table := tables at: mapper tableName ifAbsent: [ ^ #() ].		^ table inject: OrderedCollection new into: [ :selected :record | self addInto: selected theOnesThatHold: aCondition unmapping: record with: mapper ]! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:27'!addToCache: anObject 	cache at: (self idOf: anObject) put: anObject ! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:03'!add: aRecord on: aTableName	| table existingRecord |	table := self tableNamed: aTableName.	existingRecord := table at: (self recordId: aRecord) ifAbsentPut: [ aRecord ].	existingRecord == aRecord ifFalse: [ self error: 'Duplicated primary key' ]! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:06'!relatedIdOwnedBy: anOwner on: table	^ table at: (self idOf: anOwner) ifAbsentPut: [ Set new ]! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:00'!signalRelationAlreadyExistBetween: anOwner and: aRelated 	self error: ('Relation between id <1s> of type <2s> and id <3s> of type <4s> already exist'		expandMacrosWith: (self idOf: anOwner) printString		with: anOwner class name		with: (self idOf: aRelated) printString		with: aRelated class name)! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:10'!relatedIdsOwnedBy: anOwner forType: aRelatedClass	| relatedIds table |	table := self relationTableFor: anOwner class relatedTo: aRelatedClass.	relatedIds := self relatedIdOwnedBy: anOwner on: table.		^ relatedIds! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:05'!assertRelationOwnedBy: anOwner isUniqueFor: aRelated identifiedAs: relatedId in: relatedIds	(relatedIds includes: relatedId) ifTrue: [ self signalRelationAlreadyExistBetween: anOwner and: aRelated ]! !!DataBaseSession methodsFor: 'adding - private' stamp: 'HernanWilkinson 11/1/2016 01:03'!addRelated: aRelated ownedBy: anOwner	| relatedIds relatedId |	relatedIds := self relatedIdsOwnedBy: anOwner forType: aRelated class.	relatedId := aRelated instVarNamed: #id.	self assertRelationOwnedBy: anOwner isUniqueFor: aRelated identifiedAs: relatedId in: relatedIds.		relatedIds add: relatedId! !!DataBaseSession methodsFor: 'transaction management' stamp: 'HernanWilkinson 10/31/2016 22:55'!assertNotInTransasction		cache notNil ifTrue: [ self error: 'There is an open transaction already' ]! !!DataBaseSession methodsFor: 'transaction management' stamp: 'HernanWilkinson 10/31/2016 22:55'!assertInTransaction		cache isNil ifTrue: [ self error: 'There is no transaction currently' ]! !!DataBaseSession methodsFor: 'transaction management' stamp: 'HernanWilkinson 10/31/2016 22:57'!beginTransaction	self assertIsOpen.	self assertNotInTransasction.		cache := WeakKeyDictionary new.	! !!DataBaseSession methodsFor: 'transaction management' stamp: 'HernanWilkinson 10/31/2016 22:57'!commit		self assertInTransaction.		cache := nil! !!DataBaseSession methodsFor: 'persistance' stamp: 'HernanWilkinson 11/1/2016 01:28'!persist: anObject	| mapper |		self assertInTransaction.	self delay.		mapper := self mapperFor: anObject class.	mapper map: anObject using: self.		self addToCache: anObject ! !!DataBaseSession methodsFor: 'id' stamp: 'HernanWilkinson 10/28/2016 16:35'!newIdFor: anObject	id := id + 1.	^id! !!DataBaseSession methodsFor: 'id' stamp: 'HernanWilkinson 11/1/2016 01:04'!recordId: aRecord	^aRecord at: #id! !!DataBaseSession methodsFor: 'id' stamp: 'HernanWilkinson 11/1/2016 01:00'!idOf: anObject	^anObject instVarNamed: #id! !!DataBaseSession methodsFor: 'initialization' stamp: 'HernanWilkinson 10/31/2016 22:55'!initializeFor: aConfiguration	configuration := aConfiguration.	id := 0.	tables := nil.	cache := nil.! !!DataBaseSession methodsFor: 'selecting - private' stamp: 'HernanWilkinson 11/1/2016 01:28'!addInto: selected theOnesThatHold: aCondition unmapping: record with: mapper	| recordId aClassInstance |	recordId := self recordId: record.	aClassInstance := cache at: recordId ifAbsent: [ mapper unmap: record using: self ].	(aCondition value: aClassInstance) ifTrue: [ 		self addToCache: aClassInstance.		selected add: aClassInstance ].		^ selected! !!DataBaseSession methodsFor: 'tables - private' stamp: 'HernanWilkinson 11/1/2016 01:12'!relationTableNameOwnedBy: anOwnerClass relatedTo: aRelatedClass	| ownerClassMapper relatedClassMapper |		ownerClassMapper := self mapperFor: anOwnerClass.	relatedClassMapper := self mapperFor: aRelatedClass.		^ownerClassMapper tableName,'_', relatedClassMapper tableName asPlural.! !!DataBaseSession methodsFor: 'tables - private' stamp: 'HernanWilkinson 11/1/2016 01:12'!relationTableFor: anOwnerClass relatedTo: aRelatedClass	| relationTableName table |	relationTableName := self relationTableNameOwnedBy: anOwnerClass relatedTo: aRelatedClass.	table := self tableNamed: relationTableName.		^ table! !!DataBaseSession methodsFor: 'tables - private' stamp: 'HernanWilkinson 11/1/2016 00:48'!tableNamed: aTableName	^ tables at: aTableName ifAbsentPut: [ Dictionary new ]! !!DataBaseSession methodsFor: 'open/close' stamp: 'HernanWilkinson 10/31/2016 18:37'!assertIsClose		tables isNil ifFalse: [ self error: 'Session must be close' ]! !!DataBaseSession methodsFor: 'open/close' stamp: 'HernanWilkinson 10/31/2016 22:14'!close	self assertIsOpen.		tables := nil! !!DataBaseSession methodsFor: 'open/close' stamp: 'HernanWilkinson 10/31/2016 18:36'!assertIsOpen		tables isNil ifTrue: [ self error: 'Session must be open to colaborate with it' ]! !!DataBaseSession methodsFor: 'open/close' stamp: 'HernanWilkinson 10/31/2016 18:36'!open	self assertIsClose.		tables := Dictionary new.	! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!DataBaseSession class	instanceVariableNames: ''!!DataBaseSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/28/2016 13:07'!for: aConfiguration	^self new initializeFor: aConfiguration! !Object subclass: #Environment	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Environment methodsFor: 'create' stamp: 'BrianBokser 11/16/2017 12:03'!newCustomerSystem
	self subclassResponsibility.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Environment class	instanceVariableNames: ''!!Environment class methodsFor: 'accessing' stamp: 'BrianBokser 11/16/2017 12:05'!current
	| currentEnvironmentClass |
	currentEnvironmentClass := Environment allSubclasses detect: [ :anEnvirommentClass | anEnvirommentClass isCurrent  ] ifNone: [ Error signal: 'No current Environment' ].
	^ currentEnvironmentClass new.! !Environment subclass: #DevelopmentEnviroment	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!DevelopmentEnviroment methodsFor: 'create' stamp: 'GUidoTripodi 11/18/2017 17:28'!newCustomerSystem
	^ CustomerTransientSystem new.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!DevelopmentEnviroment class	instanceVariableNames: ''!!DevelopmentEnviroment class methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:20'!isCurrent
	^ true.! !Object subclass: #ErpImport	instanceVariableNames: 'lines readStream session records newCustomer customerImporter input supplierImporter system'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!ErpImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:52'!convertLineToRecord
	lines := readStream nextLine.
	records := lines substrings: {$,}.! !!ErpImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 18:09'!import
			lines := readStream nextLine.
	records := lines substrings: {$,}.
		records first = 'S' ifTrue: [supplierImporter importSupplierFromStream: input] ifFalse: [ customerImporter importCustomerFromStream: input]. ! !!ErpImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:44'!canImportNextLine
	readStream ifNil: [^ self error: ErpImport  noCustomerForAddressErrorDescription ] .
	lines := readStream nextLine.
	^ lines notNil! !!ErpImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:40'!hasLineToProcess
	lines := readStream  nextLine.
	^ lines notNil! !!ErpImport methodsFor: 'initialization' stamp: 'GUidoTripodi 11/18/2017 18:09'!initializeOn: aReadStream on: aSystem

	readStream := aReadStream.	input := aReadStream .
	system := aSystem.	customerImporter := CustomerImport fromSystem: aSystem . 	supplierImporter := SupplierImport fromSystem: aSystem . ! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!ErpImport class	instanceVariableNames: ''!!ErpImport class methodsFor: 'instance creation' stamp: 'guidotriopodi 11/16/2017 21:21'!from: aReadStream on: aSession

	^self new initializeOn: aReadStream on: aSession! !!ErpImport class methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 21:21'!noCustomerForAddressErrorDescription		^'Datos de entrada invalidos. No se encuentra Customer para la direccion ingresada. Muchas gracias vuelva prontos.'! !TestCase subclass: #ErpImportTest	instanceVariableNames: 'importer system inputStream'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!ErpImportTest methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:29'!setUp
	system := Environment current newCustomerSystem.
	system start.
	system beginTransaction! !!ErpImportTest methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:29'!addressMapping
	^ system addressMapping! !!ErpImportTest methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:29'!customerMapping
	^ system customerMapping! !!ErpImportTest methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:29'!tearDown
	system commitTransaction.
	system stop! !!ErpImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 17:29'!assert: supplier hasAddressAt: streetName number: streetNumber in: town zipCode: zipCode province: province

	| address |
	
	address := supplier addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !!ErpImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 17:29'!assertCorrectNumberOfCustomersWereImported: aNumber self assert: (self allCustomers) size equals: aNumber ! !!ErpImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 17:29'!assertPepeSanchezWasImportedCorrectly
	| customer supplier |
	customer := self
		customerIdentifiedAs: 'D'
		numbered: '22333444'.	supplier := self supplierIdentifiedAs: 'D'
		numbered: '123'.
	self
		assert: customer
		isNamed: 'Pepe'
		lastName: 'Sanchez'
		identfiedAs: 'D'
		withNumber: '22333444'
		andNumberOfAddresses: 0.
	self
		assert: supplier
		hasAddressAt: 'San Martin'
		number: 3322
		in: 'Olivos'
		zipCode: 1636
		province: 'BsAs'.
	self
		assert: supplier
		hasAddressAt: 'Maipu'
		number: 888
		in: 'Florida'
		zipCode: 1122
		province: 'Buenos Aires'! !!ErpImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 17:29'!assert: customer isNamed: firstName lastName: lastName identfiedAs: idType withNumber: idNumber andNumberOfAddresses: addressesSize

	self assert: customer firstName equals: firstName.
	self assert: customer lastName equals: lastName.
	self assert: customer identificationType equals: idType.
	self assert: customer identificationNumber equals: idNumber.
	self assert: (customer addresses size) equals: addressesSize .! !!ErpImportTest methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:29'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	
	^ system customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber! !!ErpImportTest methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:30'!importERPFrom: aInputStream
	| erpImporter |	erpImporter := ErpImport  from: aInputStream on: system.	erpImporter import! !!ErpImportTest methodsFor: 'customers' stamp: 'GUidoTripodi 11/18/2017 17:29'!allCustomers
	^ system selectAllCustomers! !!ErpImportTest methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:30'!test02verifyImportCustomerCorrectlyForReadStream

	self importERPFrom:  self validTestData.

	self assertCorrectNumberOfCustomersWereImported: 2.
	self assertPepeSanchezWasImportedCorrectly.! !!ErpImportTest methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:30'!test05CustomerNoExistImposibleImporter	inputStream := self dataInputCustomerNonExist.self		should: [ self importERPFrom:  inputStream ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noExistCustomer ]! !!ErpImportTest methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:30'!test04InputEmptyShouldntRaiseErrors	self importERPFrom:  self emptyInput.	self assertCorrectNumberOfCustomersWereImported: 0.! !!ErpImportTest methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:30'!test03AddressWithNoCustomerShouldRaiseError	inputStream := self invalidDataInput1AddressOnly.self		should: [ self importERPFrom:  inputStream ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noCustomerForAddressErrorDescription ]! !!ErpImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:29'!invalidDataInput1AddressOnly	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !!ErpImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:29'!invalidDataInputFormated	^ ReadStream		on:			'C,Pepe,Sanchez,D,22333444,FloresA,San Martin,3322,Olivos,1636,BsAs,PeruA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!ErpImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:29'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber 	^ system supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber! !!ErpImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:29'!emptyInput	^ ReadStream		on:			''! !!ErpImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:29'!validTestData	^ ReadStream on: 'S,Supplier1,D,123NC,Pepe,Sanchez,D,22333444NC,Arturo,Sanchez,D,12345EC,D,12345A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos Aires'! !!ErpImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:29'!dataInputCustomerNonExist	^ ReadStream on: 'S,Supplier1,D,123 NC,Pepe,Sanchez,D,22333444EC,D,5456774A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos Aires'! !Environment subclass: #IntegrationEnvironment	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!IntegrationEnvironment methodsFor: 'create' stamp: 'GUidoTripodi 11/18/2017 17:28'!newCustomerSystem
	^ CustomerPersistentSystem new.! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!IntegrationEnvironment class	instanceVariableNames: ''!!IntegrationEnvironment class methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:20'!isCurrent
	^ false.! !Object subclass: #Mapping	instanceVariableNames: 'instanceVariableName'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Mapping methodsFor: 'assertions' stamp: 'HernanWilkinson 11/1/2016 01:31'!assertIsValidFor: aClass 	(aClass hasInstVarNamed: instanceVariableName) ifFalse: [ 		self error: ('Invalid mapping for <1s> in class <2s>' expandMacrosWith: instanceVariableName with: aClass name) ] ! !!Mapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 23:26'!mapOneToManyRelationshipsOf: anObject using: aDataBaseSession	self subclassResponsibility! !!Mapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 23:26'!embeded: anObject into: aRecord	self subclassResponsibility! !!Mapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 23:26'!unmap: aRecord into: anObject using: aDataBaseSession	self subclassResponsibility! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Mapping class	instanceVariableNames: ''!!Mapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 11/1/2016 01:32'!defaultFieldNameFor: anInstanceVariableName	^anInstanceVariableName asString! !!Mapping class methodsFor: 'assertions' stamp: 'HernanWilkinson 10/31/2016 23:41'!assertValidFieldName: aFieldName	aFieldName trimBoth isEmpty ifTrue: [ self error: 'Field name can not be empty' ]! !Mapping subclass: #EmbededMapping	instanceVariableNames: 'fieldName'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!EmbededMapping methodsFor: 'initialization' stamp: 'HernanWilkinson 10/31/2016 23:30'!initializeFor: anInstanceVariableName into: aFieldName	instanceVariableName := anInstanceVariableName.	fieldName := aFieldName ! !!EmbededMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 21:23'!mapOneToManyRelationshipsOf: anObject using: aDataBaseSession 		! !!EmbededMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 23:31'!embeded: anObject into: aRecord	aRecord at: fieldName put: (anObject instVarNamed: instanceVariableName) ! !!EmbededMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 23:31'!unmap: aRecord into: anObject using: aDataBaseSession 	anObject instVarNamed: instanceVariableName put: (aRecord at: fieldName)! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!EmbededMapping class	instanceVariableNames: ''!!EmbededMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/31/2016 23:30'!for: anInstanceVariableName into: aFieldName	^self new initializeFor: anInstanceVariableName into: aFieldName ! !!EmbededMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/31/2016 23:29'!withDefaultFieldNameFor: anInstanceVariableName	^self for: anInstanceVariableName into: (self defaultFieldNameFor: anInstanceVariableName)! !Mapping subclass: #OneToManyMapping	instanceVariableNames: 'relatedType fieldName'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!OneToManyMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 11/1/2016 01:37'!unmap: aRecord into: anObject using: aDataBaseSession	| newCollection related |	related := aDataBaseSession relatedOfType: relatedType for: anObject.	newCollection := self createRelationCollectionOn: aDataBaseSession ownedBy: anObject.	newCollection addAllNotPersisting: related.	anObject instVarNamed: instanceVariableName put: newCollection! !!OneToManyMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 11/1/2016 01:35'!createRelationCollectionOn: aDataBaseSession ownedBy: anObject	^ OneToManySet on: aDataBaseSession ownedBy: anObject! !!OneToManyMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 10/31/2016 21:16'!embeded: anObject into: aRecord	! !!OneToManyMapping methodsFor: 'mapping' stamp: 'HernanWilkinson 11/1/2016 01:37'!mapOneToManyRelationshipsOf: anObject using: aDataBaseSession	| oldCollection newCollection |	newCollection := self createRelationCollectionOn: aDataBaseSession ownedBy: anObject.	oldCollection := anObject instVarNamed: instanceVariableName.		newCollection addAll: oldCollection.	anObject instVarNamed: instanceVariableName put: newCollection! !!OneToManyMapping methodsFor: 'initialization' stamp: 'HernanWilkinson 10/31/2016 23:34'!initializeFor: anInstanceVariableName into: aFieldName ofType: aClass	instanceVariableName := anInstanceVariableName.	fieldName := aFieldName.	relatedType := aClass ! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!OneToManyMapping class	instanceVariableNames: ''!!OneToManyMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/31/2016 23:32'!withDefaultFieldNameFor: anInstanceVariableName ofType: aClass	^self for: anInstanceVariableName into: (self defaultFieldNameFor: anInstanceVariableName) ofType: aClass! !!OneToManyMapping class methodsFor: 'instance creation' stamp: 'HernanWilkinson 10/31/2016 23:40'!for: anInstanceVariableName into: aFieldName ofType: aClass	self assertValidFieldName: aFieldName.		^self new initializeFor: anInstanceVariableName into: aFieldName ofType: aClass! !Set subclass: #OneToManySet	instanceVariableNames: 'session owner'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!OneToManySet methodsFor: 'adding' stamp: 'HernanWilkinson 11/1/2016 00:03'!addAllNotPersisting: aCollection 		^aCollection do: [ :anObjectToAdd | super add: anObjectToAdd ]! !!OneToManySet methodsFor: 'adding' stamp: 'HernanWilkinson 11/1/2016 00:11'!add: anObject	session persist: anObject.	session addRelated: anObject ownedBy: owner.		super add: anObject.! !!OneToManySet methodsFor: 'initialization' stamp: 'HernanWilkinson 11/1/2016 00:11'!initializeOn: aDataBaseSession ownedBy: anOwner		session := aDataBaseSession.	owner := anOwner ! !!OneToManySet methodsFor: 'removing' stamp: 'HernanWilkinson 10/31/2016 21:35'!remove: anObject ifAbsent: anAbsentBlock	self shouldBeImplemented ! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!OneToManySet class	instanceVariableNames: ''!!OneToManySet class methodsFor: 'instance creation' stamp: 'HernanWilkinson 11/1/2016 00:11'!on: aDataBaseSession ownedBy: anOwner		^self new initializeOn: aDataBaseSession ownedBy: anOwner ! !Object subclass: #Supplier	instanceVariableNames: 'id name identificationType identificationNumber addresses customers'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!Supplier methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 13:59'!identificationType: aType 	identificationType := aType .! !!Supplier methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 13:59'!name: aName 	name := aName .! !!Supplier methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 14:00'!identificationNumber: aNumber 	identificationNumber := aNumber .! !!Supplier methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 14:02'!identificationNumber	^ identificationNumber! !!Supplier methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 14:01'!identificationType	^ identificationType! !!Supplier methodsFor: 'adding' stamp: 'GUidoTripodi 11/18/2017 15:03'!addAddress: anAddress 

	addresses add: anAddress ! !!Supplier methodsFor: 'adding' stamp: 'GUidoTripodi 11/18/2017 15:09'!addresses
	^addresses ! !!Supplier methodsFor: 'adding' stamp: 'GUidoTripodi 11/18/2017 15:03'!addCustomer: aCustomer 

	customers add: aCustomer . ! !!Supplier methodsFor: 'adding' stamp: 'GUidoTripodi 11/18/2017 16:29'!addressAt: aStreetName ifNone: noneClosure 
	
	^addresses detect: [ :anAddress | anAddress streetName = aStreetName ] ifNone: noneClosure ! !!Supplier methodsFor: 'initialization' stamp: 'GUidoTripodi 11/18/2017 15:02'!initialize	addresses := OrderedCollection new.	customers := OrderedCollection new.! !!Supplier methodsFor: 'addresses' stamp: 'GUidoTripodi 11/18/2017 15:32'!persistInto: aSystem	aSystem persistSupplier: self.! !Object subclass: #SupplierImport	instanceVariableNames: 'line readStream session record newCustomer system newSupplier'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!SupplierImport methodsFor: 'adding' stamp: 'GUidoTripodi 11/18/2017 17:13'!addExistCustomer	newCustomer := system  findCustomerByType: record second  andIdentification: record third .	newSupplier addCustomer: newCustomer.! !!SupplierImport methodsFor: 'initialization' stamp: 'GUidoTripodi 11/18/2017 13:56'!initializeOn: aReadStream on: aSession

	readStream := aReadStream.
	system := aSession.! !!SupplierImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!validAdress	record size ~= 6		ifTrue: [ self signalInvalidAddressRecord ].			newCustomer		ifNil: [ ^ self error: CustomerImport noCustomerForAddressErrorDescription ].! !!SupplierImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!convertLineToRecord

	record := line substrings: {$,}.! !!SupplierImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 15:04'!importAddress	| newAddress |	self validAdress.	newAddress := Address new.	newAddress streetName: record second.	newAddress streetNumber: record third asInteger.	newAddress town: record fourth.	newAddress zipCode: record fifth asInteger.	newAddress province: record sixth.	^ newSupplier addAddress: newAddress! !!SupplierImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!import

	[ self canImportNextLine ] whileTrue: [ 
		self convertLineToRecord.
		self importRecord ]! !!SupplierImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 16:59'!importRecord
			record first = 'S' ifTrue: [ ^self importSupplier ].	record first = 'NC' ifTrue: [ ^self importCustomer ].
	record first = 'EC' ifTrue: [ ^self addExistCustomer ].
	record first = 'A' ifTrue: [ ^self importAddress ].		^ self error: SupplierImport noCustomerForAddressErrorDescription.! !!SupplierImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:22'!importCustomer
	record size ~= 5 ifTrue: [^ self error: CustomerImport noCustomerForAddressErrorDescription].
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	system persistObject:  newCustomer.	newSupplier addCustomer: newCustomer .! !!SupplierImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!canImportNextLine
	readStream ifNil: [^ self error: CustomerImport noCustomerForAddressErrorDescription ] .
	line := readStream nextLine.
	^ line notNil! !!SupplierImport methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 18:02'!importSupplierFromStream: aReadStream

	readStream := aReadStream .		self import.! !!SupplierImport methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!hasLineToProcess
	line := inputStream nextLine.
	^ line notNil! !!SupplierImport methodsFor: 'as yet unclassified' stamp: 'guidotripodi 11/17/2017 17:18'!initializeFromSystem: aSystem 	system := aSystem .! !!SupplierImport methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 15:34'!importSupplier	record  size ~= 4 ifTrue: [^ self error: SupplierImport  noCustomerForAddressErrorDescription].	
	newSupplier := Supplier new.
	newSupplier name: record second.
	newSupplier identificationType: record third.
	newSupplier identificationNumber: record fourth.
	system persistObject:  newSupplier! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!SupplierImport class	instanceVariableNames: ''!!SupplierImport class methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 20:40'!noCustomerForAddressErrorDescription		^'Datos de entrada invalidos. No se encuentra Customer para la direccion ingresada. Muchas gracias vuelva prontos.'! !!SupplierImport class methodsFor: 'as yet unclassified' stamp: 'guidotripodi 11/17/2017 17:18'!fromSystem: aSystem 	^self new initializeFromSystem: aSystem ! !!SupplierImport class methodsFor: 'instance creation' stamp: 'guidotriopodi 11/16/2017 20:40'!from: aReadStream on: aSession

	^self new initializeOn: aReadStream on: aSession! !TestCase subclass: #SupplierImportTest	instanceVariableNames: 'importer system inputStream'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!SupplierImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 20:43'!test03AddressWithNoCustomerShouldRaiseError	inputStream := self invalidDataInput1AddressOnly.self		should: [ self importSupplierFrom:  inputStream ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noCustomerForAddressErrorDescription ]! !!SupplierImportTest methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 17:02'!test02verifyImportCustomerCorrectlyForReadStream

	self importSupplierFrom:  self validTestData.

	self assertCorrectNumberOfCustomersWereImported: 2.
	self assertPepeSanchezWasImportedCorrectly.! !!SupplierImportTest methodsFor: 'testing' stamp: 'guidotriopodi 11/16/2017 20:43'!test04InputEmptyShouldntRaiseErrors	self importSupplierFrom:  self emptyInput.	self assertCorrectNumberOfCustomersWereImported: 0.! !!SupplierImportTest methodsFor: 'testing' stamp: 'GUidoTripodi 11/18/2017 14:52'!test05CustomerNoExistImposibleImporter	inputStream := self dataInputCustomerNonExist.self		should: [ self importSupplierFrom:  inputStream ]		raise: Error		withExceptionDo: [ :anError |			self assert: anError messageText = CustomerImport noExistCustomer ]! !!SupplierImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 20:40'!invalidDataInput1AddressOnly	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !!SupplierImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 20:40'!invalidDataInputFormated	^ ReadStream		on:			'C,Pepe,Sanchez,D,22333444,FloresA,San Martin,3322,Olivos,1636,BsAs,PeruA,Maipu,888,Florida,1122,Buenos AiresC,Juan,Perez,C,23-25666777-9A,Alem,1122,CABA,1001,CABA'! !!SupplierImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 15:17'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber 	^ system supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber! !!SupplierImportTest methodsFor: 'as yet unclassified' stamp: 'guidotriopodi 11/16/2017 20:40'!emptyInput	^ ReadStream		on:			''! !!SupplierImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 17:15'!validTestData	^ ReadStream on: 'S,Supplier1,D,123NC,Pepe,Sanchez,D,22333444NC,Arturo,Sanchez,D,12345EC,D,12345A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos Aires'! !!SupplierImportTest methodsFor: 'as yet unclassified' stamp: 'GUidoTripodi 11/18/2017 14:52'!dataInputCustomerNonExist	^ ReadStream on: 'S,Supplier1,D,123 NC,Pepe,Sanchez,D,22333444EC,D,5456774A,San Martin,3322,Olivos,1636,BsAsA,Maipu,888,Florida,1122,Buenos Aires'! !!SupplierImportTest methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!importCustomersFrom: aInputStream
	| customer |	customer := CustomerImport from: aInputStream on: system.	customer import! !!SupplierImportTest methodsFor: 'importing' stamp: 'guidotriopodi 11/16/2017 20:40'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	
	^ system customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber! !!SupplierImportTest methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 13:55'!importSupplierFrom: aInputStream
	| supplierImporter |	supplierImporter := SupplierImport  from: aInputStream on: system.	supplierImporter import! !!SupplierImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 15:11'!assert: supplier hasAddressAt: streetName number: streetNumber in: town zipCode: zipCode province: province

	| address |
	
	address := supplier addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !!SupplierImportTest methodsFor: 'asserting' stamp: 'guidotriopodi 11/16/2017 20:40'!assertCorrectNumberOfCustomersWereImported: aNumber self assert: (self allCustomers) size equals: aNumber ! !!SupplierImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 15:16'!assertPepeSanchezWasImportedCorrectly
	| customer supplier |
	customer := self
		customerIdentifiedAs: 'D'
		numbered: '22333444'.	supplier := self supplierIdentifiedAs: 'D'
		numbered: '123'.
	self
		assert: customer
		isNamed: 'Pepe'
		lastName: 'Sanchez'
		identfiedAs: 'D'
		withNumber: '22333444'
		andNumberOfAddresses: 0.
	self
		assert: supplier
		hasAddressAt: 'San Martin'
		number: 3322
		in: 'Olivos'
		zipCode: 1636
		province: 'BsAs'.
	self
		assert: supplier
		hasAddressAt: 'Maipu'
		number: 888
		in: 'Florida'
		zipCode: 1122
		province: 'Buenos Aires'! !!SupplierImportTest methodsFor: 'asserting' stamp: 'GUidoTripodi 11/18/2017 16:29'!assert: customer isNamed: firstName lastName: lastName identfiedAs: idType withNumber: idNumber andNumberOfAddresses: addressesSize

	self assert: customer firstName equals: firstName.
	self assert: customer lastName equals: lastName.
	self assert: customer identificationType equals: idType.
	self assert: customer identificationNumber equals: idNumber.
	self assert: (customer addresses size) equals: addressesSize .! !!SupplierImportTest methodsFor: 'customers' stamp: 'guidotriopodi 11/16/2017 20:40'!allCustomers
	^ system selectAllCustomers! !!SupplierImportTest methodsFor: 'setup-teardown' stamp: 'guidotriopodi 11/16/2017 20:40'!setUp
	system := Environment current newCustomerSystem.
	system start.
	system beginTransaction! !!SupplierImportTest methodsFor: 'setup-teardown' stamp: 'guidotriopodi 11/16/2017 20:40'!addressMapping
	^ system addressMapping! !!SupplierImportTest methodsFor: 'setup-teardown' stamp: 'guidotriopodi 11/16/2017 20:40'!customerMapping
	^ system customerMapping! !!SupplierImportTest methodsFor: 'setup-teardown' stamp: 'guidotriopodi 11/16/2017 20:40'!tearDown
	system commitTransaction.
	system stop! !Object subclass: #SupplierSystem	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!findCustomerByType: aType andIdentification: aIndentification
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber 
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!commitTransaction
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!persistObject: aPersistableObject 
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!selectAllCustomers
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!start
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!customerIdentifiedAs: anIdentificationType numbered: anIdentificationNumber
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!beginTransaction
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!persist: aCustomer
	self subclassResponsibility! !!SupplierSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!stop
	self subclassResponsibility! !SupplierSystem subclass: #SupplierPersistentSystem	instanceVariableNames: 'session'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!SupplierPersistentSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!customerIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber
	| customers |
	customers := session
		select: [ :aCustomer | 
			aCustomer identificationType = anIdentifycationType
				and: [ aCustomer identificationNumber = anIdentificationNumber ] ]
		ofType: Customer.
	^ customers anyOne! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!findCustomerByType: aType andIdentification: aIndentification	^ self customerIdentifiedAs: aType  numbered: aIndentification . ! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber 	| suppliers |
	suppliers := session
		select: [ :aSupplier | 
			aSupplier identificationType = anIdentifycationType
				and: [ aSupplier identificationNumber = anIdentificationNumber ] ]
		ofType: Customer.
	^ suppliers anyOne! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!commitTransaction
	session commit! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!initialize
	super initialize.
	self initializeSession.! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!initializeSession
	session :=
			(DataBaseSession
				for: (Array with: self addressMapping with: self customerMapping with: self supplierMapping  ))! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!persistObject: aPersistableObject 		self persist: aPersistableObject .! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!customerMapping
	^ ClassMapping
		withDefaultTableNameFor: Customer
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #firstName)
				with: (EmbededMapping withDefaultFieldNameFor: #lastName)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address))! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!addressMapping
	^ ClassMapping
		withDefaultTableNameFor: Address
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #streetName)
				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
				with: (EmbededMapping withDefaultFieldNameFor: #town)
				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
				with: (EmbededMapping withDefaultFieldNameFor: #province))! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!start
	session open! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!supplierMapping
	^ ClassMapping
		withDefaultTableNameFor: Supplier 
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #name)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address)				with: (OneToManyMapping withDefaultFieldNameFor: #customers ofType: Customer))! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!beginTransaction
	session beginTransaction! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!persist: aCustomer 
	session persist: aCustomer! !!SupplierPersistentSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!stop
	session close! !!SupplierPersistentSystem methodsFor: 'customers' stamp: 'GUidoTripodi 11/18/2017 17:25'!selectAllCustomers
	^ session selectAllOfType: Customer! !SupplierSystem subclass: #SupplierTransientSystem	instanceVariableNames: 'customers session suppliers'	classVariableNames: ''	poolDictionaries: ''	category: '10Pines-C17-2-Model'!!SupplierTransientSystem methodsFor: 'initialization' stamp: 'GUidoTripodi 11/18/2017 17:25'!initialize
	super initialize.
	customers := OrderedCollection new.	suppliers := OrderedCollection new.! !!SupplierTransientSystem methodsFor: 'customers' stamp: 'GUidoTripodi 11/18/2017 17:25'!findCustomerByType: aType andIdentification: aIndentification
		| collectionCustomer |	collectionCustomer := OrderedCollection new.	collectionCustomer := ( customers select:[:customer | customer identificationType = aType and: ( customer identificationNumber = aIndentification )]).	collectionCustomer isEmpty ifFalse: [ ^(collectionCustomer first) ] ifTrue: [^ self error: CustomerImport noExistCustomer].! !!SupplierTransientSystem methodsFor: 'customers' stamp: 'GUidoTripodi 11/18/2017 17:25'!selectAllCustomers
	^ customers! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!persistCustomer: aCustomer 
	customers add: aCustomer! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!commitTransaction
! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!persistObject: aPersistableObject 
	"customers add: aCustomer"	aPersistableObject persistInto: self.! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!beginTransaction! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!start
! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!persist: aCustomer 
	customers add: aCustomer! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!customerIdentifiedAs: anIdentificationType numbered: anIdentificationNumber
	| identifiedCustomers |
	identifiedCustomers := customers
		select: [ :aCustomer | 
			aCustomer identificationType = anIdentificationType
				and: [ aCustomer identificationNumber = anIdentificationNumber ] ].
	^ identifiedCustomers first! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!stop
! !!SupplierTransientSystem methodsFor: 'importing' stamp: 'GUidoTripodi 11/18/2017 17:25'!persistSupplier: aSupplier 
	suppliers  add: aSupplier! !!SupplierTransientSystem methodsFor: 'setup-teardown' stamp: 'GUidoTripodi 11/18/2017 17:25'!supplierIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber	| identifiedSuppliers |	identifiedSuppliers := suppliers		select: [ :aSupplier | aSupplier identificationType = anIdentifycationType and: 			aSupplier identificationNumber				= anIdentificationNumber. ].	^ identifiedSuppliers first! !