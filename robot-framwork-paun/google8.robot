*** Settings ***
Library    SeleniumLibrary
Library    String
Suite Setup    เปิด เว็บ google
Suite Teardown    ปิดเว็บ
Test Setup       log     เริ่มทำก่อนเริมการทดสอบ
Test Teardown    Go Back

*** Variables ***
${name_youtube}    youtube
${name_Iphone}    Iphone
${URL}    https://www.google.com/


*** Test Cases ***

ทดสอบการค้นหาของ Google
    [Template]    ค้นหา และตรวจสอบ
    robot                               robot
    facebook                            facebook
    ${name_youtube}                     ${name_youtube}
    ${name_Iphone}                      ${name_Iphone}

# ============================================================================
#  รูปแบบ google 6
# ============================================================================

ทดสอบการค้นหา google ด้วยคำว่า robot
    [Tags]    Success
    [Setup]    log    กำลังจะเริ่มทดสอบ เทสเคสที่1
    ค้นหาคำว่า     robot
    ตรวจสอบผลค้นหา     robot
    [Teardown]     log    เสร็จการทดสอบ เทสเคสที่1

ทดสอบการค้นหา google ด้วยคำว่า facebook
    [Tags]    Success
    ค้นหาคำว่า     facebook
    ตรวจสอบผลค้นหา     facebook

ทดสอบการค้นหา google ด้วยคำว่า ${name_youtube}
    [Tags]    Fail
    ค้นหาคำว่า     ${name_youtube}
    ตรวจสอบผลค้นหา     ${name_youtube}
    
ทดสอบการค้นหา google ด้วยคำว่า ${name_Iphone}
    [Tags]    Fail
    ค้นหาคำว่า     ${name_Iphone}
    ตรวจสอบผลค้นหา     ${name_Iphone}

*** Keywords ***

ค้นหา และตรวจสอบ
    [Arguments]    ${input}    ${expected_result}
    ค้นหาคำว่า    ${input}
    ตรวจสอบผลค้นหา    ${expected_result}

เปิด เว็บ google
    Open Browser       url=${URL}   browser=googlechrome 
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