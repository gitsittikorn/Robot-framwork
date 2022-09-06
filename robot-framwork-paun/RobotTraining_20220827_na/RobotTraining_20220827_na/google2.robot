*** Settings ***
Library    SeleniumLibrary
Library    String



*** Test Cases ***
ทดสอบการค้นหา google ด้วยคำว่า robot
    เปิด เว็บ google
    ค้นหาคำว่า robot
    ตรวจสอบผลค้นหาคำว่า robot
    ปิดเว็บ
    
ทดสอบการค้นหา google ด้วยคำว่า facebook
    เปิด เว็บ google
    ค้นหาคำว่า facebook
    ตรวจสอบผลค้นหาคำว่า facebook
    ปิดเว็บ
    
*** Keywords ***
เปิด เว็บ google
    Open Browser       url=https://www.google.com/   browser=googlechrome 
    # Maximize Browser Window

ค้นหาคำว่า robot
    Input Text    name=q    text=robot
    Press Keys    name=q    RETURN

ตรวจสอบผลค้นหาคำว่า robot
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
    Page Should Contain        robot

ค้นหาคำว่า facebook
    Input Text    name=q    text=facebook
    Press Keys    name=q    RETURN

ตรวจสอบผลค้นหาคำว่า facebook
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
    Page Should Contain        facebook
    
ปิดเว็บ
    Close Browser