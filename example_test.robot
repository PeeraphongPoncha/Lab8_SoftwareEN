*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Chrome
${URL}            https://example.com

*** Test Cases ***
Test Example Page
    [Documentation]    เปิดหน้า Example.com และตรวจสอบว่ามีข้อความ Example Domain
    Open Browser       ${URL}    ${BROWSER}
    Title Should Be    Example Domain
    Page Should Contain    Example Domain
    Close Browser

Test Search Google
    [Documentation]    ทดสอบการค้นหาบน Google
    Open Browser       https://www.google.com    ${BROWSER}
    Input Text         name:q    Robot Framework
    Press Keys         name:q    \\13
    Page Should Contain    Robot Framework
    Close Browser
