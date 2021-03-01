*** Settings ***
Library  SeleniumLibrary

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
Verify Page About Loaded
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
Varify MyPage and Logout button
    Wait Until Page Contains Element        //*[@id="mypage"]
    Click Button                            //*[@id="mypage"]
    Page Should Contain                     My bookings
    Wait Until Page Contains Element        //*[@id="logout"]
    Click Button                            //*[@id="logout"]
    Page Should Contain Button        //*[@id="login"]

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
    Page Should Contain Button        //*[@id="login"]
End the test
    Click Element               //*[@id="title"]
    Wait Until Page Contains Element         //*[@id="reset"]
    Click Button                //*[@id="reset"]
    Close Browser