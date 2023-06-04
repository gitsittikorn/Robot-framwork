
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
    And กลับไปหน้าก่อนหน้า

กลับไปหน้าก่อนหน้า
    Go Back

ปิดหน้าเว็บ
    Close Browser
