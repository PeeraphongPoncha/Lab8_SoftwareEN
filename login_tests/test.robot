*** Settings ***
Documentation     Test cases for form validation in insurance application with specific Chrome binary and driver paths.
Library           SeleniumLibrary

*** Variables ***
${BASE_URL}               http://localhost:7272/Form.html
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver.exe
${SUCCESS_URL}            http://localhost:7272/Complete.html
${SUCCESS_TITLE}          Completed
${SUCCESS_MSG1}           Our agent will contact you shortly.
${SUCCESS_MSG2}           Thank you for your patient.
${ERROR_DEST}             Please enter your destination.
${ERROR_EMAIL}            Please enter a valid email address.
${ERROR_PHONE}            Please enter a phone number.
${ERROR_PHONE_FMT}        Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678.



*** Keywords ***
Open Browser With Custom Chrome
    [Arguments]    ${BASE_URL}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Set Variable    ${chrome_options.binary_location}    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${BASE_URL}

Verify Success Page
    Title Should Be    ${SUCCESS_TITLE}
    Page Should Contain    ${SUCCESS_MSG1}
    Page Should Contain    ${SUCCESS_MSG2}
    Location Should Be    http://localhost:7272/Complete.html


*** Test Cases ***
UAT-Lab7-001 Fill Complete Form
    [Documentation]   Verify that the form is submitted successfully when all fields are filled correctly.
    Open Browser With Custom Chrome    ${BASE_URL}
    Input Text      id:firstname    Somsong
    Input Text      id:lastname     Sandee
    Input Text      id:destination  Europe
    Input Text      id:contactperson     Sodsai Sandee
    Input Text      id:relationship     Mother
    Input Text      id:email        somsong@kkumail.com
    Input Text      id:phone        081-111-1234
    Click Button    id:submitButton
    Verify Success Page
    Close Browser

UAT-Lab7-002 Empty Destination
    [Documentation]   Verify that the error is shown when the destination is empty.
    Open Browser With Custom Chrome    ${BASE_URL}
    Input Text      id:firstname    Somsong
    Input Text      id:lastname     Sandee
    Input Text      id:contactperson     Sodsai Sandee
    Input Text      id:relationship     Mother
    Input Text      id:email        somsong@kkumail.com
    Input Text      id:phone        081-111-1234
    Click Button    id:submitButton
    Page Should Contain   ${ERROR_DEST}
    Close Browser


UAT-Lab7-003 Empty Email
    [Documentation]   Verify that the error is shown when the email is empty.
    Open Browser With Custom Chrome    ${BASE_URL}
    Input Text      id:firstname    Somsong
    Input Text      id:lastname     Sandee
    Input Text      id:destination  Europe
    Input Text      id:contactperson    Sodsai Sandee
    Input Text      id:relationship    Mother
    Input Text      id:phone        081-111-1234
    Click Button    id:submitButton
    Page Should Contain   ${ERROR_EMAIL}
    Close Browser



UAT-Lab7-004 Invalid Email
    [Documentation]   Verify that the error is shown when the email format is invalid.
    Open Browser With Custom Chrome    ${BASE_URL}
    Input Text      id:firstname    Somsong
    Input Text      id:lastname     Sandee
    Input Text      id:destination  Europe
    Input Text      id:contactperson    Sodsai Sandee
    Input Text      id:relationship    Mother
    Input Text      id:email        somsong@
    Input Text      id:phone        081-111-1234
    Click Button    id:submitButton
    Page Should Contain   ${ERROR_EMAIL}
    Close Browser

UAT-Lab7-005 Empty Phone Number
    [Documentation]   Verify that the error is shown when the phone number is empty.
    Open Browser With Custom Chrome    ${BASE_URL}
    Input Text      id:firstname    Somsong
    Input Text      id:lastname     Sandee
    Input Text      id:destination  Europe
    Input Text      id:contactperson     Sodsai Sandee
    Input Text      id:relationship     Mother
    Input Text      id:email        somsong@kkumail.com
    Click Button    id:submitButton
    Page Should Contain   ${ERROR_PHONE}
    Close Browser

UAT-Lab7-006 Invalid Phone Number
    [Documentation]   Verify that the error is shown when the phone number is invalid.
    Open Browser With Custom Chrome    ${BASE_URL}
    Input Text      id:firstname    Somsong
    Input Text      id:lastname     Sandee
    Input Text      id:destination  Europe
    Input Text      id:contactperson     Sodsai Sandee
    Input Text      id:relationship     Mother
    Input Text      id:email        somsong@kkumail.com
    Input Text      id:phone        191
    Click Button    id:submitButton
    Page Should Contain   ${ERROR_PHONE_FMT}
    Close Browser
