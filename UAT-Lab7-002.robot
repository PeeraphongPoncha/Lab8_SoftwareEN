*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver.exe   
${Form}    http://${SERVER}/Form.html
${VALID_EMAIL}    test@mail.com
${VALID_PHONE}    123-456-7890

*** Test Cases ***
Validate Destination Field
    [Documentation]    ทดสอบการส่งฟอร์มด้วยการไม่ใส่ destination
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Clear Element Text    id=destination    
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email          somsong@kkumail.com
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Sleep              2s
    ${error_message}=  Get Text          id=errors
    Should Be Equal As Strings    ${error_message}    Please enter your destination.
    Close Browser

*** Test Cases ***
Validate Empty Email Field
    [Documentation]    ทดสอบการส่งฟอร์มด้วยการไม่ใส่ email
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Clear Element Text         id=email          
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Sleep              2s
    Element Text Should Be    id=errors    *Please enter an email!!
    Close Browser

*** Test Cases ***
Validate Invalid Email Field
    [Documentation]    ทดสอบการส่งฟอร์มด้วยการใส่ email ไม่ถูกต้อง
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email          somsong@
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Sleep              2s
    Element Text Should Be    id=errors    *Please enter a valid email!!
    Close Browser

*** Test Cases ***
Validate Empty Phone Field
    [Documentation]    ทดสอบการส่งฟอร์มด้วยการไม่ใส่ phone
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email    somsong@kkumail.com          
    Clear Element Text        id=phone          
    Click Button       id=submitButton
    Sleep              2s
    Element Text Should Be    id=errors    *Please enter a phone number!!
    Close Browser

*** Test Cases ***
Validate Invalid Phone Field
    [Documentation]    ทดสอบการส่งฟอร์มด้วยการใส่ phone ไม่ถูกต้อง
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email    somsong@kkumail.com          
    Input Text         id=phone    191         
    Click Button       id=submitButton
    Sleep              2s
    Element Text Should Be    id=errors    Please enter a valid phone number, e.g.,081-234-5678, 081 2345678, or081.234.5678)
    Close Browser