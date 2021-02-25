*** Settings ***
Documentation       Test Infortiv Car Rental web,
...                 for the G part we test functionalities of Header and Date Selection
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
Go To Web
    Load Web
    Verify Page Loaded
Load Web
    Go To                   ${URL}
Verify Page Loaded
    ${GET_TITLE}            Get Title
    Should Be Equal         ${GET_TITLE}        Infotiv Car Rental
    Page Should Contain     When do you want to make your trip?
Click About
    Press Keys              //*[@id="about"]        RETURN
Verify Page About
    [Arguments]             ${BUTTON}
    Wait Until Page Contains Element        //*[@id="linkButton"]
    ${ACUTAL_BUTTON}      Get Text        //*[@id="linkButton"]
    Should Be Equal         "${BUTTON}"       "${ACUTAL_BUTTON}"
End the test
    Close Browser


*** Test Cases ***
User can access the web site
    [Documentation]         This is to test if the web site can be opened on browser
    [Tags]                  1_accessable
    Go To Web

User can access documentation page
    [Documentation]         User can access documentation page by clicking ABOUT button
    [Tags]                  2_about
    Go To Web
    Click About
    Verify Page About       Documentation