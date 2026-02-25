@regression @unhappy
Feature: Automatizar usuarios - PetStore

  Background:
    * url apiPetStore

  @USER-UNHAPPY-01
  Scenario: Crear lista de usuarios con body inválido - ERROR 500

    * def usersList = read('classpath:examples/data/createUsersListInvalid.json')


    Given path 'user', 'createWithList'
    And request usersList
    When method post
    Then status 500
    And print 'Error esperado'
    And print response

  @USER-UNHAPPY-02
  Scenario Outline: Obtener usuario con username inválido - ERROR 404

    * def username = <username>

    Given path 'user', username
    When method get
    Then status 404
    And print 'Username inválido:', username
    And print 'Status recibido:', responseStatus
    And print response

    Examples:
      | username |
      | '###'    |
      | '   '    |
      | '$$$'    |

  @USER-UNHAPPY-03
  Scenario Outline: Obtener usuario inexistente - ERROR 404

    * def username = <username>

    Given path 'user', username
    When method get
    Then status 404

    And match response.message contains 'User not found'
    And print 'Usuario no encontrado:', username
    And print response

    Examples:
      | username        |
      | 'noExiste123'   |
      | 'fakeUser999'   |

  @USER-UNHAPPY-04
  Scenario: Actualizar usuario con un usuario inválido - BUG API

    * def username = 'user101'
    * def invalidUser = read('classpath:examples/data/updateUserInvalid.json')

    Given path 'user', username
    And request invalidUser
    When method put

    Then status 200
    And print 'BUG: El sistema acepta datos inválidos'
    And print response


  @USER-UNHAPPY-05
  Scenario: Actualizar usuario inexistente - BUG API

    * def username = 'noExiste9999'
    * def updateUser = read('classpath:examples/data/updateUser.json')

    Given path 'user', username
    And request updateUser
    When method put
    Then status 200

    And print 'BUG: DEBERIA MANDAR UN MENSAJE DE "USER NOT FOUND"'
    And print response

  @USER-UNHAPPY-06
  Scenario Outline: Eliminar usuario inexistente - ERROR 404

    * def username = <username>

    Given path 'user', username
    When method delete
    Then status 404

    And print 'Usuario no encontrado:', username
    And print response

    Examples:
      | username       |
      | 'noExiste999'  |
      | 'fakeUser777'  |
      | 'userTest404'  |


  @USER-UNHAPPY-07
  Scenario Outline: Eliminar usuario con username inválido - ERROR 404

    * def username = <username>

    Given path 'user', username
    When method delete
    Then status 404

    And print 'Username inválido:', username
    And print response

    Examples:
      | username |
      | '123'    |
      | '@@@@'   |
      | ' '      |

  @USER-UNHAPPY-08
  Scenario: Crear usuario con datos inválidos - ERROR 500

    * def userInvalid = read('classpath:examples/data/createUserInvalid.json')

    Given path 'user'
    And request userInvalid
    When method post
    Then status 500

    And print 'Intento de creación con datos inválidos'
    And print response


  @USER-UNHAPPY-09
  Scenario Outline: Login con credenciales inválidas

    Given path 'user', 'login'
    And param username = <username>
    And param password = <password>
    When method get
    Then status 200

    And match response.message contains 'logged in user session'
    And print 'DEBERIA MOSTRAR UN MENSAJE DE USUARIO/CONTRASEÑA INCORRECTO'
    And print 'Respuesta del login:', response

    Examples:
      | username | password |
      | '   '    | '   '    |