Feature: Sample API Test
  Background:
    * url "https://reqres.in"
    * header Accept = "application/json"
    * def expectedOutput = read("namaFileJSON.json")
    * def expectedOutput2 = read("namaFileJSON2.json")

    #Simple
  Scenario: Test a GET sample API 1
    Given url "https://reqres.in/api/users?page=2"
    When method GET
    Then status 200
    And print response

    #using background, path, params and assertions
  Scenario: Test a GET sample API 2
    Given path "/api/users"
    And param page = 2
    When method GET
    Then status 200
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print response
    And print responseCookies
    And match response.data[0].first_name != null
    And assert response.data.length == 6
    And match $.data[1].id == 8
    And match $.data[3].last_name == "Fields"

   #using Post
  Scenario: Test a Post sample API
    Given path "/api/users"
    And request {"name": "Teguh","job": "QA"}
    When method Post
    Then status 201
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print response
    And print responseCookies

   #Post and assertions
  Scenario: Test a Post sample API 1
    Given path "/api/users"
    And request {"name": "Hariyadi","job": "QA Lead"}
    When method Post
    Then status 201
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print response
    And print responseCookies
    And match response == {"name": "Hariyadi","job": "QA Lead","id":"#string","createdAt": "#ignore"}

   #Post and assertions from json file
  Scenario: Test a Post sample API 2
    Given path "/api/users"
    And request {"name": "Hariyadi","job": "QA Lead"}
    When method Post
    Then status 201
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print response
    And print responseCookies
    And match response == expectedOutput
    And match $ == expectedOutput

   #Post request body from json file
  Scenario: Test a Post sample API 3
    Given path "/api/users"
    And def BodyJSON = read("bodyJSON.json")
    And request BodyJSON
    When method Post
    Then status 201
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print response
    And print responseCookies
    And match response == expectedOutput
    And match $ == expectedOutput

   #Post request body from json file using relative path
  Scenario: Test a Post sample API 4
    Given path "/api/users"
    And def projectPath = java.lang.System.getProperty("user.dir")
    #And def projectPath = karate.properties["user.dir"]
    And def filePath = projectPath+"/src/test/java/tests/src/bodyJSON.json"
    And request filePath
    And print filePath
    When method Post
    Then status 201
    And match response == expectedOutput2
    And match $ == expectedOutput2

   #Post request body and modify the JSON file
  Scenario: Test a Post sample API 5
    Given path "/api/users"
    And def BodyJSON = read("bodyJSON.json")
    And request BodyJSON
    And set BodyJSON.name = "Guppy"
    When method Post
    Then status 201
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print response
    And print responseCookies
    And set expectedOutput.name = "Guppy"
    And match response == expectedOutput
    And match $ == expectedOutput

   #Put request
  Scenario: Test a Put sample API 1
    Given path "/api/users/2"
    And def putJSON = read("putJSON.json")
    And request putJSON
    When method PUT
    Then status 200
    And print response
    And match response == {"name": "Teguh","job": "CEO","updatedAt": #ignore}

   #Delete request
  Scenario: Test a Delete sample API 1
    Given path "/api/users/2"
    When method DELETE
    Then status 204
    And print responseStatus