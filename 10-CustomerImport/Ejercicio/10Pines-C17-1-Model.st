Object subclass: #Address

	^streetName = aStreetName ! !
	
	^addresses detect: [ :anAddress | anAddress isAt: aStreetName ] ifNone: noneClosure ! !
	
	^addresses isEmpty! !
	"
	self importCustomers
	"

	test importCustomers: nil! !
	^ self addresses
		detect: [ :anAddress | anAddress streetName = aStreetName ]! !
	
	^addresses size! !
	| aCustomer aCustomerAddress |
	aCustomer := self customerIdentifiedAs: '23-25666777-9' ofType: 'C'.
	self
		assertCustomer: aCustomer
		hasFirstName: 'Juan'
		hasLastName: 'Perez'
		hasIdentificationType: 'C'
		hasIdentificationNumber: '23-25666777-9'.
	self assert: aCustomer addresses size equals: 1.
	aCustomerAddress := aCustomer addressAt: 'Alem'.
		assertCustomerAddress: aCustomerAddress
		hasStreetName: 'Alem'
		hasStreetNumber: 1122
		hasTown: 'CABA'
		hasZipCode: 1001
	self assert: (system allCustomers) size equals: aNumber 
	| aCustomer aCustomerAddress |
	aCustomer := self customerIdentifiedAs: '22333444' ofType: 'D'.
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
		hasZipCode: 1636
	aCustomerAddress := aCustomer addressAt: 'Maipu'.
		assertCustomerAddress: aCustomerAddress
		hasStreetName: 'Maipu'
		hasStreetNumber: 888
		hasTown: 'Florida'
		hasZipCode: 1122
							
	self assert: aCustomerAddress streetName equals: aStreetName.
	self assert: aCustomerAddress streetNumber equals: aStreetNumber.
	self assert: aCustomerAddress town equals: aTown.
	self assert: aCustomerAddress zipCode equals: aZipCode.
	self assert: aCustomerAddress province equals: aProvince.! !
	self assert: aCustomer firstName equals: aFirstName.
	self assert: aCustomer lastName equals: aLastName.
	self assert: aCustomer identificationType equals: aIdentificationType.
	self assert: aCustomer identificationNumber equals: aIdentificationNumber.

	system commit.
	system close.! !
	^ (aSession
		select:  
			[ :aCustomer | aCustomer identificationNumber = anIdentificationNumber and: aCustomer identificationType = anIdentificationType ]
		ofType: Customer) anyOne.
						withDefaultTableNameFor: Address
						mappingAll:
							(Array
								with: (EmbededMapping withDefaultFieldNameFor: #streetName)
								with: (EmbededMapping withDefaultFieldNameFor: #streetNumber)
								with: (EmbededMapping withDefaultFieldNameFor: #town)
								with: (EmbededMapping withDefaultFieldNameFor: #zipCode)
								with: (EmbededMapping withDefaultFieldNameFor: #province)))! !
						withDefaultTableNameFor: Customer
						mappingAll:
							(Array
								with: (EmbededMapping withDefaultFieldNameFor: #firstName)
								with: (EmbededMapping withDefaultFieldNameFor: #lastName)
								with: (EmbededMapping withDefaultFieldNameFor: #identificationType)
								with: (EmbededMapping withDefaultFieldNameFor: #identificationNumber)
								with: (OneToManyMapping withDefaultFieldNameFor: #addresses ofType: Address))).! !