
*** Settings ***
Library    FakerLibrary 
*** Test Cases ***


FakerLibrary Words Generation
    ${words}=    FakerLibrary.Words
    Log    words: ${words}
    ${words}=    FakerLibrary.Words    nb=${10}
    Log    words: ${words}


Address
    ${Address}=    FakerLibrary.Address
    Log    ${Address}

Email
    ${Email}=    FakerLibrary.Email
     Log    ${Email}

Random Letters
    ${Letters}=    FakerLibrary.Random Letters    length=1
     Log    ${Letters}

Random Letter
    ${Uuid}=    FakerLibrary.Uuid 4
    Log    ${Uuid}
    ${Uuid}=    FakerLibrary.Uuid 4
    Log    ${Uuid}
    ${Uuid}=    FakerLibrary.Uuid 4
    Log    ${Uuid}
    ${Uuid}=    FakerLibrary.Uuid 4
    Log    ${Uuid}