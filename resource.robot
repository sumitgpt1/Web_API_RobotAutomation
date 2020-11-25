*** Settings ***
Documentation     UI resource file to store all variables & Keywords

Resource          resource.robot
Library             SeleniumLibrary
Library             Collections

*** Variables ***
${SiteURL}            https://dashboard-78fa7.web.app/
${disable_info_bars}                          --disable-infobars
${full_screen_mode}                           --kiosk
${chrome}                                     Chrome
${chrome _alias}                              full_chrome

${SERVER}         dashboard-78fa7.web.app
${BROWSER}        Chrome
${DELAY}          0
${INVALID USER}     demo@mytenten.com
${username}     demo@mytenten.com
${VALID PASSWORD}    demo123!
${password}    demo123!
${LOGIN URL}      https://${SERVER}/
${WELCOME URL}    https://${SERVER}/login
${ERROR URL}      https://${SERVER}/error.html
${Homepage}      Homepage
${Error_Page}      Error Page

${username}     demo@mytenten.com
${password}    demo123!
${submitBtn}    //button[@type='submit']
${saveBtn}    //button[contains(text(),'Save')]
${add_locationTab}    //button[contains(text(),'Add Location')]
${locationTab}    //span[contains(text(),'Locations')]
#${locationTab}    //body/div[@id='root']/div[1]/div[1]/div[1]/ul[1]/li[1]/a[2]/span[1]
#${locationTab}    //body/div[@id='root']/div[1]/div[1]/div[1]/ul[1]/li[1]/a[2]/div[2]
#${locationTab}    //*[@id='root']/div[1]/div[1]/div[1]/ul[1]/li[1]/a[2]/div[2]
${email_field}    email
${passwod_field}    password

${latitude}    90
${longitude}    180

${latitude_field}    latitude
${longitude_field}    longitude


*** Keywords ***
OPEN CHROME BROWSER
    ${options}=    Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method     ${options}    add_argument    --disable-notifications
    Call Method     ${options}    add_argument    --disable-gpu
    ${driver}=    Create Webdriver    Chrome    options=${options}    executable_path=${EXECDIR}/chromedriver
    maximize browser window

LAUNCH URL
    OPEN CHROME BROWSER
    Go To  ${SiteURL}

Open Browser And Go To Login Page
    OPEN CHROME BROWSER
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Go To Login Page

Login Page Should Be Open
    Sleep  3s
    Title Should Be    ${Homepage}

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    ${email_field}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${passwod_field}    ${password}

Submit Credentials
    Wait Until Element Is Visible  ${submitBtn}
    Click Button    ${submitBtn}

Save Information
    Wait Until Element Is Visible  ${saveBtn}
    Click Button    ${saveBtn}

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    ${Homepage}

Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed

Login Should Have Failed
    Location Should Be    ${ERROR URL}
    Title Should Be    ${Error_Page}

Go To Location Tab
    Sleep  5s
    Wait Until Element Is Visible  ${locationTab}
    Click Element    ${locationTab}

Go To Add Location Tab
    Wait Until Element Is Visible  ${add_locationTab}
    Click Button    ${add_locationTab}

Input Latitude
    [Arguments]    ${latitude}
    Input Text    ${latitude_field}    ${latitude}

Input Longitude
    [Arguments]    ${longitude}
    Input Text    ${longitude_field}    ${longitude}