*** Settings ***
Library     SeleniumLibrary
Library     String
Library    OperatingSystem
Suite Setup    เปิดเวบบราวเซอร์
Test Setup    กลับไปหน้าก่อนหน้า 
Suite Teardown    ปิดหน้าเวบ




*** Variables ***

${url_login}    http://the-internet.herokuapp.com/login
${tool_browser}    chrome
#${browser}    headlesschrome
${expected_page_title_success}    Secure Area
${expected_page_title_failed}    Your username is invalid!

${username_true}    tomsmith
${password_true}    SuperSecretPassword!
${username_false}   tomsmith_f
${password_false}   SuperSecretPassword!_f

#tomsmith 
#SuperSecretPassword! 


*** Test Cases ***
TC-01 กรอก username และ password ถูกต้อง
    # Given เปิดเวบบราวเซอร์
    [Setup]    
    When กรอก username    ${username_true}
    And กรอก password    ${password_true} 
    And กดปุ่ม Login
    Then ตรวจสอบคำค้นหา    ${expected_page_title_success}
    # And กลับไปหน้าก่อนหน้า
    # And ปิดหน้าเวบ


TC-02 กรอก username ไม่ถูกต้อง และ password ไม่ถูกต้อง
    # Given เปิดเวบบราวเซอร์
    When กรอก username    ${username_false}    
    And กรอก password     ${password_false}
    And กดปุ่ม Login
    Then ตรวจสอบคำค้นหา    Your username is invalid!
    # And กลับไปหน้าก่อนหน้า
    # And ปิดหน้าเวบ


TC-03 กรอก username ถูกต้อง password ไม่ถูกต้อง
    # Given เปิดเวบบราวเซอร์
    When กรอก username    ${username_true}    
    And กรอก password     ${password_false}
    And กดปุ่ม Login
    Then ตรวจสอบคำค้นหา    Your password is invalid!
    # And กลับไปหน้าก่อนหน้า
    #And ปิดหน้าเวบ


TC-04 กรอก username ไม่ถูกต้อง password ไม่ถูกต้อง
    # Given เปิดเวบบราวเซอร์
    When กรอก username    ${username_false}    
    And กรอก password     ${password_false}
    And กดปุ่ม Login
    Then ตรวจสอบคำค้นหา    Your username is invalid! 
    #And กลับไปหน้าก่อนหน้า
    # And ปิดหน้าเวบ



*** Keywords ***

เปิดเวบบราวเซอร์    
    Open Browser    url=${url_login}       browser=${tool_browser}
กรอก username   
    [Arguments]    ${username}
    Input Text     id=username    text=${username} 
กรอก password    
    [Arguments]    ${password}
    Input Text     id=password    text=${password}     
    Input Text    id=password    text=${password}
กดปุ่ม Login    
    Click Button    xpath=//button
ตรวจสอบคำค้นหา
    [Arguments]    ${expected_page_title}    
    Page Should Contain    ${expected_page_title}

กลับไปหน้าก่อนหน้า
    Go Back
ปิดหน้าเวบ    
    Close Browser
