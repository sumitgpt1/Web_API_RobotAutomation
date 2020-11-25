*** Settings ***
Documentation       API Test cases using Robot Automation
Test Timeout        1 minute
Resource            API_Keywords.robot

*** Test Cases ***
Create_New_Machine
    [Tags]  Add_Machine
    CREATE SESSION TO SERVER
    CREATE MACHINE  ${URI}

Get_All_Machines
    [Tags]  Get_All_Machine
    CREATE SESSION TO SERVER
    ${json}  DUMMY API GET CONTENTS  ${URI}
    Log To Console  ${json}
    Log  ${json}

Get_Created_Machine
    [Tags]  Get_Machine
    CREATE SESSION TO SERVER
    DUMMY API GET CONTENTS  ${GetMachine}

Delete_Existed_Machine
    [Tags]  Delete_Machine
    CREATE SESSION TO SERVER
    DELETE MACHINE  ${MachineId}

Create_Multiple_Machines
    [Tags]  Add_Multiple_Machine
    CREATE SESSION TO SERVER
    CREATE MULTIPLE MACHINE  ${URI}