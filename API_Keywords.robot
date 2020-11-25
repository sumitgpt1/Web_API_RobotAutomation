*** Settings ***
Documentation       API Test using Robot Automation
Library             RequestsLibrary
Library             Collections

*** Variables ***
#ENDPOINTS              ---
${MachineId}            090fe6a7-5ab5-4dc1-a8b0-3c5c1f5f7823
${UserId}               974bfbdf-6d10-46e0-bac3-a39f7514a0a7
${BASE_URL}             https://frontend-test-api.herokuapp.com
${URI}                  /api/v1/users/${UserId}/vending_machines
${GetMachine}           /api/v1/users/${UserId}/vending_machines/${MachineId}

${VM1}                   41a75e55-f96b-4782-a6fd-37385b58f01c
${VM2}                   ef9d74f4-4e1e-4b2f-a44c-d7501f42fccb
${VM3}                   fc0eda1a-0201-45c7-ba62-9acd59235b18
${VM4}                   2caa9ece-cf04-47e2-868d-3717de8585d

${TEST}                 test
#LOOP COUNTER           ---
${COUNTER}              ${1}
#HEADERS                ---
${CONTENT_TYPE}         application/json
${200_response_code}    200
${201_response_code}    201
${404_response_code}    404
${500_response_code}    500
${422_response_code}    422

${longitude1}            30
${latitude1}             90

@{longitude}=  30  95  89  -92  80  -91
@{latitude}=  40  78  87  -181  78  -181

*** Keywords ***
CREATE SESSION TO SERVER
    &{session_headers}=  Create Dictionary  Content-Type=${CONTENT_TYPE}  Accept=application/json
    Create Session  alias=${TEST}  url=${BASE_URL}  headers=${session_headers}

DUMMY API GET CONTENTS
    [Arguments]  ${url}
    ${resp}=  Get Request  ${TEST}  ${url}
    log  ${resp}
    log  ${resp.status_code}
    Should Be Equal As Strings  ${resp.status_code}  ${200_response_code}  Response status code is ${resp.status_code}. Expected: ${200_response_code}
    ${json}=  Set Variable  ${resp.json()}
    [Return]  ${json}

CREATE MACHINE
    [Arguments]  ${url}
    ${body}=  set variable  {"vending_machine": {"longitude": ${longitude1},"latitude": ${latitude1}}}
    ${resp}=  Post Request  ${TEST}  ${url}  data=${body}
    ${json}=  Set Variable  ${resp.json()}
    Should Not Be Equal As Strings  ${resp.status_code}  ${422_response_code}  Response status code is ${resp.status_code}. Expected: ${201_response_code}
    ${json}=  Set Variable  ${resp.json()}
    log to console  ${json}

CREATE MULTIPLE MACHINE
    [Arguments]  ${url}
    ${failure_count}=  Set Variable  0
    @{failure_longitude_list}=  Create List
    @{failure_latitude_list}=  Create List
    Set Global Variable  ${failure_longitude_list}  ${failure_longitude_list}
    Set Global Variable  ${failure_latitude_list}  ${failure_latitude_list}
    ${longitude_length}=  Get Length  ${longitude}
    ${latitude_length}=  Get Length  ${latitude}
    Should Be Equal As Integers  ${longitude_length}  ${latitude_length}
    FOR    ${INDEX}    IN RANGE  0  ${longitude_length}
        ${body}=  set variable  {"vending_machine": {"longitude": ${longitude}[${INDEX}],"latitude": ${latitude}[${INDEX}]}}
        ${resp}=  Post Request  ${TEST}  ${url}  data=${body}
        Run Keyword If  ${resp.status_code}!=${201_response_code}  CREATE FAILURE LIST  ${longitude}[${INDEX}]  ${latitude}[${INDEX}]
        Run Keyword And Ignore Error  Run Keyword If  ${resp.status_code}!=${201_response_code}   Fail  Invalid pair: Longitude value is not correct ${longitude}[${INDEX}] Latitude value is not correct ${latitude}[${INDEX}]
     END
     ${failure_longitude_list_length}=  Get Length  ${failure_longitude_list}
     ${failure_latitude_list_length}=  Get Length  ${failure_latitude_list}
     Run Keyword If  ${failure_longitude_list_length}>0 and ${failure_latitude_list_length}>0  RETURN FAILURE PAIR OF LATITUDE & LONGITUDE  ${failure_longitude_list_length}
     Run Keyword If  ${failure_longitude_list_length}>0 and ${failure_latitude_list_length}>0  Fail  Kndly check valid pair of longitude and latitude

RETURN FAILURE PAIR OF LATITUDE & LONGITUDE
    [Arguments]  ${failure_list_size}
    FOR    ${INDEX}    IN RANGE  0  ${failure_list_size}
        Log To Console  longitude: ${failure_longitude_list}[${INDEX}] and latitude: ${failure_latitude_list}[${INDEX}] is not valid pair.
    END

CREATE FAILURE LIST
    [Arguments]  ${longitude}  ${latitude}
    Append To List  ${failure_longitude_list}  ${longitude}
    Append To List  ${failure_latitude_list}  ${latitude}

DELETE MACHINE
    [Arguments]  ${id}
    ${resp}=  Delete Request  ${TEST}  ${GetMachine}
    ${json}=  Set Variable  ${resp.json()}
    Log To Console  ${json}
