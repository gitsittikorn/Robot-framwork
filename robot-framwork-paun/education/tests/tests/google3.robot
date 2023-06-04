*** Settings ***
Library    SeleniumLibrary


*** Test Cases ***
TC_001 - ค้นหาข้อมูล ด้วย Robot framework
    Given เปิดหน้าเว็บ Google 
    When กรอกคำค้นหา     Robot framework
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     Robot framework
    And ปิดหน้าเว็บ

TC_002 - ค้นหาข้อมูล ด้วย Selenium Library
    Given เปิดหน้าเว็บ Google 
    When กรอกคำค้นหา     Selenium Library
    And กดปุ่มค้นหา
    Then ตรวจสอบข้อมูลคำค้นหา     Selenium Library
    And ปิดหน้าเว็บ

*** Keywords ***

เปิดหน้าเว็บ Google 
     Open Browser        browser=chrome     url=https://www.google.com/   

กรอกคำค้นหา
    [Arguments]    ${input}
    Input Text        name=q        text=${input}

กดปุ่มค้นหา
    Wait Until Element Is Visible         name=btnK    timeout=10s
    Wait Until Element Is Enabled         name=btnK    timeout=10s
    Click Element        name=btnK

ตรวจสอบข้อมูลคำค้นหา
    [Arguments]    ${expected}
     Page Should Contain        ${expected}

ปิดหน้าเว็บ
    Close Browser

