*** Keywords ***

เปิด หน้า Login
    Open Browser    ${URL}    browser=chrome
    Maximize Browser Window
    Page Should Contain   Login Page

ปิด web
    Close Browser

กดย้อนกลับ
    Go Back