*** Settings ***
Test Setup        Initialize Variables
Test Teardown     Close Chrome Browser
Library           Selenium2Library
Library           SeleniumLibrary
Library           String

*** Variables ***
${url}            http://localhost:3000/
${browser}        chrome

*** Test Cases ***
Test_Case_1_Invalid_Email
    [Tags]    1
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    Enter Email Address    ${invalidEmail}
    Click Save Button
    Validate Email Address    invalid
    Enter Email Address    ${validEmail}
    Click Save Button
    Validate Email Address    valid
    Log    Test Case 1 Passed

Test_Case_2_Correct_Format_For _Days_For_Availability_Validation
    [Tags]    2
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    Enter Days for Availability    ${invalidDaysForAvailability}
    Click Save Button
    Validate Correct Format Days for Availability    invalid
    Enter Days for Availability    ${validDaysForAvailability}
    Click Save Button
    Validate Correct Format Days for Availability    valid
    Log    Test Case 2 Passed

Test_Case_3_Fields_Are_Displayed
    [Tags]    3
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    # Full name label and textbox
    SeleniumLibrary.Wait Until Element is Visible    //label[@name='fullNameLbl'][text()='Full Name']
    SeleniumLibrary.Wait Until Element is Visible    //input[@name='fullName']
    # Email Address label and textbox
    SeleniumLibrary.Wait Until Element is Visible    //label[@name='emailLbl'][text()='Email']
    SeleniumLibrary.Wait Until Element is Visible    //input[@name='email']
    # Flexible checkbox
    SeleniumLibrary.Wait Until Element is Visible    //input[@name='flexibleCheckbox']
    # Days for Availability label and textbox
    SeleniumLibrary.Wait Until Element is Visible    //label[@name='daysAvailLbl']
    SeleniumLibrary.Wait Until Element is Visible    //input[@name='daysAvail']
    # Save button
    SeleniumLibrary.Wait Until Element is Visible    //button[@name='submitBtn']
    Log    Test Case 3 Passed

Test_Case_4_Require_Full_Name_Validation
    [Tags]    4
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    Enter Full Name    ${EMPTY}
    Click Save Button
    Validate Require Full Name    invalid
    Enter Full Name    ${validFullName}
    Click Save Button
    Validate Require Full Name    valid
    Log    Test Case 4 Passed

Test_Case_5_Max_Length_For_Full_Name_Validation
    [Tags]    5
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    Enter Full Name    ${fullName100Char}
    Validate 100 Max Length For Full Name    ${fullName100Char}
    Enter Full Name    ${fullName101Char}
    Validate 100 Max Length For Full Name    ${fullName101Char}
    Log    Test Case 5 Passed

Test_Case_6_Flexible_and_Days_For_Availability_Validation
    [Tags]    6
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    # Flexible = true
    SeleniumLibrary.Click Element    //input[@name='flexibleCheckbox']
    Click Save Button
    Validate Require Days for Availability    not required
    SeleniumLibrary.Click Element    //input[@name='flexibleCheckbox']
    Click Save Button
    Validate Require Days for Availability    required
    Log    Test Case 6 Passed

Test_Case_7_All_Error_Message_Validation
    [Tags]    7
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Wait Until Element is Visible    //div[@class='ui form']
    Verify Error Message for Full Name, Email, and Days Format
    Verify Error Message for Email and Days Format
    Verify Error Message for Full Name and Days Format
    Verify Error Message for Full Name and Email
    SeleniumLibrary.Click Element    //input[@name='flexibleCheckbox']
    Verify Error Message for Full Name, Email, and Days Require
    Verify Error Message for Email and Days Require
    Verify Error Message for Full Name and Days Require
    Verify No Error Message is Displayed
    Log    Test Case 7 Passed

