# Web_API_RobotAutomation
This is Initial draft of code

Required Softwares and plugins to run testsuite:
---------------------

requests==2.22.0
robotframework-requests==0.5.0
robotframework >= 3.1.1
robotframework-seleniumlibrary >= 3.3.1
robotframework-selenium2library==3.0.0

how to run testsuite:
---------------------
1. Do provide/modify the 'Ui_Test_Cases.robot' file, to provide the test cases information to the framework
To run the UI related test cases, execute "robot Ui_Test_Cases.robot" command in project path in terminal path

2. Do provide/modify the 'API_TestCases.robot' file, to provide the test cases information to the framework
To run the API related test cases, execute "robot API_TestCases.robot" command in project path in terminal path

3. Do provide/modify the 'API_Keywords.robot' file, to provide the Variables and Keywords information to the framework
4. Do provide/modify the 'resource.robot' file, to provide the Variables and Keywords information to the framework

5. Once the test gets executed, logs and reports gets generated in below path
   -- LOGS path: ./log.html
   -- output path: ./output.xml
   -- reports path: ./report.html