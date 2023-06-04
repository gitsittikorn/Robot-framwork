*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${name_youtube}    Youtube
${name_facebook}    Facebook
${browser}    chrome
# ${browser}    headlesschrome

*** Test Cases ***
TC_001 - ค้นหาข้อมูล ด้วย Robot framework
    Given เปิดหน้าเว็บ Google 
    When กรอกคำค้นหา     Robot framework
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     Robot framework    92,000,000
    And ปิดหน้าเว็บ

TC_002 - ค้นหาข้อมูล ด้วย Selenium Library
    Given เปิดหน้าเว็บ Google 
    When กรอกคำค้นหา     Selenium Library
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     Selenium Library    86,600,000
    And ปิดหน้าเว็บ

TC_003 - ค้นหาข้อมูล ด้วย Youtube
    Given เปิดหน้าเว็บ Google 
    When กรอกคำค้นหา     ${name_youtube}
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     ${name_youtube}    86,600,000
    And ปิดหน้าเว็บ

TC_004 - ค้นหาข้อมูล ด้วย ${name_facebook} 
    Given เปิดหน้าเว็บ Google 
    When กรอกคำค้นหา     ${name_facebook} 
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     ${name_facebook}     86,600,000
    And ปิดหน้าเว็บ

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

ปิดหน้าเว็บ
    Close Browser

