*** Settings ***
Documentation       Test Infortiv Car Rental web,
...                 for the VG part I test by using Gherkin syntax
Resource            ../TestLabAuto/Resource/keywords.robot
Library             SeleniumLibrary
Force Tags          VG_Test
Suite Setup          Generate Tests
Suite Teardown       End the test

*** Variables ***
${BROWSER}          chrome
${URL}              http://www.rental8.infotiv.net/

*** Test Cases ***
# I set Forced Tag in settings, then all the test cases in this suite will be added this tag automatically
User book a car online
    Given I open the browser go to the web
    When I click the login button
    And I can login
    And I select the date to continue       03/03/2021      03/30/2021
    And I click continue-button to continue
    And I open the page with list of cars          Make        Passengers
    And I select the car-brand and size
    And I can see cars-selected in the list
    And I click Book button to book Audi Q7 with 5 passengers
    And I can see the page to confirm my booking and I fill in the forms       1234567891234567    feng    123
    Then My booking is confirmed and I can see or cancel my booking on MyPage


*** Keywords ***
I open the browser go to the web
    Go To Web
I click the login button
    Login Account       feng.zhu@iths.se        abc123
I can login
    Verify Login
I select the date to continue
    [Arguments]             ${START_DAY}        ${END_DAY}
    Input Text              //input[@id="start"]            ${START_DAY}
    Input Text              //input[@id="end"]              ${END_DAY}
I click continue-button to continue
    Press Keys              //*[@id="continue"]             RETURN
I open the page with list of cars
    [Arguments]             ${FILTER_MAKE}          ${FILTER_PASSENGERS}
    Page Should Contain             What would you like to drive?
    Wait Until Page Contains Element        //*[@id="carSelection"]
    Wait Until Page Contains Element        //*[@id="ms-list-1"]/button
    ${MAKE}                 Get Text        //*[@id="ms-list-1"]/button
    Should Be Equal         "${FILTER_MAKE}"        "${MAKE}"
    Wait Until Page Contains Element        //*[@id="ms-list-2"]/button
    ${PASSENGERS}           Get Text        //*[@id="ms-list-2"]/button
    Should Be Equal         "${FILTER_PASSENGERS}"        "${PASSENGERS}"
I select the car-brand and size
    Click Element               //*[@id="ms-list-1"]/button
    Select Checkbox             //*[@id="ms-opt-1"]
    # I only give one selection in passenger list, but always 2 checkbox are selected
    # Click Element               //*[@id="ms-list-2"]/button
    # Select Checkbox             //*[@id="ms-opt-6"]
    Page Should Contain         Q7
I can see cars-selected in the list
    Page Should Contain Element         //*[@id="carSelection"]
I click Book button to book Audi Q7 with 5 passengers
    Wait Until Page Contains Element    //*[@id="carSelect1"]
    Press Keys              //input[@id="carSelect1"]           RETURN      # Click Button does't work, Press Keys works
I can see the page to confirm my booking and I fill in the forms
    [Arguments]                 ${CARD_NUM}     ${CARD_HOLDER}       ${CVC}
    Page Should Contain                     Confirm booking of Audi Q7
    Wait Until Page Contains Element        //*[@id="confirmSelection"]
    Page Should Contain Element             //*[@id="cardNum"]
    Input Text                              //input[@id="cardNum"]              ${CARD_NUM}
    Page Should Contain Element             //*[@id="fullName"]
    Input Text                              //input[@id="fullName"]             ${CARD_HOLDER}
    Page Should Contain Element             //*[@id="confirmSelection"]/form/select[1]
    Click Element                           //*[@id="confirmSelection"]/form/select[1]
    Click Element                           //*[@id="month2"]   # Select from list by label/index/value  doesn't work
    Page Should Contain Element             //*[@id="confirmSelection"]/form/select[2]
    Click Element                           //*[@id="confirmSelection"]/form/select[2]
    Click Element                           //*[@id="month2025"]
    Input Text                              //*[@id="cvc"]          ${CVC}
    Page Should Contain Button              //*[@id="cancel"]
    Page Should Contain Button              //*[@id="confirm"]
    Click Button                            //*[@id="confirm"]
My booking is confirmed and I can see or cancel my booking on MyPage
    Page Should Contain                     A Audi Q7 is now ready for pickup
    Wait Until Page Contains Element        //*[@id="home"]
    Page Should Contain                     You can view your booking on your page
    Wait Until Page Contains Element        //*[@id="mypage"]
    Click Button                            //*[@id="mypage"]
    Page Should Contain Element             //*[@id="middlepane"]/table
    Page Should Contain Button              //*[@id="unBook1"]
