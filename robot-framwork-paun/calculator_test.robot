*** Settings ***
Library    SeleniumLibrary
Library    String
Suite Setup    Run Keywords    เปิด เว็บ BasicCalculator
                ...        เลือกชุดที่ 3 ในการทดสอบ 
Suite Teardown    ปิดเว็บ
Test Teardown    กดปุ่ม Clear 
*** Variables ***
${name_youtube}    youtube
${name_Iphone}    Iphone
${URL}    https://testsheepnz.github.io/BasicCalculator.html

*** Test Cases ***
ทดสอบการ บวก
    กรอก First number        2
    กรอก Second number        3
    เลือก Operation    Add
    กดปุ่ม calculateButton
    ตรวจสอบผลลัพธ์        5

ทดสอบการ ลบ
    กรอก First number        2
    กรอก Second number        3
    เลือก Operation    Subtract
    กดปุ่ม calculateButton
    ตรวจสอบผลลัพธ์        -1

ทดสอบการ คูณ
    กรอก First number        2
    กรอก Second number        3
    เลือก Operation    Multiply
    กดปุ่ม calculateButton
    ตรวจสอบผลลัพธ์        6

ทดสอบการ หาร
    กรอก First number        2
    กรอก Second number        3
    เลือก Operation    Divide
    กดปุ่ม calculateButton
    ตรวจสอบผลลัพธ์        0.6666666666666666

ทดสอบการ หาร แบบ Integer only
    กรอก First number        2
    กรอก Second number        3
    เลือก Operation    Divide
    กดปุ่ม calculateButton
    เลือก Integers only
    ตรวจสอบผลลัพธ์        0

ทดสอบการ ต่อกัน
    กรอก First number        2
    กรอก Second number        3
    เลือก Operation    Concatenate
    กดปุ่ม calculateButton
    ตรวจสอบผลลัพธ์        23


ทดสอบการ บวก ในแต่ละ build
    [Template]    ตรวจสอบการคำนวณ
#     Bulid No.    Number1    Operation    Number2        Expected
        1            2           Add         3                5
        2            2           Add         3                23
        3            2           Add         3                5
        4            2           Add         3                5
        5            2           Add         3                5
        6            2           Add         3                5
        7            2           Add         3                8
        8            2           Add         3                5


ทดสอบการ ลบ ในแต่ละ build
    [Template]    ตรวจสอบการคำนวณ
#     Bulid No.    Number1       Operation    Number2        Expected
        1            2           Subtract         3                -1
        2            2           Subtract         3                -1
        3            2           Subtract         3                -1
        4            2           Subtract         3                -1
        5            2           Subtract         3                -1
        6            2           Subtract         3                -1
        7            2           Subtract         3                -4
        8            2           Subtract         3                1
ทดสอบการ คูณ ในแต่ละ build
    [Template]    ตรวจสอบการคำนวณ
#     Bulid No.    Number1      Operation        Number2        Expected
        1            2           Multiply         3                6
        2            2           Multiply         3                6
        3            2           Multiply         3                6
        4            2           Multiply         3                6
        5            2           Multiply         3                6
        6            2           Multiply         3                6
        7            2           Multiply         3                18
        8            2           Multiply         3                6
ทดสอบการ หาร ในแต่ละ build
    [Template]    ตรวจสอบการคำนวณ
#     Bulid No.    Number1    Operation        Number2        Expected
        1            2           Divide         3                0.6666666666666666
        2            2           Divide         3                0.6666666666666666
        3            2           Divide         3                0.6666666666666666
        4            2           Divide         3                0
        5            2           Divide         3                0
        6            2           Divide         3                0
        7            2           Divide         3                0
        8            2           Divide         3                1

ทดสอบการ ต่อกัน ในแต่ละ build
    [Template]    ตรวจสอบการคำนวณ
#     Bulid No.    Number1    Operation            Number2        Expected
        1            2           Concatenate         3                23
        2            2           Concatenate         3                5
        3            2           Concatenate         3                23
        4            2           Concatenate         3                23
        5            2           Concatenate         3                23
        6            2           Concatenate         3                23
        7            2           Concatenate         3                233
        8            2           Concatenate         3                32

ทดสอบใน build 9
        [Template]   ตรวจสอบการคำนวณ ชุดที่ 9
#        Number1    Operation            Number2        Expected
            2           Add                 3               ${EMPTY}
            2           Subtract            3               ${EMPTY}
            2           Divide              3               ${EMPTY}
            2           Concatenate         3               ${EMPTY}

*** Keywords ***
เปิด เว็บ BasicCalculator
    Open Browser       url=${URL}   browser=googlechrome 
    # Maximize Browser Window

เลือกชุดที่ ${build} ในการทดสอบ 
    Scroll Element Into View    id=clearButton
    Click Element     id=selectBuild
    Select From List By Value    id=selectBuild    ${build}

กรอก First number
    [Arguments]    ${Input}
    Input Text    name=number1    text=${Input}

กรอก Second number
    [Arguments]    ${Input}

    Input Text    name=number2    text=${Input}

เลือก Operation
    [Arguments]    ${Operation}
        Select From List By Label    id=selectOperationDropdown    ${Operation}

กดปุ่ม calculateButton
    Click Element    id=calculateButton

ตรวจสอบผลลัพธ์
    [Arguments]    ${expected}
    Wait Until Element Is Visible     id=numberAnswerField    timeout=10s
    ${result}    Get Value    id=numberAnswerField
    Should Be Equal        ${result}    ${expected}

เลือก Integers only
    Wait Until Element Is Visible     id=integerSelect    timeout=10s
    Select Checkbox    id=integerSelect
    Checkbox Should Be Selected    id=integerSelect

กดปุ่ม Clear 
     Click Element     id=clearButton
    ${result}    Get Value    id=numberAnswerField
    log    ${result}
    log    ${EMPTY}
    Run Keyword If     '${result}' != '${EMPTY}'    Clear Element Text    Else    Log to console    Clear


ตรวจสอบปุ่ม calculateButton
    Element Should Not Be Visible    id=calculateButton

ปิดเว็บ
    Close Browser

ตรวจสอบการคำนวณ
    [Arguments]    ${build}   ${Input_1}    ${select_operation}     ${Input_2}        ${expected_result}
    เลือกชุดที่ ${build} ในการทดสอบ 
    กรอก First number    ${Input_1}
    กรอก Second number    ${Input_2}
    เลือก Operation    ${select_operation}
    กดปุ่ม calculateButton    
    ตรวจสอบผลลัพธ์        ${expected_result}

ตรวจสอบการคำนวณ ชุดที่ 9
    [Arguments]      ${Input_1}    ${select_operation}     ${Input_2}        ${expected_result}
    เลือกชุดที่ 9 ในการทดสอบ 
    กรอก First number    ${Input_1}
    เลือก Operation    ${select_operation}
    ตรวจสอบปุ่ม calculateButton
    ตรวจสอบผลลัพธ์        ${expected_result}