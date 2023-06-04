*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    FakerLibrary
Suite Setup    Login        eve.holt@reqres.in                cityslicka

*** Variables ***
${URL}        https://reqres.in
*** Test Cases ***



# Test case Get SINGLE USER
#     [Tags]    api    retest
#     Get SINGLE USER        2    janet.weaver@reqres.in    Janet     Weaver    ${200}
#     Get SINGLE USER        23    ${Empty}    ${Empty}     ${Empty}    ${404}
    


# Test case Create
#     [Tags]    retest
#     Create        Ratthanun Pongsaiya              leader
#     Update        Mr.Ratthanun Pongsaiya           Sr.leader

# Test case Put
#     [Tags]    retest
#     Update    Mr.Ratthanun Pongsaiya            Sr.leader

# Test case Delete
#     [Tags]    retest
#     Delete

# secondary
#     Post Request Test
*** Keywords ***
Login
    [Arguments]        ${email}        ${password}
    Create Session    baskets   ${URL}
    &{headers}     Create dictionary          Content-Type=application/json
    ${json_string}=   catenate
    ...        {
    ...            "email": "${email}",
    ...            "password": "${password}"
    ...        }
    ${response}    POST On Session        baskets       /api/login        data=${json_string}        headers=${headers}
    log      ${response.content}
    log      ${response.json()}
    Should Be Equal        ${response.status_code}        ${200}

    ${response_token}    Get From Dictionary     ${response.json()}   token
    log  ${response_token}
    Should Not Be Empty    ${response_token}
    # ${token}    Set Variable                 ${response_token}
    # log    ${token}
    # Set Test Variable    ${TOKEN}    ${response_token}
    # Log  ${TOKEN}
    Set Suite Variable    ${TOKEN}    ${response_token}
    Log  ${TOKEN}

Get SINGLE USER
    [Arguments]    ${id}        ${email}            ${first_name}       ${last_name}        ${status_code}
    Set Test Variable     ${id}    
    Set Test Variable     ${email}        
    Set Test Variable     ${first_name}   
    Set Test Variable     ${last_name}    
    Set Test Variable     ${status_code}
    Create Session    baskets   ${URL}
    &{headers}     Create dictionary    Authorization=Bearer ${token}      Content-Type=application/json
    ${response}    GET On Session        baskets        /api/users/${id}        headers=${headers}        expected_status=anything
    log      ${response}
    # log      ${response.content}
    # log      ${response.json()}
    Set Test Variable    ${response}
    Run Keyword If    ${status_code} == ${200}    Verify valid user    ${id}    ${email}        ${first_name}    ${last_name}    
    ...    ELSE     Verify Invalid user    ${id}     ${status_code}

Verify valid user
    [Arguments]        ${id}    ${email}        ${first_name}    ${last_name}    
    Should Be Equal        ${response.status_code}        ${200}
    ${response_data}    Get From Dictionary         ${response.json()}        data
    log     ${response_data}
    ${response_id}      Get From Dictionary         ${response_data}        id
    log      ${response_id}
     ${response_email}      Get From Dictionary         ${response_data}        email
    log      ${response_email}
     ${response_first_name}      Get From Dictionary         ${response_data}        first_name
    log      ${response_first_name}
     ${response_last_name}      Get From Dictionary         ${response_data}        last_name
    log      ${response_last_name}
    ${response_avatar}      Get From Dictionary         ${response_data}        avatar
    log      ${response_avatar}

    Should Be Equal as integers            ${response_id}                2
    Should Be Equal            ${response_email}                         janet.weaver@reqres.in
    Should Be Equal            ${response_first_name}                    Janet 
    Should Be Equal            ${response_last_name}                     Weaver
    Should Be Equal            ${response_avatar}                        https://reqres.in/img/faces/2-image.jpg

Verify Invalid user
    [Arguments]        ${id}    ${status_code}
     Should Be Equal        ${response.status_code}        ${404}
     Should Be Empty        ${response.json()}



Create
    [Arguments]        ${name}        ${job}
    ${uuid}        FakerLibrary.Uuid 4
    log       ${uuid}
    Create Session    baskets   ${URL}
    &{headers}     Create dictionary    Authorization=Bearer ${token}      Content-Type=application/json
    ${json_string}=   catenate
    ...        {
    ...            "id": "${uuid}",
    ...            "name": "${name}",
    ...            "job": "${job}"
    ...        }
    ${response}    POST On Session        baskets       /api/users        data=${json_string}        headers=${headers}
    log      ${response.content}
    log      ${response.json()}
    Should Be Equal        ${response.status_code}        ${201}

    ${response_name}    Get From Dictionary     ${response.json()}   name
    log  ${response_name}
    ${response_job}    Get From Dictionary     ${response.json()}   job
    log  ${response_job}
    ${response_createdAt}    Get From Dictionary     ${response.json()}   createdAt
    log  ${response_createdAt}

    Should Be Equal        ${response_name}            ${name}
    Should Be Equal        ${response_job}             ${job}
    Should Not Be Empty    ${response_createdAt}

Update
    [Arguments]        ${name}        ${job}
    Create Session    baskets   ${URL}
    &{headers}     Create dictionary    Authorization=Bearer ${token}      Content-Type=application/json
    ${json_string}=   catenate
    ...        {
    ...            "name": "${name}",
    ...            "job": "${job}"
    ...        }
    ${response}    PUT On Session        baskets       /api/users/2        data=${json_string}        headers=${headers}
    log      ${response.content}
    log      ${response.json()}
    Should Be Equal        ${response.status_code}        ${200}

    ${response_name}    Get From Dictionary     ${response.json()}   name
    log  ${response_name}
    ${response_job}    Get From Dictionary     ${response.json()}   job
    log  ${response_job}
    ${response_updatedAt}    Get From Dictionary     ${response.json()}   updatedAt
    log  ${response_updatedAt}

    Should Be Equal        ${response_name}            ${name}
    Should Be Equal        ${response_job}             ${job}
    Should Not Be Empty    ${response_updatedAt}

Delete
    Create Session    baskets   ${URL}
    &{headers}     Create dictionary    Authorization=Bearer ${token}      Content-Type=application/json
    ${response}    DELETE On Session        baskets        /api/users/2        headers=${headers}
    log      ${response}
    log      ${response.content}
    log   ${response.status_code}
    Should Be Equal        ${response.status_code}        ${204}
    Should Be Empty        ${response.content}
    # log      ${response.json()}
    # ${response_data}    Get From Dictionary         ${response.json()}        data




Post Request Test
      Create Session  jsonplaceholder  https://jsonplaceholder.typicode.com
      &{data}=    Create dictionary  title=Robotframework requests  body=This is a test!  userId=1
      ${resp}=    POST On Session    jsonplaceholder  /posts  json=${data}  expected_status=anything

      Status Should Be                 201  ${resp}
      Dictionary Should Contain Key    ${resp.json()}  id