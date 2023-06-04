*** Settings ***
Library    SeleniumLibrary


*** Keywords ***

เข้าสู่ระบบ
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible        id=username    10s
    # sleep        2s
    Input Text        id=username          ${username}
    Input Password    name=password        ${password}
    Click Button      class=radius
    
แจ้งเตือน invalid username
    ${alert_message}=    Get text  xpath=//*[@class="flash error"]
    Should be Equal        ${alert_message}        Your username is invalid! ×    collapse_spaces=True

แจ้งเตือน invalid password
    ${alert_message}=    Get text  xpath=//*[@class="flash error"]
    Should be Equal        ${alert_message}        Your password is invalid! ×    collapse_spaces=True