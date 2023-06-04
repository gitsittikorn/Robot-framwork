*** Settings ***
Library    SeleniumLibrary
Library    String
Suite Setup        Given เปิดหน้าเว็บ Google 
Test Setup        log  เริ่มการทดสอบในเทสเคส
Test Teardown       And กลับไปหน้าก่อนหน้า
Suite Teardown     And ปิดหน้าเว็บ

*** Variables ***
${name_youtube}    Youtube
${name_facebook}    Facebook
# ${browser}    chrome
${browser}    headlesschrome

*** Test Cases ***
TC_001 - ค้นหาข้อมูล ด้วย Robot framework
    [Setup]    log    จะเริ่มทำการทดสอบแล้วนะครับ
    When กรอกคำค้นหา     Robot framework
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     Robot framework    92,000,000
    And กลับไปหน้าก่อนหน้า
    [Teardown]    log     ทดสอบเทสเคสที่ 1 เสร็จแล้วครับ

TC_002 - ค้นหาข้อมูล ด้วย Selenium Library
    When กรอกคำค้นหา     Selenium Library
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     Selenium Library    86,600,000
    And กลับไปหน้าก่อนหน้า
    [Teardown]    log     ทดสอบเทสเคสที่ 2 เสร็จแล้วครับ

TC_003 - ค้นหาข้อมูล ด้วย Youtube
    [Tags]    all    critical
    When กรอกคำค้นหา     ${name_youtube}
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     ${name_youtube}    86,600,000

TC_004 - ค้นหาข้อมูล ด้วย ${name_facebook} 
    When กรอกคำค้นหา     ${name_facebook} 
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     ${name_facebook}     86,600,000

TC_005 - ค้นหาข้อมูล ด้วย ข้อมูลหลายชุด 
    [Template]    ค้นหาข้อมูล และตรวจสอบคำค้น
#        Input                         expected_message                expected_result
        Robot framework                 Robot framework                    92,000,000
        Selenium Library                Selenium Library                    86,600,000
        Youtube                         Youtube                            92,000,000
        ${name_facebook}                ${name_facebook}                     86,600,000

*** Keywords ***

เปิดหน้าเว็บ Google 
    log to console    เปิดหน้าเว็บ Google
    Open Browser        browser=${browser}     url=https://www.google.com/   
     

กรอกคำค้นหา
    log to console    กรอกคำค้นหา
    [Arguments]    ${input}
    Input Text        name=q        text=${input}

กดปุ่มค้นหา
    log to console    กดปุ่มค้นหา
    Wait Until Element Is Visible         name=btnK    timeout=10s
    Wait Until Element Is Enabled         name=btnK    timeout=10s
    Click Element        name=btnK

ตรวจสอบข้อมูลคำค้นหา
    log to console    ตรวจสอบข้อมูลคำค้นหา
    [Arguments]    ${expected_message}    ${expected_result}
    ${actual_message}    Get Text    id=result-stats
    Log to console    ${actual_message}
    log    ${actual_message}
    LOG    ${actual_message}
    @{actual_result} =	Split String	${actual_message}	${SPACE}
    Log to console    ${actual_result}[1]
    log    ${actual_result}
    log    ${actual_result}[0]
    log    ${actual_result}[1]
    log    ${actual_result}[2]
    log    ${actual_result}[3]
    LOG    ${actual_result}[4]
    # Should be equal     ${actual_result}[1]    ${expected_result}
    Page Should Contain        ${expected_message}

ค้นหาข้อมูล และตรวจสอบคำค้น
    [Arguments]    ${input}    ${expected_message}    ${expected_result}
    When กรอกคำค้นหา        ${input}
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา    ${expected_message}    ${expected_result}
    [Teardown]    And กลับไปหน้าก่อนหน้า

กลับไปหน้าก่อนหน้า
    Go Back

ปิดหน้าเว็บ
    Close Browser

