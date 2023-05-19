*** Settings ***
Library  OperatingSystem
Library  SeleniumLibrary
Library  Collections
Library  AutoItLibrary

*** Variables ***
${url}            https://mail.google.com/mail/
${Browser}        chrome


${lnkcreateacc}         (//span[normalize-space()='Create account'])[1]
${selectOpt}            (//span[normalize-space()='For my personal use'])[1]
${inputfirstname}         (//input[@id='firstName'])[1]
${inputlastname}          (//input[@id='lastName'])[1]
${inputusername}          (//input[@id='username'])[1]
${inputpassword}          (//input[@name='Passwd'])[1]
${inputconfpassword}      (//input[@name='ConfirmPasswd'])[1]
${btnnext}              (//span[normalize-space()='Next'])[1]
${inputphonenum}        (//input[@id='phoneNumberId'])[1]
${errormessage1}        (//div[@id='nameError'])[1]
${errormessage2}        (//span[normalize-space()='Enter a password'])[1]
${errormessage3}        //span[normalize-space()='Enter first and last names'][1]
${errormessage4}        /html[1]/body[1]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/form[1]/span[1]/section[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[2]/div[1]


${firstname}            Test
${lastname}             Testing
${username}             Test.TestingSA
${password}             B@sic.159
${phonenum}             0842102497           


*** Keywords ***
User opens the browser
    Open Browser  ${url}    ${Browser} 
    Maximize Browser Window
    Click Element    ${lnkcreateacc}
    Sleep    6
    Click Element    ${selectOpt}


*** Test Cases ***
1 Verify the messages for each mandatory field.
    User opens the browser
    Click Element    ${btnnext}
    ${bool1}=    Run Keyword And Return Status    Element Should Be Visible    ${errormessage2}
    ${bool2}=    Run Keyword And Return Status    Element Should Be Visible    ${errormessage3}
    ${bool3}=    Run Keyword And Return Status    Element Should Be Visible    ${errormessage4}
    Sleep    30
    IF    ${bool1} == False 
        Fail    test failed
    ELSE IF     ${bool2} == False
        Fail    test failed
    ELSE IF     ${bool3} == False
        Fail    test failed
    END



2 Verify if the user cannot proceed without filling all the mandatory fields
    User opens the browser
    Input Text    ${inputfirstname}    ${firstname}
    Input Text    ${inputlastname}     ${lastname}
    Input Text    ${inputusername}    ${username}
    #Input Password    ${inputpassword}    ${password}
    Click Element    ${btnnext}
    Sleep    30
    ${bool}=    Run Keyword And Return Status    Element Should Be Visible    ${errormessage2}
    IF    ${bool} == False
        Fail    test failed
    END

3 Verify if the numbers and special characters are not allowed in the First and Last name
    User opens the browser
    Input Text    ${inputfirstname}    Test@45
    Input Text    ${inputlastname}     Testing@46
    Input Text    ${inputusername}    ${username}
    Input Password    ${inputpassword}    ${password}
    Input Password    ${inputconfpassword}    ${password}
    Click Element    ${btnnext}
    Sleep    10
    ${bool}=    Run Keyword And Return Status    Element Should Be Visible    ${errormessage1}
    IF    ${bool} == False
        Fail    test failed
    END

4 Verify if a user can sign-up successfully with all the mandatory details
    User opens the browser
    Input Text    ${inputfirstname}    ${firstname}
    Input Text    ${inputlastname}     ${lastname}
    Input Text    ${inputusername}    ${username}
    Input Password    ${inputpassword}    ${password}
    Input Password    ${inputconfpassword}    ${password}
    Click Element    ${btnnext}
    Sleep    15
    Input Text    ${inputphonenum}    ${phonenum}
    Click Element    ${btnnext}