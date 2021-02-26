*** Settings ***
Documentation       Test Infortiv Car Rental web,
...                 for the G part we test functionalities of "About"-button ,"Create user"-button and Login-function
Library             SeleniumLibrary
Test Setup          Generate Tests
Test Teardown       End the test

*** Variables ***
${BROWSER}          chrome
${URL}              http://www.rental8.infotiv.net/
${SEARCH_TERM}

*** Keywords ***
Generate Tests
    Open Browser            about:blank     ${BROWSER}

# Access web page
Go To Web
    Load Web
    Verify Page Loaded
Load Web
    Go To                   ${URL}
Verify Page Loaded
    ${GET_TITLE}            Get Title
    Should Be Equal         ${GET_TITLE}        Infotiv Car Rental
    Page Should Contain     When do you want to make your trip?

# Button "About"
Click About
    [Arguments]             ${CLICK}
    Press Keys              ${CLICK}        RETURN
Verify Page About
    [Arguments]             ${BUTTON}
    Wait Until Page Contains Element        //*[@id="linkButton"]
    ${ACUTAL_BUTTON}      Get Text        //*[@id="linkButton"]
    Should Be Equal         "${BUTTON}"       "${ACUTAL_BUTTON}"

# Button "Creater user"
Access To Registration Page
    [Arguments]                 ${Create_expected}      ${Cancel_expected}
    Click Create User
    Verify Registration Page Loaded         ${Create_expected}      ${Cancel_expected}
Click Create User
    Press Keys                  //*[@id="createUser"]       RETURN
Verify Registration Page Loaded
    [Arguments]                 ${Create_expected}      ${Cancel_expected}
    Page Should Contain         Create a new user
    Wait Until Page Contains Element        //*[@id="create"]
    ${BUTTON_CREATE}        Get Text        //*[@id="create"]
    Should Be Equal         "${Create_expected}"       "${BUTTON_CREATE}"
    Wait Until Page Contains Element        //*[@id="cancel"]
    ${BUTTON_CANCEL}            Get Text        //*[@id="cancel"]
    Should Be Equal         "${Cancel_expected}"        "${BUTTON_CANCEL}"

# Function Login
Login Account
    [Arguments]                 ${email}        ${password}
    Enter Account Info          ${email}        ${password}
    Click Login
Enter Account Info
    [Arguments]                 ${email}        ${password}
    Input Text                  //input[@id="email"]        ${email}
    Input Text                  //input[@id="password"]     ${password}
Click Login
    Press Keys                  //*[@id="login"]        RETURN
Verify Login
    Page Should Contain         You are signed in as feng

Login Fail By Missing Account
    [Arguments]                 ${LOGIN_BUTTON_TEXT}        ${CREATE_BUTTON_TEXT}
    Wait Until Page Contains Element         //*[@id="login"]
    ${LOGIN_BUTTON}         Get Text         //*[@id="login"]
    Should Be Equal             "${LOGIN_BUTTON_TEXT}"    "${LOGIN_BUTTON}"
    Wait Until Page Contains Element         //*[@id="createUser"]
    ${CREATE_BUTTON}        Get Text         //*[@id="createUser"]
    Should Be Equal             "${CREATE_BUTTON_TEXT}"     "${CREATE_BUTTON}"

Login Fail By Wrong Input
    Page Should Contain         Wrong e-mail or password


End the test
    Close Browser


*** Test Cases ***
User can access the web site
    [Documentation]         This is to test if the web site can be opened on browser
    [Tags]                  Web_accessable
    Go To Web

User can access documentation page
    [Documentation]         User can access documentation page by clicking ABOUT button
    [Tags]                  About_page
    Go To Web
    Click About             //*[@id="about"]
    Verify Page About       Documentation

User can open regiseration page
    [Documentation]         User can access to the account registration page
    [Tags]                  Ready to register account
    Go To Web
    Access To Registration Page         Create      Cancel

User can legally login
    [Documentation]         User can login with correct account and password
    [Tags]                  Login
    Go To Web
    Login Account           feng.zhu@iths.se        abc123
    Verify Login

User can not login by Wrong/Missing Email or Password
    [Documentation]         User can not login by inputting wrong account or/and password, or missing login info
    [Tags]                  Login_failure
    Go To Web
    Login Account           jane@example.com        abc123
    Login Fail By Wrong Input
    Login Account           feng.zhu@iths.se        123abc
    Login Fail By Wrong Input
    Login Account           jane@example.com        123abc
    Login Fail By Wrong Input
    Login Account           \       abc123
    Login Fail By Missing Account       Login       Create\ user
    Login Account           feng.zhu@iths.se        \
    Login Fail By Missing Account       Login       Create\ user
    Login Account           \                   \
    Login Fail By Missing Account       Login       Create\ user