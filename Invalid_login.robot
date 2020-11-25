*** Settings ***
Documentation     A test suite containing tests related to invalid login.
Resource          resource.robot


*** Variables ***

${invalid_user1}        hihello@123
${invalid_password1}    hihello@123

*** Test Cases ***
InValid Login Test
    Open Browser And Go To Login Page
    Input Username    ${invalid_user1}
    Input Password    ${invalid_password1}
    Submit Credentials
    Login Should Have Failed
    [Teardown]    Close Browser

