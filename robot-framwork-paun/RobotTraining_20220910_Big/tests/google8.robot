*** Settings ***
Library    SeleniumLibrary
Library    String
Suite Setup        Given เปิดหน้าเว็บ Google 
Test Setup        log  เริ่มการทดสอบในเทสเคส
Resource   pages/keyword_google_page.robot
Resource   variables/rariable_google.robot

Suite Teardown     And ปิดหน้าเว็บ
Test Template        ค้นหาข้อมูล และตรวจสอบคำค้น



*** Test Cases ***
TC_005 - ค้นหาข้อมูล ด้วย ข้อมูลหลายชุด
    [Tags]    main    all 
    [Template]    ค้นหาข้อมูล และตรวจสอบคำค้น
#        Input                         expected_message                expected_result
        Robot framework                 Robot framework                    92,000,000
        Selenium Library                Selenium Library                    86,600,000
        Youtube                         Youtube                            92,000,000
        ${name_facebook}                ${name_facebook}                     86,600,000

#        Input                         expected_message                expected_result
TC_006 - ค้นหาข้อมูล ด้วย      
    [Tags]    all    critical
        Robot framework                 Robot framework                    92,000,000

TC_007 - ค้นหาข้อมูล ด้วย      
    [Tags]    all
        Selenium Library                Selenium Library                    86,600,000

TC_008 - ค้นหาข้อมูล ด้วย      
    [Tags]    all    critical
        Youtube                         Youtube                            92,000,000

TC_009 - ค้นหาข้อมูล ด้วย      
    [Tags]    all
        ${name_facebook}                ${name_facebook}                     86,600,000

