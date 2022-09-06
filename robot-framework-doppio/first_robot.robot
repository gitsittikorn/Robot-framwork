*** Settings ***
Library     SeleniumLibrary 


*** Variables ***
${Username}                Sittikorn
${Brower_ch}               chrome
${URL_google}              https://www.google.com
${URL_ebay}                https://www.ebay.com
${URL_ex00}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex00.html
${URL_ex01}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex01.html
${URL_ex02}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex02.html
${URL_ex03}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex03.html
${URL_ex04}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex04.html
${URL_ex05}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex05.html
${URL_ex06}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ex06.html
${URL_ex07}                file:///C:/Users/m_sit/Downloads/ep01_material/ep01/ep01_small_excercise.html




*** Keywords ***
Say Hello
    Log To Console    This Is Say Hello


*** Test Cases ***
# TC--001 Verify that when input correct username and password then user can login
#     Log To Console     TC001
# TC--002 Verify that when input wrong username or password then user can't login
#     Log To Console     TC002
# TC--003 Call Keyword Say Helo
#     Say Hello
# TC--004 Call Variable Message
#     Log To Console    ${Username}
# TC--005 Opne brower 
    # Open Browser        ${URL_google}           ${Brower_ch}   
    # Input Text           name=q                 Automate robot framework

    # Open Browser        ${URL_ebay}             ${Brower_ch}   
    # Input Text           id=gh-ac               Automate robot framework

# Exmaple by Doppio    
# TC--EX00 
#     Open Browser        ${URL_ex00}             ${Brower_ch}   
#     Input Text           id=username-box         EX00 user
#     Input Text           id=password-box         EX00 password

# TC--EX01 
#     Open Browser        ${URL_ex01}                     ${Brower_ch}   
#     Input Text           xpath=//input[@v='user']         EX01 user
#     Input Text           xpath=//input[@v='password']     Ex01 password

# TC--EX02 
#     Open Browser        ${URL_ex02}                         ${Brower_ch}   
#     Input Text           xpath=//div[@v='username']/input     EX02 user
#     Input Text           xpath=//div[@v='password']/input     EX02 password

# TC--EX03 Contains
#     Open Browser        ${URL_ex03}                                     ${Brower_ch}   
#     Input Text           xpath=//div[contains(@v,'username')]/input     EX03 user
#     Input Text           xpath=//div[contains(@v,'password')]/input     EX03 password

# TC--EX04 Div/Span
#     Open Browser        ${URL_ex04}                                     ${Brower_ch}   
#     Input Text           xpath=//div[span[@c='Username']]/input     EX04 user
#     Input Text           xpath=//div[span[@c='Password']]/input     EX04 password

# TC--EX05
#     Open Browser        ${URL_ex05}                                     ${Brower_ch}   
#     Input Text           xpath=//div[span[text()='User:']]/input     EX05 user
#     Input Text           xpath=//div[span[text()='Pass:']]/input     EX05 password

# TC--EX06
#     Open Browser        ${URL_ex06}                                     ${Brower_ch}   
#     Input Text           xpath=//div[@k='abc' and @p='xyz']/input     EX06 user 
     
TC--EX07
    Open Browser        ${URL_ex07}                                     ${Brower_ch}   
    Input Text          id=username-box                                 EX07 Username 
    Input Text          xpath=//div[@v='password']/input                EX07 Password 
    Input Text          xpath=//input[@doppio='nickname']               EX07 Nickname 
    Click Element       xpath=//option[@value='doppio']
    Click Button        xpath=//input[@id='op1']
    Click Button        xpath=//button[@id='use-me']