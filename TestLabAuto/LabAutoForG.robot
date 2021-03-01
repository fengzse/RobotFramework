*** Settings ***
Documentation       Test Infortiv Car Rental web,
...                 for the G part we test functionalities of "About"-button ,"Create user"-button and Login-function
Resource            ../TestLabAuto/Resource/keywords.robot
Library             SeleniumLibrary
Test Setup          Generate Tests
Test Teardown       End the test

*** Variables ***
${BROWSER}          chrome
${URL}              http://www.rental8.infotiv.net/


# Includes two test cases for the main page to test "About" and "Create user" buttons
*** Test Cases ***
User can access the web site
    [Documentation]         This is to test if the web site can be opened on browser
    [Tags]                  Web_accessable
    Go To Web
*** Test Cases ***
User can access documentation page
    [Documentation]         User can access documentation page by clicking ABOUT button
    [Tags]                  About_page
    Go To Web
    Click About             //*[@id="about"]
    Verify Page About Loaded       Documentation
    Access to Documentation page
*** Test Cases ***
User can open regiseration page
    [Documentation]         User can access to the account registration page
    [Tags]                  Ready to register account
    Go To Web
    Access To Registration Page         Create      Cancel

# Includes two test cases to test Login function
*** Test Cases ***
User can legally login
    [Documentation]         User can login with correct account and password
    [Tags]                  Login
    Go To Web
    Login Account           feng.zhu@iths.se        abc123
    Verify Login
    Varify MyPage and Logout button
*** Test Cases ***
User can not login by Wrong/Missing Email or Password
    [Documentation]         User can not login by inputting wrong account or/and password, or missing login info
    [Tags]                  Login_failure
    Go To Web
    Login Account           jane@example.com        abc123
    Login Fail By Wrong Input
    Login Account           feng.zhu@iths.se        123ab
    Login Fail By Wrong Input
    Login Account           jane@example.com        123abc
    Login Fail By Wrong Input
    Login Account           \       abc123
    Login Fail By Missing Account       Login       Create\ user
    Login Account           feng.zhu@iths.se        \
    Login Fail By Missing Account       Login       Create\ user
    Login Account           \                   \
    Login Fail By Missing Account       Login       Create\ user