*** Keywords ***
Initialize Variables
    # Invalid Data
    ${invalidEmail}    Set Variable    emailAddress.com
    Set Global Variable    ${invalidEmail}
    ${invalidDaysForAvailability}    Set Variable    ABCD
    Set Global Variable    ${invalidDaysForAvailability}
    # Valid Data
    ${validFullName}    Set Variable    Juan Dela Cruz
    Set Global Variable    ${validFullName}
    ${validEmail}    Set Variable    testEmail@test.com
    Set Global Variable    ${validEmail}
    ${validDaysForAvailability}    Set Variable    5
    Set Global Variable    ${validDaysForAvailability}
    # Full name max length test data
    ${fullName100Char}    Set Variable    100_CHARACTER_STRING00000000000000000000000000000000000000000000000000000000000000000000000012345678
    Set Global Variable    ${fullName100Char}
    ${fullName101Char}    Set Variable    101_CHARACTER_STRING000000000000000000000000000000000000000000000000000000000000000000000000123456789
    Set Global Variable    ${fullName101Char}
    # Error Messages
    ${errorOnFullName}    Set Variable    Full name is required
    Set Global Variable    ${errorOnFullName}
    ${errorOnEmail}    Set Variable    This is not a valid email address format
    Set Global Variable    ${errorOnEmail}
    ${errorOnDaysFormat}    Set Variable    Days for Availability only accepts numbers
    Set Global Variable    ${errorOnDaysFormat}
    ${errorOnDaysRequired}    Set Variable    Days for Availability is required
    Set Global Variable    ${errorOnDaysRequired}

Enter Full Name
    [Arguments]    ${name}
    SeleniumLibrary.Wait until Element is Visible    //input[@name='fullName']
    SeleniumLibrary.Input text    //input[@name='fullName']    ${name}

Enter Email Address
    [Arguments]    ${emailAdd}
    SeleniumLibrary.Wait until Element is Visible    //input[@name='email']
    SeleniumLibrary.Input text    //input[@name='email']    ${emailAdd}

Enter Days for Availability
    [Arguments]    ${numOfDays}
    SeleniumLibrary.Wait until Element is Visible    //input[@name='daysAvail']
    SeleniumLibrary.Input text    //input[@name='daysAvail']    ${numOfDays}
    Click Save Button

Click Save Button
    SeleniumLibrary.Wait until Element is Visible    //button[@name='submitBtn']
    SeleniumLibrary.Click Element    //button[@name='submitBtn']

Validate Require Full Name
    [Arguments]    ${checking}
    ${isValid}    Run Keyword and Return Status    Should be Equal    ${checking}    valid
    Run Keyword If    ${isValid}    SeleniumLibrary.Wait until Element is Not Visible    //div[@class='fullName-wrapper']/p[text()='${errorOnFullName}']
    ...    ELSE    SeleniumLibrary.Wait until Element is Visible    //div[@class='fullName-wrapper']/p[text()='${errorOnFullName}']

Validate 100 Max Length For Full Name
    [Arguments]    ${expectedValue}
    ${inputtedText}    SeleniumLibrary.Get Value    //input[@name='fullName']
    ${maxExpectedValue}    String.Get Substring    ${expectedValue}    0    100
    Should be Equal    ${inputtedText}    ${maxExpectedValue}

Validate Email Address
    [Arguments]    ${checking}
    ${isValid}    Run Keyword and Return Status    Should be Equal    ${checking}    valid
    Run Keyword If    ${isValid}    SeleniumLibrary.Wait until Element is Not Visible    //div[@class='email-wrapper']//p[text()='${errorOnEmail}']
    ...    ELSE    SeleniumLibrary.Wait until Element is Visible    //div[@class='email-wrapper']//p[text()='${errorOnEmail}']

Validate Correct Format Days for Availability
    [Arguments]    ${checking}
    ${isValid}    Run Keyword and Return Status    Should be Equal    ${checking}    valid
    Run Keyword If    ${isValid}    SeleniumLibrary.Wait until Element is Not Visible    //div[@class='days-availability-wrapper']//p[text()='${errorOnDaysFormat}']
    ...    ELSE    SeleniumLibrary.Wait until Element is Visible    //div[@class='days-availability-wrapper']//p[text()='${errorOnDaysFormat}']

