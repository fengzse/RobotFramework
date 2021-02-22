*** Settings ***
# 在Setting下，指定要导入的库 Library ，还可以在Documentation下添加有关测试套件的信息
Documentation       This is some basic info about the whole test suite
Resource            ../Resources/keywords.robot
Library             SeleniumLibrary
Suite Setup          Begin the test case
Suite Teardown       End the test

*** Variables ***
${BROWSER}          chrome
${URL}              https://www.willys.se/
${SEARCH_TERM}


*** Test Cases ***
# 这一行用于定义测试用例的名称和测试目标
User can access website
    [Documentation]                 This is some basic info about test
    [Tags]                          Test_1
    Go to web page

User search for a product
    [Documentation]                 This is some basic info about test
    [Tags]                          Test_2
    Go to web page
    Search for Products             kiwi        # Sökord: kiwi

User search for another product
    [Documentation]                 This is some basic info about test
    [Tags]                          Test_3
    Go to web page
    Search for Products             hundgodis       # Sökord: hundgodis