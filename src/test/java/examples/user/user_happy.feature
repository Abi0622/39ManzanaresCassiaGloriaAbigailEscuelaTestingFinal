@regression @happy
Feature: Automatizar usuarios - PetStore

  Background:
    * url apiPetStore

  @USER-HAPPY-01 @createUsersWithList
  Scenario: Crear lista de usuarios correctamente - OK

    * def usersList = read('classpath:examples/data/createUsersList.json')

    Given path 'user', 'createWithList'
    And request usersList
    When method post
    Then status 200

    And print 'Usuarios creados correctamente'
    And print response

  @USER-HAPPY-02
  Scenario: Obtener usuario por username - OK

    * def username = 'user101'

    Given path 'user', username
    When method get
    Then status 200

    And match response.username == username
    And match response.id != null
    And match response.email != null

    And print 'Usuario encontrado:', response.username
    And print response


  @USER-HAPPY-03 @updateUser
  Scenario: Actualizar usuario existente - OK

    * def username = 'user101'
    * def updateUser = read('classpath:examples/data/updateUser.json')

    Given path 'user', username
    And request updateUser
    When method put
    Then status 200

    And print 'Usuario actualizado:', username
    And print response

  @USER-HAPPY-04 @deleteUser
  Scenario: Eliminar usuario existente - OK

    * def username = 'user101'

    Given path 'user', username
    When method delete
    Then status 200

    And print response

  @USER-HAPPY-05 @createUser
  Scenario: Crear usuario correctamente - OK 200

    * def userBody = read('classpath:examples/data/createUser.json')

    Given path 'user'
    And request userBody
    When method post
    Then status 200

    And print 'Usuario creado correctamente'
    And print response


  @USER-HAPPY-06
  Scenario: Login correcto con usuario existente

    Given path 'user', 'login'
    And param username = 'testUserKarate'
    And param password = '12345'
    When method get
    Then status 200

    And match response.message contains 'logged in user session'
    And print 'Login exitoso'
    And print response

  @USER-HAPPY-07
  Scenario: Logout correcto validando mensaje

    Given path 'user', 'logout'
    When method get
    Then status 200
    And match response.message contains 'ok'

    And print 'Logout validado correctamente'

  @USER-HAPPY-08
  Scenario: Crear lista de usuarios con array

    * def usersArray = read('classpath:examples/data/createUsersArray.json')

    Given path 'user', 'createWithArray'
    And request usersArray
    When method post
    Then status 200

    And print 'Usuarios creados correctamente con array'
    And print response

