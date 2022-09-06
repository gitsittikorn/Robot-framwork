*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    keywords/global_keyword.robot
Resource    pages/home_page.robot
Resource    pages/login_page.robot
Resource    Variables/global_variable.robot
Suite Setup        เปิด หน้า Login
Suite Teardown     ปิด web
Test Teardown    Reload Page

*** Variables ***

${valid_username}       tomsmith
${valid_password}       SuperSecretPassword!

${invalid_username}     tomholland
${invalid_password}     Password!

*** Test Cases ***
Login with valid username and password
    เข้าสู่ระบบ        ${valid_username}            ${valid_password}
    แจ้งเตือน logged in สำเร็จ
    ออกจากระบบ
    [Teardown]    log  ทดสอบการทำ test teardown แยก

Login with valid username and invalid password
    เข้าสู่ระบบ        ${valid_username}        ${invalid_password}
    แจ้งเตือน invalid password

Login with invalid username and valid password
    เข้าสู่ระบบ        ${invalid_username}        ${valid_password}
    แจ้งเตือน invalid username

Login with invalid username and password
    เข้าสู่ระบบ        ${invalid_username}        ${invalid_password}
    แจ้งเตือน invalid username




