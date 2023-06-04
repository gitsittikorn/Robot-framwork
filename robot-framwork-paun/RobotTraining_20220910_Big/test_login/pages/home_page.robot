*** Settings ***
Library    SeleniumLibrary

*** Keywords ***


ออกจากระบบ
    Click Element      xpath=//*[@class="button secondary radius"]


แจ้งเตือน logged in สำเร็จ
    ${alert_message}=    Get text  xpath=//*[@class="flash success"]
    Should be Equal        ${alert_message}        You logged into a secure area! ×    collapse_spaces=True