Validate Require Days for Availability
    [Arguments]    ${checking}
    ${isRequired}    Run Keyword and Return Status    Should be Equal    ${checking}    required
    Run Keyword If    ${isRequired}    SeleniumLibrary.Wait until Element is Visible    //div[@class='days-availability-wrapper']//p[text()='${errorOnDaysRequired}']
    ...    ELSE    SeleniumLibrary.Wait until Element is Not Visible    //div[@class='days-availability-wrapper']//p[text()='${errorOnDaysRequired}']

Verify Error Message for Full Name, Email, and Days Format
    SeleniumLibrary.Press Keys    //input[@name='fullName']    CTRL+a+BACKSPACE
    Enter Email Address    ${invalidEmail}
    Enter Days for Availability    ${invalidDaysForAvailability}
    Click Save Button
    Validate Require Full Name    invalid
    Validate Email Address    invalid
    Validate Correct Format Days for Availability    invalid
    Validate Require Days for Availability    not required

Verify Error Message for Email and Days Format
    Enter Full Name    ${validFullName}
    Enter Email Address    ${invalidEmail}
    Enter Days for Availability    ${invalidDaysForAvailability}
    Click Save Button
    Validate Require Full Name    valid
    Validate Email Address    invalid
    Validate Correct Format Days for Availability    invalid
    Validate Require Days for Availability    not required

Verify Error Message for Full Name and Days Format
    SeleniumLibrary.Press Keys    //input[@name='fullName']    CTRL+a+BACKSPACE
    SeleniumLibrary.Press Keys    //input[@name='email']    CTRL+a+BACKSPACE
    Enter Days for Availability    ${invalidDaysForAvailability}
    Click Save Button
    Validate Require Full Name    invalid
    Validate Email Address    valid
    Validate Correct Format Days for Availability    invalid
    Validate Require Days for Availability    not required

Verify Error Message for Full Name and Email
    SeleniumLibrary.Press Keys    //input[@name='fullName']    CTRL+a+BACKSPACE
    Enter Email Address    ${invalidEmail}
    SeleniumLibrary.Click Element    //input[@name='flexibleCheckbox']
    SeleniumLibrary.Press Keys    //input[@name='daysAvail']    CTRL+a+BACKSPACE
    Click Save Button
    Validate Require Full Name    invalid
    Validate Email Address    invalid
    Validate Correct Format Days for Availability    valid
    Validate Require Days for Availability    not required

Verify Error Message for Full Name, Email, and Days Require
    SeleniumLibrary.Press Keys    //input[@name='fullName']    CTRL+a+BACKSPACE
    Enter Email Address    ${invalidEmail}
    SeleniumLibrary.Press Keys    //input[@name='daysAvail']    CTRL+a+BACKSPACE
    Click Save Button
    Validate Require Full Name    invalid
    Validate Email Address    invalid
    Validate Correct Format Days for Availability    valid
    Validate Require Days for Availability    required

Verify Error Message for Email and Days Require
    Enter Full Name    ${validFullName}
    Enter Email Address    ${invalidEmail}
    SeleniumLibrary.Press Keys    //input[@name='daysAvail']    CTRL+a+BACKSPACE
    Click Save Button
    Validate Require Full Name    valid
    Validate Email Address    invalid
    Validate Correct Format Days for Availability    valid
    Validate Require Days for Availability    required

Verify Error Message for Full Name and Days Require
    SeleniumLibrary.Press Keys    //input[@name='fullName']    CTRL+a+BACKSPACE
    SeleniumLibrary.Press Keys    //input[@name='email']    CTRL+a+BACKSPACE
    SeleniumLibrary.Press Keys    //input[@name='daysAvail']    CTRL+a+BACKSPACE
    Click Save Button
    Validate Require Full Name    invalid
    Validate Email Address    valid
    Validate Correct Format Days for Availability    valid
    Validate Require Days for Availability    required

Verify No Error Message is Displayed
    Enter Full Name    ${validFullName}
    Enter Email Address    ${validEmail}
    Enter Days for Availability    ${validDaysForAvailability}
    Click Save Button
    Validate Require Full Name    valid
    Validate Email Address    valid
    Validate Correct Format Days for Availability    valid
    Validate Require Days for Availability    not required

Close Chrome Browser
    SeleniumLibrary.Close Browser
