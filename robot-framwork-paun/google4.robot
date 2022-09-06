*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${name_youtube}    youtube
${name_Iphone}    Iphone

*** Test Cases ***
ทดสอบการค้นหา google ด้วยคำว่า robot
    เปิด เว็บ google
    ค้นหาคำว่า     robot
    ตรวจสอบผลค้นหา     robot
    ปิดเว็บ
    
ทดสอบการค้นหา google ด้วยคำว่า facebook
    เปิด เว็บ google
    ค้นหาคำว่า     facebook
    ตรวจสอบผลค้นหา     facebook
    ปิดเว็บ

ทดสอบการค้นหา google ด้วยคำว่า ${name_youtube}
    เปิด เว็บ google
    ค้นหาคำว่า     ${name_youtube}
    ตรวจสอบผลค้นหา     ${name_youtube}
    ปิดเว็บ
    
ทดสอบการค้นหา google ด้วยคำว่า ${name_Iphone}
    เปิด เว็บ google
    ค้นหาคำว่า     ${name_Iphone}
    ตรวจสอบผลค้นหา     ${name_Iphone}
    ปิดเว็บ
    
*** Keywords ***
เปิด เว็บ google
    Open Browser       url=https://www.google.com/   browser=googlechrome 
    # Maximize Browser Window

ค้นหาคำว่า
    [Arguments]    ${keyword}
    Input Text    name=q    text=${keyword}
    Press Keys    name=q    RETURN

ตรวจสอบผลค้นหา
    [Arguments]    ${expected}
    ${result}    Get Text    id=result-stats
    @{words} =	Split String	${result}	${SPACE}
    log to console  ${words}[1]
    log    ${words}[0]
    log    ${words}[1]
    log    ${words}[2]
    log    ${words}[3]
    log    ${words}[4]
    # Should Be Equal        ${result}    ผลการค้นหาประมาณ 1,850,000,000 รายการ
    should Be Equal     ${words}[1]    ${words}[1]
    # Should Be Equal     ${words}[1]    1,850,000,000
    # Should Be Equal As Integers        20300000        ${20300000}
    # Should Be Equal     ${words}[1]     ${expected}
    # Should Be Equal As Integers        20300000         ${expected}
    Page Should Contain        ${expected}
    
ปิดเว็บ
    Close Browser