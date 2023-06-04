*** Settings ***
Library    SeleniumLibrary


*** Test Cases ***
TC_001 - Open web browser Google
    Open Browser        browser=chrome     url=https://www.google.com/   
    Input Text        name=q        text=Robot framework
    Wait Until Element Is Visible         name=btnK    timeout=10s
    Wait Until Element Is Enabled         name=btnK    timeout=10s
    # sleep        10s
    Click Element        name=btnK
    Page Should Contain        Robot framework
    Close Browser



    # Given เปิดหน้าเว็บ Google 
    # When กรอกคำค้นหา
    # And กดปุ่มค้นหา
    # Then ตรวจสอบข้อมูลคำค้นหา

