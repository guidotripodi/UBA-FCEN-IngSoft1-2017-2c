﻿ProtoObject subclass: #ErpSystem
	"super initialize.
	self initializeSession."! !

	| identification |
	self assert: customer lastName equals: lastName.
	self assert: (customer identification  equals: identification ).
	self assert: (customer addresses size) equals: addressesSize .! !
	| customer idType idNumber |
	idType := 'D'.
	idNumber := '22333444'.
	customer := system
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
		province: 'Buenos Aires'! !

	| address |
	
	address := customer addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !
	| customer idType idNumber |
	idType := 'C'.
	idNumber := '23-25666777-9'.
	customer := system customerIdentifiedAs: idType numbered: idNumber.
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
		province: 'CABA'! !
	system := Environment current newCustomerSystem.
	system start.
	system beginTransaction! !
	system commitTransaction.
	system stop! !
	self subclassResponsibility.! !
	self subclassResponsibility.! !
	self subclassResponsibility.! !
	| currentEnvironmentClass |
	currentEnvironmentClass := Environment allSubclasses detect: [ :anEnvirommentClass | anEnvirommentClass isCurrent  ] ifNone: [ Error signal: 'No current Environment' ].
	^ currentEnvironmentClass new.! !
	^ SupplierTransientSystem new.! !
	^ CustomerTransientSystem new.! !
	^ SupplierTransientSystem  new.! !
	^ false.! !
	importers := OrderedCollection new.

	(self new initializeOn: aReadStream on: aSession) import ! !
	| customer supplier |
	customer := system
		customerIdentifiedAs: 'D'
		numbered: '22333444'.
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
		province: 'Buenos Aires'! !

	| address |
	
	address := supplier addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !
	| customer idType idNumber |
	idType := 'D'.
	idNumber := '22333444'.
	customer := system
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
		province: 'Buenos Aires'! !

	| identification |
	self assert: customer lastName equals: lastName.
	identification := Identification type:  idType number: idNumber. 
	self assert: (customer identification  equals: identification ).
	self assert: (customer addresses size) equals: addressesSize .! !
		numbered: aSupplierNumber.
	system := Environment current newErpSystem.
	system start.
	system beginTransaction! !
	system commitTransaction.
	system stop! !

	readStream := aReadStream.
	system := aSession.
	readStream ifNil: [^ self error: self class noDataErrorDescription ] .
	^ line notNil! !

	[ self canImportNextLine ] whileTrue: [ 
		self convertLineToRecord.
		self importRecord]! !

	record:=line substrings: {$,}.! !
	self

	(self new initializeOn: aReadStream on: aSession) import.
	^'Invalid data header'! !
	system persist: newCustomer. ! !
	
	record first = 'C' ifTrue: [ ^self importCustomer ].
	record first = 'A' ifTrue: [ ^self importAddress ].
	^ CustomerPersistentSystem new.! !
	^ true.! !
	self subclassResponsibility! !
	
	^addresses detect: [ :anAddress | anAddress streetName = aStreetName ] ifNone: noneClosure ! !
	^addresses .! !
	addresses add: anAddress .! !
	^(identification validType: aType andNumber: aNumber ).! !
	^identificationType .! !
	identificationNumber := aNumber .! !
	^identificationNumber .! !
	identificationType := aType .! !
	self subclassResponsibility! !
	customers add: aCustomer ! !
^ (customers includes: aCustomer) ! !
	^customers .! !
	
	record first = 'EC' ifTrue: [ ^self addExistingCustomer ].
	record first = 'A' ifTrue: [ ^self importAddress ].
	| customer supplier |
	customer := system
		customerIdentifiedAs: 'D'
		numbered: '22333444'.
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
		province: 'Buenos Aires'! !

	| address |
	
	address := supplier addressAt: streetName ifNone: [ self fail ].
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town.
	self assert: address zipCode equals: zipCode.
	self assert: address province equals: province.
	! !
		numbered: aSupplierNumber.

	| identification |
	self assert: customer lastName equals: lastName.
identification := Identification type:  idType number: idNumber. 
	self assert: (customer identification  equals: identification ).
	self assert: (customer addresses size) equals: addressesSize .! !
	system commitTransaction.
	system stop! !
	system := Environment current newSupplierSystem.
	system start.
	system beginTransaction! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	^ (self selectAllCustomers size = 0)! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	self subclassResponsibility! !
	session removeAClass: Customer.! !
	super initialize.
	self initializeSession.! !
	session persist: anObject ! !
	self subclassResponsibility! !
	session open! !
	^ session selectAllOfType: Customer! !
	session beginTransaction! !
	session commit! !
	session close! !
	^ session selectAllOfType: Address ! !
		select: [ :aElement |
		ofType: aClass.! !
	collections := self giveMeElementIdentifiedAs: identification  ofClass: aClass   . 
	^self objectIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber ofClass: Customer! !
	^ ClassMapping
		withDefaultTableNameFor: Customer
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #firstName)
				with: (EmbededMapping withDefaultFieldNameFor: #lastName)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address))! !
	^ ClassMapping
		withDefaultTableNameFor: Address
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #streetName)
				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
				with: (EmbededMapping withDefaultFieldNameFor: #town)
				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
				with: (EmbededMapping withDefaultFieldNameFor: #province))! !
	session :=
			(DataBaseSession
				for: (Array with: self addressMapping with: self customerMapping  ))! !
	^ ClassMapping
		withDefaultTableNameFor: Address
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #streetName)
				with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
				with: (EmbededMapping withDefaultFieldNameFor: #town)
				with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
				with: (EmbededMapping withDefaultFieldNameFor: #province))! !
	^ ClassMapping
		withDefaultTableNameFor: Customer
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #firstName)
				with: (EmbededMapping withDefaultFieldNameFor: #lastName)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address))! !
	^self objectIdentifiedAs: anIdentifycationType numbered: anIdentificationNumber ofClass: Customer! !
	session :=
			(DataBaseSession
				for: (Array with: self addressMapping with: self customerMapping with: self supplierMapping  ))! !
	^ ClassMapping
		withDefaultTableNameFor: Supplier 
		mappingAll:
			(Array
				with: (EmbededMapping withDefaultFieldNameFor: #name)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
				with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
				with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address)
! !
! !
	collections := self giveMeElementIdentifiedAs: identification  ofClass: aClass   . 
! !
! !
	super initialize.
	customers := OrderedCollection new.
		select: [ :aElement |
		! !
	 customers isEmpty ifTrue: [ ^address ] ifFalse: [address := customers select: [:each| each addresses isEmpty = false]].
	 customers removeAll .! !
	^ customers! !
	customers add: aCustomer! !
	^self objectIdentifiedAs: anIdentificationType numbered: anIdentificationNumber ofClass: Customer.
	customers add: aCustomer! !
	 suppliers  isEmpty ifTrue: [ ^address ] ifFalse: [address := suppliers  select: [:each| each addresses isEmpty = false]].
	^ customers! !
		select: [ :aElement |
		select: [ :aElement |
	super initialize.
	customers := OrderedCollection new.
	 customers removeAll .
	"| identifiedCustomers identification |
	identifiedCustomers := (identification giveMeElementFrom: customers).
	identifiedCustomers isEmpty ifFalse: [ ^ identifiedCustomers  anyOne] ifTrue: [^ self error: CustomerImporter noExistCustomer]."! !
	