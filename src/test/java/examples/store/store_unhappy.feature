@regression @unhappy
Feature: Automatizar el backend de Pet Store - STORE

  Background:
    * url apiPetStore

  @STORE-UNHAPPY-01 @negative
  Scenario: Verificar creación de orden inválida - ERROR 400 - SIMULATION
     * def jsonOrderInvalid = read('classpath:examples/data/createOrderInvalid.json')
     Given path 'store', 'order'
     And request jsonOrderInvalid
     When method post
    Then status 200
    And match response == '#object'
    * print 'NO DEBERÍA ACEPTAR DATOS INVÁLIDOS'
    * print response


  @STORE-UNHAPPY-02
  Scenario Outline: Buscar orden con ID inválido (404 Invalid ID supplied)

    * def orderId = <orderId>

    Given path 'store', 'order', orderId
    When method get
    Then status 404
    And print 'ERROR 404 - ID inválido enviado: ', orderId

    Examples:
      | orderId |
      | 'abc'   |
      | '###'   |
      | '#@$'   |

  @STORE-UNHAPPY-03
  Scenario Outline: Buscar orden inexistente (404 Order not found)

    * def orderId = <orderId>

    Given path 'store', 'order', orderId
    When method get
    Then status 404

    And match response.message contains 'not found'
    And print 'ERROR 404 - Orden no encontrada, ID: ', orderId

    Examples:
      | orderId |
      | 1111    |
      | 9999    |

  @STORE-UNHAPPY-04
  Scenario Outline: Eliminar orden con ID inválido - ERROR 404

    * def orderId = <orderId>

    Given path 'store', 'order', orderId
    When method delete
    Then status 404
    And print 'ID inválido enviado:', orderId
    And print 'Status:', responseStatus
    And print response

    Examples:
      | orderId |
      | '@@@'   |
      | 'abc'   |
      | '###'   |

  @STORE-UNHAPPY-05
  Scenario Outline: Eliminar orden inexistente - ERROR 404

    * def orderId = <orderId>

    Given path 'store', 'order', orderId
    When method delete
    Then status 404
    And print 'Orden no encontrada ID:', orderId
    And print response

    Examples:
      | orderId |
      | 99999   |
      | 5000    |




