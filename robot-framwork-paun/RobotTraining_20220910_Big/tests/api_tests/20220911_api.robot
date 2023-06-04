*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${URL}    https://reqres.in/
${api_variables}    testing api
${token}    sdfsdoj43kkjls4sd4fs6d5f4sdfk;sdfk;lkcxvpksdfserser

*** Test Cases ***
TC_001 - Register Successful
    User register Email as "eve.holt@reqres.in" and Password as "pistol" to system
    Verify account from system
    Register Should Have Succeeded
    
TC_003 - Login Successful
    login

# TC_004 - Login Unsuccessful
TC _ Get user
    Get user
# TC_005 - Create User


*** Keywords ***
User register Email as "${email}" and Password as "${password}" to system
    log    ${email}
    log    ${password}
    log    ${api_variables} 
    ${test1}    Should Not Be Empty     ${email}
    Log    ${test1}
    Set Test Variable         ${email}

    Create Session    baskets      ${URL}
    &{headers}    Create dictionary        Content-Type=application/json    #Authorization=${token}
    ${json_string}=  catenate
    ...    {
    ...        "email": "${email}",
    ...        "password": "${password}"
    ...    }
    log     ${json_string}

   ${response_register_data}     POST On Session    baskets    /api/register        data=${json_string}        headers=${headers}
   log    ${response_register_data}
   log    ${response_register_data.content}
   log    ${response_register_data.status_code}
   log    ${response_register_data.json()}

    ${response_token}    Get From Dictionary        ${response_register_data.json()}    token
    log     ${response_token}
    Set Test Variable         ${response_token}



Register Should Have Succeeded
    Log      Register Should Have Succeeded
    log    ${api_variables} 
    # Log    ${test1}
    ${result}    Verify status
    log      ${result}


Register Should Have Unsucceeded
    Log      Register Should Have Unsucceeded
    log    ${api_variables} 
    # Log    ${test1}
    ${result}    Verify status
    log      ${result}

Verify account from system
    # Should be equal        ${email}        eve.holt@reqres.in
    # Return From Keyword        Succeeded
    ${expected}    Set Variable    eve.holt@reqres.in
    
    Run Keyword If	"${email}" == "${expected}"	    Register Should Have Succeeded	
    ...	ELSE     Register Should Have Unsucceeded

Verify status
    ${expected_token}    Set variable     QpwL5tke4Pnpja7X4
    Should be equal       ${response_token}       ${expected_token}
    Return From Keyword        Valid account


login

    Create Session    baskets      ${URL}
    &{headers}    Create dictionary        Content-Type=application/json    #Authorization=${token}
    ${json_string}=  catenate
    ...    {
    ...        "email": "eve.holt@reqres.in",
    ...        "password": "cityslicka"
    ...    }
    log     ${json_string}

   ${response_login_data}     POST On Session    baskets    /api/register        data=${json_string}        headers=${headers}
   log    ${response_login_data}
   log    ${response_login_data.content}
   log    ${response_login_data.status_code}
   log    ${response_login_data.json()}

    ${response_login}    Get From Dictionary        ${response_login_data.json()}    token
    log     ${response_login}
    Set Test Variable         ${response_login}
    Should Be Equal        ${response_login_data.status_code}        ${200}


Get user
    Create Session    baskets      ${URL}
    &{headers}    Create dictionary        Content-Type=application/json    #Authorization=${token}

   ${response_get_user_data}     GET On Session    baskets    /api/register               headers=${headers}
   log    ${response_get_user_data}
   log    ${response_get_user_data.content}
   log    ${response_get_user_data.status_code}
   log    ${response_get_user_data.json()}

    # ${response_get_user}    Get From Dictionary        ${response_get_user_data.json()}    token
    log     ${response_get_user_data}
    Set Test Variable         ${resget_user}    ${response_get_user_data}
    log      ${resget_user}
    Should Be Equal        ${response_get_user_data.status_code}        ${200}
