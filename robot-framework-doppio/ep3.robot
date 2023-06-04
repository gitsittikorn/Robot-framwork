*** Settings ***
Library    RequestsLibrary


*** Test Cases ***
TC--001 Verify when input wrong username or password , API should return error
    Create Session    loginSession        http://localhost:8082
    ${request_boby}=    Create Dictionary    username=doppio    password=weBuildBestQasss
    ${resp}    POST On Session    loginSession    /login    json=${request_boby}    expected_status=401
    Should Be Equal    ${resp.json()['status']}    error
    Log To Console     ${resp.json()['message']}    


# TC--002 Verify when input correct username or password , API should return success
#     Create Session    loginSession        http://localhost:8082
#     ${request_boby}=    Create Dictionary    username=doppio    password=weBuildBestQa
#     ${resp}    POST On Session    loginSession    /login    json=${request_boby}    expected_status=200
#     Should Be Equal    ${resp.json()['status']}    success
#     Log To Console     ${resp.json()['status']}   




    #call API with wrong username / password




    #verify status code is 401
    #verify status message is error
    #verify error message is invalid username or password
