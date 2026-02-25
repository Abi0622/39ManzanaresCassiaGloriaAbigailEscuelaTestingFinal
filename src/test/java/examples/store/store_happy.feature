@regression @happy
Feature: Automatizar el backend de Pet Store - STORE

  Background:
    * url apiPetStore


  @STORE-HAPPY-01 @storeInventory
  Scenario: Verificar el inventario de la tienda - OK

    Given path 'store', 'inventory'
    When method get
    Then status 200
    And match response.available == '#number'
    And match response.pending == '#number'
    And match response.sold == '#number'
    * def availableCount = response.available
    * def pendingCount = response.pending
    * def soldCount = response.sold
    And print 'Available pets: ', availableCount
    And print 'Pending pets: ', pendingCount
    And print 'Sold pets: ', soldCount

  @STORE-HAPPY-02 @crearOrden
  Scenario: Verificar la creación de una orden para una mascota - OK

    * def jsonOrder = read('classpath:examples/data/createOrder.json')

    Given path 'store', 'order'
    And request jsonOrder
    When method post
    Then status 200
    * def orderId = response.id
    And print orderId

  @STORE-HAPPY-03 @getOrder
  Scenario: Verificar la búsqueda de una orden por ID - OK

    * def orderId = 1

    Given path 'store', 'order', orderId
    When method get
    Then status 200

    And match response.id == orderId
    And match response.petId != null
    And match response.status != null

    * def orderStatus = response.status
    And print 'Order ID: ', orderId
    And print 'Order Status: ', orderStatus


  @STORE-HAPPY-04 @deleteOrder
  Scenario: Eliminar una orden existente - OK

    * def orderId = 1

    Given path 'store', 'order', orderId
    When method delete
    Then status 200

    And match +response.message == orderId
    And print 'Orden eliminada ID: ', orderId
    And print response
