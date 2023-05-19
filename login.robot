*** Settings ***
Library  OperatingSystem
Library  SeleniumLibrary
Library  Collections
Library  AutoItLibrary

*** Variables ***
${url}                https://mail.google.com/mail/
${Browser}            chrome
${Inputemail}         //input[@id='identifierId']
${btnNext}            //span[normalize-space()='Next'][1]
${Inputpassword}      (//input[@name='Passwd'])[1]
${errormessage}       (//span[contains(text(),'Wrong password. Try again or click Forgot password')])[1]
${emailaddress}       ""
${password}           ""



*** Keywords ***
User opens the browser
    Open Browser  ${url}    ${Browser} 
    Maximize Browser Window


*** Test Cases ***
1 Verify if a user can log in with a valid email address and password
    User opens the browser
    Input Text    ${Inputemail}    ${emailaddress}
    Click Element    ${btnNext}
    Sleep    15
    Input Password    ${Inputpassword}    ${password}
    Click Element    ${btnNext}

2 Verify if a user can log in with a valid email address and wrong password
    User opens the browser
    Input Text    ${Inputemail}    ${emailaddress}
    Click Element    ${btnNext}
    Sleep    15
    Input Password    ${Inputpassword}    Hello_world@7
    Click Element    ${btnNext}
    Sleep    10
    ${bool}=    Run Keyword And Return Status    Element Should Be Visible    ${errormessage}
    IF    ${bool} == False
        Fail
    END