!classDefinition: #MLTest category: #'TusLibros.com '!
TestCase subclass: #MLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com '!

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 19:58:25'!
test01EmptyCartCanBeCreated
	| aCart |
	aCart:= Cart new.
	self assert: aCart products isEmpty.! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 21:17:00'!
test02BookCanBeAddedToCart
	| aBook aCart |
	aBook:= Book new.
	aCart:= Cart new.
	aCart add: aBook.
	self deny: aCart products isEmpty! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 21:17:07'!
test03BookAddedToCartIsPresentInTheCart
	| aBook aCart |
	aBook:= Book new.
	aCart:= Cart new.
	aCart add: aBook.
	self assert: [aCart products includes: aBook]! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 20:08:13'!
test04OneBookAddedToCartIsPresentInTheCart
	| aBook aCart |
	aBook _ Book new.
	aCart _ Cart new.
	aCart
		add: aBook
		copies: 1.
	self assert: [ aCart products includes: aBook ].! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 20:09:30'!
test05SeveralBooksAddedToCartArePresentInTheCart
	| aBook aCart |
	aBook _ Book new.
	aCart _ Cart new.
	aCart
		add: aBook
		copies: 25.
	self assert: [ aCart products includes: aBook ].
	self assert: aCart products size = 25.! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 21:17:20'!
test06SeveralBooksAddedToCartArePresentInTheCartButNotAddedBooksArentIncludedInTheCart
	| aBook aCart anotherBook |
	aBook _ Book new.
	anotherBook _ Book new.
	aCart _ Cart new.
	aCart
		add: aBook.
	self assert: [ aCart products includes: aBook ].
	self assert: (aCart products includes: anotherBook)=false.
! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 20:45:23'!
test07EditorialCanBeOwnerOfACart
	| aCart anEditorial |
	anEditorial _ Editorial withName: 'Ateneo'.
	aCart _ Cart whoseOwnerIs: anEditorial .
	self assert: aCart owner = anEditorial.! !

!MLTest methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 21:17:29'!
test08CantAddABookThatIsNotFromTheCartsEditorial
	| aCart anEditorial aBook anotherEditorial |
	anEditorial _ Editorial withName: 'Ateneo'.
	aCart _ Cart whoseOwnerIs: anEditorial.
	anotherEditorial _ Editorial  withName: 'Oceano'.
	aBook _ Book from: anotherEditorial.
	aCart add: aBook.
	
	self assert: (aCart products includes: aBook) = false.! !


!classDefinition: #Book category: #'TusLibros.com '!
Object subclass: #Book
	instanceVariableNames: 'isbn editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com '!

!Book methodsFor: 'creating' stamp: 'ELR 10/26/2017 20:21:38'!
isbn: anISBN 
	isbn:= anISBN .! !


!Book methodsFor: 'accessing' stamp: 'ELR 10/26/2017 21:11:01'!
editorial
	^editorial.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'TusLibros.com '!
Book class
	instanceVariableNames: 'editorial'!

!Book class methodsFor: 'creating' stamp: 'ELR 10/26/2017 20:57:06'!
from: anEditorial	
	editorial := anEditorial .! !

!Book class methodsFor: 'creating' stamp: 'ELR 10/26/2017 20:20:39'!
withISBN: anISBN 
	| aBook |
	aBook := self new.
	aBook isbn: anISBN .
	^aBook.! !


!Book class methodsFor: 'accessing' stamp: 'ELR 10/26/2017 21:14:50'!
editorial
	^editorial! !


!classDefinition: #Cart category: #'TusLibros.com '!
Object subclass: #Cart
	instanceVariableNames: 'products editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com '!

!Cart methodsFor: 'accessing' stamp: 'ELR 10/26/2017 19:47:06'!
products
	^products.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'ELR 10/26/2017 19:48:02'!
initialize
	products:= OrderedCollection new.! !


!Cart methodsFor: 'adding' stamp: 'ELR 10/26/2017 21:10:02'!
add: aBook 

	self owner = '' ifTrue: [products add: aBook .] ifFalse: [(aBook editorial = self owner) ifTrue: [products add: aBook .]	].! !

!Cart methodsFor: 'adding' stamp: 'ELR 10/26/2017 20:07:13'!
add: aBook copies: numberOfCopies 
	numberOfCopies timesRepeat: [products add: aBook ]   .! !

!Cart methodsFor: 'adding' stamp: 'ELR 10/26/2017 21:02:00'!
owner
 ^editorial .! !

!Cart methodsFor: 'adding' stamp: 'ELR 10/26/2017 21:00:51'!
owner: anEditorial 
	editorial := anEditorial ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros.com '!
Cart class
	instanceVariableNames: 'owner'!

!Cart class methodsFor: 'creating' stamp: 'ELR 10/26/2017 21:03:43'!
whoseOwnerIs: anEditorial
	| aCart |
	aCart _ self new. 
	aCart owner: anEditorial .
	^aCart .
	! !



!classDefinition: #Editorial category: #'TusLibros.com '!
Object subclass: #Editorial
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com '!

!Editorial methodsFor: 'associating' stamp: 'ELR 10/26/2017 20:47:20'!
name: aStringName 
	name _ aStringName .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Editorial class' category: #'TusLibros.com '!
Editorial class
	instanceVariableNames: ''!

!Editorial class methodsFor: 'creating' stamp: 'ELR 10/26/2017 20:58:06'!
withName: aName 
	| aNewEditorial |
	aNewEditorial _ self new.
	^aNewEditorial name: aName .
	! !


!classDefinition: #TusLibros category: #'TusLibros.com '!
Object subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com '!
