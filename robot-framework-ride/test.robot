*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${URL}            https://google.com

*** Test Cases ***
google_homepage
    Open Browser    ${URL}    ${BROWSER}
    Input Text    q    sittikorn
    Click Element    q
    Sleep    1
    Click Button    btnK
    Sleep    3
    Close Browser

*** Keywords ***
