*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    FakerLibrary
#Suite Setup    Login        eve.holt@reqres.in                cityslicka

#Test Setup                Create user Successful     #Username: big0 Password:1234
# Test Teardown         Delete User Successful   Username: big0


*** Variables *** 
${url_create_user}    https://petstore.swagger.io
${URL}        https://reqres.in


 
*** Test Cases *** 

#TC -01 Create user Successful
#    Create user Successful       
#Create user Successful    123456    sittikorn    muekdang    mong    sittikorn@gmail.com    076434654 


TC01 - Login
    Login        eve.holt@reqres.in                cityslicka

TC02 - Create user
    Create user Successful 

# Get user profile of big0 Unsuccessful
#      [Setup]        Create user Unsuccessful
#      Username: big0
#      [Teardown]     Delete User Unsuccessful

# Get user profile of big0 Successful
#      Username: big0

# Get user profile of big1 Unsuccessful
#     Username: big1 Password:1234

# Update user profile of big0 Successful
#      Username: big0


*** Keywords ***

Create user Successful    
     ${uuid}    FakerLibrary.Uuid 4
     ${username}    FakerLibrary.User Name
     ${firstname}    FakerLibrary.User Name
     ${lastname}    FakerLibrary.User Name
     ${email}    FakerLibrary.Company Email
     ${password}    FakerLibrary.Password    
     ${phone}    FakerLibrary.Phone Number

     Log To Console    uuid: ${uuid}
     Log To Console    username: ${username} 
     Log To Console    firstname: ${firstname}
     Log To Console    lastname: ${lastname}
     Log To Console    email: ${email}
     Log To Console    password: ${password}
     Log To Console    phone: ${phone}

     log    uuid: ${uuid}
     log    username: ${username} 
     log    firstname: ${firstname}
     log    lastname: ${lastname}
     log    email: ${email}
     log    password: ${password}
     log    phone: ${phone}

    Create Session    baskets   ${url_create_user}
    &{headers}     Create dictionary    Content-Type=application/json
    ${json_string}=   catenate
    ...        {
    ...            "username": "${username}",
    ...            "lastname": "${lastname}"
    ...        }

     # ...          {
     # ...          "id": 999889908064,
     # ...          "username": "big",
     # ...          "firstName": "boom",
     # ...          "lastName": "ball",
     # ...          "email": "big@gmila.com",
     # ...          "password": "password_big",
     # ...          "phone": "076-434-654",
     # ...          "userStatus": 0
     #  ...         }
    
    ${response}    POST On Session        baskets       /v2/user        data=${json_string}        headers=${headers}
    log      ${response.content}
    log      ${response.json()}
    Should Be Equal        ${response.status_code}        ${200}

    ${response_name}    Get From Dictionary     ${response.json()}   message
    log  ${response_name}
    Should Be Equal        ${response_name}        999889908064
#     ${response_job}    Get From Dictionary     ${response.json()}   job
#     log  ${response_job}
#     ${response_createdAt}    Get From Dictionary     ${response.json()}   createdAt
#     log  ${response_createdAt}

#     Should Be Equal        ${response_name}            ${username} 
    #Should Not Be Empty    ${response_createdAt}


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
#     Set Suite Variable    ${TOKEN}    ${response_token}
#     Log  ${TOKEN}