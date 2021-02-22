*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Begin the test case
    Open Browser                    about:blank     ${BROWSER}
Go to web page
    Load Page
    Verify Page Loaded
Load Page
    Go to                           ${URL}
Verify Page Loaded
    ${link_text}                    Get Title
    Should Be Equal                 ${link_text}        Handla billig mat online | Willys
Search for Products
    [Arguments]                     ${search_term}          # ${search_result}
    Enter Search Term               ${search_term}
    Submit Search
    Verify Search Completed         ${search_term}
Enter Search Term
    [Arguments]                     ${search_term}
    Input Text                      id:selenium--search-items-input                        ${search_term}
Submit Search
    Press Keys                      xpath://input[@id="selenium--search-items-input"]       RETURN
Verify Search Completed
    [Arguments]                     ${search_term}
    Wait Until Page Contains Element      xpath://*[@id="selenium--product-grid-header"]
    ${actucal_term}                 Get Text        xpath://*[@id="selenium--product-grid-header"]
    Should Be Equal                 "Sökord: ${search_term}"        "${actucal_term}"
End the test
    Close Browser
