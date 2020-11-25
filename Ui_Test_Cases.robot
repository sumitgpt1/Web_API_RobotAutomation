*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Valid Login
    Open Browser And Go To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Welcome Page Should Be Open


Add Vending Machine
    Go To Location Tab
    Go To Add Location Tab
    Input Latitude    ${latitude}
    Input Longitude    ${longitude}
    Save Information
    Sleep  5s
    [Teardown]    Close Browser