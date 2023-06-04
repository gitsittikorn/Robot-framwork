*** Settings ***
Library    SeleniumLibrary
Library    String
Suite Setup        เปิด หน้า Login
Suite Teardown     ปิด web
Test Teardown    Reload Page

*** Variables ***
${URL}        http://the-internet.herokuapp.com/login

${valid_username}       tomsmith
${valid_password}       SuperSecretPassword!

${invalid_username}     tomholland
${invalid_password}     Password!

*** Test Cases ***
Login with valid username and password
    เข้าสู่ระบบ        ${valid_username}            ${valid_password}
    แจ้งเตือน logged in สำเร็จ
    ออกจากระบบ
    [Teardown]    log  ทดสอบการทำ test teardown แยก

Login with valid username and invalid password
    เข้าสู่ระบบ        ${valid_username}        ${invalid_password}
    แจ้งเตือน invalid password

Login with invalid username and valid password
    เข้าสู่ระบบ        ${invalid_username}        ${valid_password}
    แจ้งเตือน invalid username

Login with invalid username and password
    เข้าสู่ระบบ        ${invalid_username}        ${invalid_password}
    แจ้งเตือน invalid username

*** Keywords ***
เปิด หน้า Login
    Open Browser    ${URL}    browser=chrome
    Maximize Browser Window
    Page Should Contain   Login Page

เข้าสู่ระบบ
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible        id=username    10s
    # sleep        2s
    Input Text        id=username          ${username}
    Input Password    name=password        ${password}
    Click Button      class=radius

ออกจากระบบ
    Click Element      xpath=//*[@class="button secondary radius"]

แจ้งเตือน invalid username
    ${alert_message}=    Get text  xpath=//*[@class="flash error"]
    Should be Equal        ${alert_message}        Your username is invalid! ×    collapse_spaces=True

แจ้งเตือน invalid password
    ${alert_message}=    Get text  xpath=//*[@class="flash error"]
    Should be Equal        ${alert_message}        Your password is invalid! ×    collapse_spaces=True

แจ้งเตือน logged in สำเร็จ
    ${alert_message}=    Get text  xpath=//*[@class="flash success"]
    Should be Equal        ${alert_message}        You logged into a secure area! ×    collapse_spaces=True

กดย้อนกลับ
    Go Back

ปิด web
    Close Browser