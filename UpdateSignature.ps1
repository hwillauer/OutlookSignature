
function Update-Signature {
 
    #Set top company Logo & Dimensions
    $logoTopUrl = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
    $logoTopHeight = 10
    $logoTopWidth = 203
    #Set Hyperlink for Logo, leave empty if not needed.
    #$logoTopHyperlink = "https://www.google.com"

    #Set bottom Dimensions
    $logoBottomHeight = 58
    $logoBottomWidth = 424

    #Turn on Holiday Message
    #$holidayMessage = "In observance of the Holiday on May 25, 2020 (Monday), our office will be closed. We will resume normal business hours on May 26, 2020 (Tuesday)."
    #$holidayMessage = "In observance of Independence Day on July 4, 2020 (Saturday), our office will be closed on July 2, 2020 (Thursday) & July 3, 2020 (Friday). We will resume normal business hours on July 6, 2020 (Monday)."
    #$holidayMessage = "In observance of Labor Day on September 7, 2020 (Monday), our office will be closed. We will resume normal business hours on September 8, 2020 (Tuesday)."
    #$holidayMessage = "In observance of Thanksgiving on November 26, 2020 (Thursday), our office will be closed on November 26, 2020 (Thursday) & November 27, 2020 (Friday). We will resume normal business hours on November 30, 2020 (Monday)."
    #$holidayMessage = "In observance of the Holiday on December 25, 2020 (Friday), our office will be closed on December 24, 2020 (Thursday) & December 25, 2020 (Friday). We will resume normal business hours on December 28, 2020 (Monday). Additionally, we will be closed on on January 01, 2021 (Friday) for New Year's Day."
    $holidayMessage = "In observance of Presidents' Day on February 15, 2021 (Monday), our office will be closed. We will resume normal business hours on February 15, 2021 (Tuesday)."
    $holidayFontSize = "10.0pt"
    $holidayFontFamily = "Arial"
    $holidayFontColor = "#FF0000"
    #Holiday message for Specific departments (must match AD) or type "" for ALL
    #$holidayDepartments = ""
    $holidayDepartments = "Customer Service","Technical Support","Curtis Care","Accounting","Credit and Collections"

    #Set an optional Banner & Dimensions, leave empty if not needed.
    #$bannerUrl = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
    #$bannerHeight = 272
    #$bannerWidth = 92
    #Set Hyperlink for Banner, leave empty if not needed.
    #$bannerHyperlink = "https://www.google.com"

    #Lock Signature? $true/$false
    $lockSignature = $true

 
    #Get username
    $strName =  $env:username

    #Looking up AD attributes and setting variables for later use.
    $strFilter = "(&(objectCategory=User)(samAccountName=$strName))"

    $objSearcher = New-Object System.DirectoryServices.DirectorySearcher
    $objSearcher.Filter = $strFilter

    $objPath = $objSearcher.FindOne()
    $objUser = $objPath.GetDirectoryEntry()

    #AD attributes
    $strName = $objUser.displayName
    $strTitle = $objUser.title
    $strTeam = $objUser.department
    $strDepartment = "Professional Blah Blah" #$objUser.department
    $strCompany = $objUser.company
    $strCred = $objUser.info
    $strStreet = $objUser.streetAddress
    $strPhone = $objUser.telephoneNumber
    $strCity =  $objUser.l
    $strState =  $objUser.st
    $strPostCode = $objUser.postalCode
    $strCountry = $objUser.co
    $strEmail = $objUser.mail
    $strEmail = $strEmail.ToLower()
    $strWebsite = $objUser.wWWHomePage
    $strddi = $objUser.otherTelephone
    $strmobile = $objUser.mobile
    $strFax = $objUser.facsimileTelephoneNumber
    $strHome = $objUser.homePhone
    

    $memberOf = ([ADSISEARCHER]"samaccountname=$($env:USERNAME)").Findone().Properties.memberof -replace '^CN=([^,]+).+$','$1'

    If($memberOf -MATCH ("Outlook Signature WMF*|Outlook Signature Schaerer*|Outlook Signature Wilbur Curtis*")){
    }else{
    Write-Output 'The user is not in a proper group, do nothing & exit'
    Exit
    }
   
    #www.test.com | www.test2.com | www.google.com
    If($memberOf -match "Outlook Signature WMF - Schaerer - Wilbur Curtis O"){
    $logoBottomUrl = "https://www.google.com/logo3.png"
    $urls = ' | www.test.com | www.test2.com | www.google.com'
    $urlshttp = ' | <a href="http://www.test.com">www.test.com</a> | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $false
    $includeFax = $false
    #$strCompany = "XXX"
    }
    If($memberOf -match "Outlook Signature All 3 Logos O-F"){
    $logoBottomUrl = "https://www.google.com/logo3.png"
    $urls = ' | www.test.com | www.test2.com | www.google.com'
    $urlshttp = ' | <a href="http://www.test.com">www.test.com</a> | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $false
    $includeFax = $true
    #$strCompany = "XXX"
    }
    If($memberOf -match "Outlook Signature All 3 Logos O-M"){
    $logoBottomUrl = "https://www.google.com/logo3.png"
    $urls = ' | www.test.com | www.test2.com | www.google.com'
    $urlshttp = ' | <a href="http://www.test.com">www.test.com</a> | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $true
    $includeFax = $false
    #$strCompany = "XXX"
    }
    If($memberOf -match "Outlook Signature All 3 Logos O-M-F"){
    $logoBottomUrl = "https://www.google.com/logo3.png"
    $urls = ' | www.test.com | www.test2.com | www.google.com'
    $urlshttp = ' | <a href="http://www.test.com">www.test.com</a> | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $true
    $includeFax = $true
    #$strCompany = "XXX"
    }
    #www.test2.com | www.google.com
    If($memberOf -match "Outlook Signature 2 Logos O"){
    $logoBottomUrl = "https://www.google.com/logo2.png"
    $urls = ' | www.test2.com | www.google.com'
    $urlshttp  = ' | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $false
    $includeFax = $false
    #$strCompany = "XXX"
    }
    If($memberOf -match "Outlook Signature 2 Logos O-F"){
    $logoBottomUrl = "https://www.google.com/logo2.png"
    $urls = ' | www.test2.com | www.google.com'
    $urlshttp  = ' | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $false
    $includeFax = $true
    #$strCompany = "XXX"
    }
    If($memberOf -match "Outlook Signature 2 Logos O-M"){
    $logoBottomUrl = "https://www.google.com/logo2.png"
    $urls = ' | www.test2.com | www.google.com'
    $urlshttp  = ' | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $true
    $includeFax = $false
    #$strCompany = "XXX"
    }
    If($memberOf -match "Outlook Signature 2 Logos O-M-F"){
    $logoBottomUrl = "https://www.google.com/logo2.png"
    $urls = ' | www.test2.com | www.google.com'
    $urlshttp  = ' | <a href="http://www.test2.com">www.test2.com</a> | <a href="https://www.google.com">www.google.com</a>'
    $includeMobile = $true
    $includeFax = $true
    #$strCompany = "XXX"
    }
    #www.google.com
    If($memberOf -match "Outlook Signature 1 Logo O"){
    $urls  = ' | www.google.com'
    $urlshttp = ' | <a href="https://www.google.com">www.google.com</a>'
    $logoBottomUrl = "https://www.google.com/logo.png"
    $includeMobile = $false
    $includeFax = $false
    }
    If($memberOf -match "Outlook Signature 1 Logo O-F"){
    $urls  = ' | www.google.com'
    $urlshttp = ' | <a href="https://www.google.com">www.google.com</a>'
    $logoBottomUrl = "https://www.google.com/logo.png"
    $includeMobile = $false
    $includeFax = $true
    }
    If($memberOf -match "Outlook Signature 1 Logo O-M"){
    $urls  = ' | www.google.com'
    $urlshttp = ' | <a href="https://www.google.com">www.google.com</a>'
    $logoBottomUrl = "https://www.google.com/logo.png"
    $includeMobile = $true
    $includeFax = $false
    }
    If($memberOf -match "Outlook Signature 1 Logo O-M-F"){
    $urls  = ' | www.google.com'
    $urlshttp = ' | <a href="https://www.google.com">www.google.com</a>'
    $logoBottomUrl = "https://www.google.com/logo.png"
    $includeMobile = $true
    $includeFax = $true
    }
    
    #Holiday Message Specific Departments Only
    if ($holidayDepartments -ne "" -and $holidayDepartments -notcontains $strTeam)
    {
      $holidayMessage = ""
    } 
    
    #If $holidayMessage is $null exclude
    if ($holidayMessage -ne $null){
      $includeHolidayMessage = @"
    <br>
    <br>
    <span style='font-size: $holidayFontSize;font-family:"$holidayFontFamily";color:$holidayFontColor'>
    <b>$holidayMessage</b>
    </span>
"@    
    }
  #-----AD Group Dependent E-Mail Customizations-----START
    
    #If user in the "800 Number" AD group, use Home Number instead of Telephone Number
    If($memberOf -match "800 Number"){
    $objuser.telephoneNumber  = $strHome
    }
    #If user in the "CSR Assistance Email" AD group, use csrassistance@google.com email address instead of their own email address
    If($memberOf -match "CSR Assistance Email"){
    $strEmail = "csrassistance@google.com"
    }
    #If user in the "Tech Service Email" AD group, use techservice@google.com email address instead of their own email address
    If($memberOf -match "Tech Service Email"){
    $strEmail = "techservice@google.com"
    }
    #If user in the "Dispatch Email" AD group, use dispatch@google.com email address instead of their own email address
    If($memberOf -match "Dispatch Email"){
    $strEmail = "dispatch@google.com"
    }
    
    #-----AD Group Dependent E-Mail Customizations-----END

            #Format Office Number correctly if found, else exclude from Signature
        if($objuser.telephoneNumber.length -gt 10){
            $strPhone2 = $objuser.telephoneNumber.Substring(3)
            $strPhone3 = $strPhone2.Insert(7,'-')
            $strPhone4 = $strPhone3.Insert(0,'(')
            $strPhone5 = $strPhone4.Insert(5,') ')
            $strPhone6 = $strPhone5.Remove(4,1)
            $strPhone7 = "phone: +1 " + $strPhone6
            }
            #Format Fax Number correctly if found, else exclude from Signature
        if($objUser.facsimileTelephoneNumber.length -gt 10){
            $strFax2 = $objuser.facsimileTelephoneNumber.Substring(3)
            $strFax3 = $strFax2.Insert(7,'-')
            $strFax4 = $strFax3.Insert(0,'(')
            $strFax5 = $strFax4.Insert(5,') ')
            $strFax6 = $strFax5.Remove(4,1)
            $strFax7 = "fax: +1 " + $strFax6
            }
            #Format Mobile Number correctly if found, else exclude from Signature
        if($objUser.mobile.length -gt 10){
            $strMobile2 = $objuser.mobile.Substring(3)
            $strMobile3 = $strMobile2.Insert(7,'-')
            $strMobile4 = $strMobile3.Insert(0,'(')
            $strMobile5 = $strMobile4.Insert(5,') ')
            $strMobile6 = $strMobile5.Remove(4,1)
            $strMobile7 = "mobile: +1 " + $strMobile6
            }
            #Format Home/Toll free Number correctly if found, else exclude from Signature
        if($objUser.homePhone.length -gt 10){
            $strHome2 = $objuser.homePhone.Substring(3)
            $strHome3 = $strHome2.Insert(7,'-')
            $strHome4 = $strHome3.Insert(0,'(')
            $strHome5 = $strHome4.Insert(5,') ')
            $strHome6 = $strHome5.Remove(4,1)
            $strHome7 = "toll free: +1 " + $strHome6
            }

             #Exclude Mobile if Set to Yes
        if(($includeMobile -eq $false)){
            $strMobile6 = $null
            $strMobile7 = $null
            }

        if($includeFax -eq $false){
            $strFax6 = $null
            $strFax7 = $null
            }
        
    #Exclude upright slash after office number if no office number
    if (($strPhone6 -ne $null -and $strMobile6 -ne $null) -or ($strPhone6 -ne $null -and $strFax6 -ne $null)){
    $uprightSlash1 = @"
    | 
"@
    }
    #Exclude upright slash after mobile number if no mobile number or fax number
    if ($strMobile6 -ne $null -and $strFax6 -ne $null){
    $uprightSlash2 = @"
    | 
"@
    }
    #If $logoTopHyperlink is Emtpy, exclude from Signature
    if ($logoTopHyperlink -ne $null){
    $lTopHyperlink = @"
    <a href="$logoTopHyperlink">
"@
    }
    #If $logoBottomHyperlink is Emtpy, exclude from Signature
    if ($logoBottomHyperlink -ne $null){
    $lBottomHyperlink = @"
    <a href="$logoBottomHyperlink">
"@
    }
    #If $bannerHyperlink is Emtpy, exclude from Signature
    if ($bannerHyperlink -ne $null){
    $bHyperlink = @"
    <a href="$bannerHyperlink">
"@
    }
    #If $bannerHyperlink is $null exclude unneeeded </a>
    if ($bannerHyperlink -ne $null){
    $a2 = @"
    </a>
"@    
    }
    #If $bannerUrl is Empty, exclude from Signature
    if ($bannerUrl -ne $null){
    $banner = @"
    <br>
    $($bHyperlink)<img border=0 width=$bannerHeight height=$bannerWidth src="$bannerUrl">$($a2)
"@
    }
    $phones = @($strphone3, $strmobile3, $strfax3)
    #If no office, mobile, or fax number found exclude line break
    if ($phones -ne $null){
    $br = @"
    <br>
"@    
    }
    #If $logoHyperlink is $null exclude unneeeded </a>
    if ($logoHyperlink -ne $null){
    $a1 = @"
    </a>
"@    
    }

    #If $strCountry = "United States", change to USA
    if ($strCountry -eq "United States"){
    $strCountry = "USA"
    }


    
    #Location to export signaturehtml to.
    $UserDataPath = $Env:appdata
    $FolderLocation = $UserDataPath + '\\Microsoft\\Signatures'
    mkdir $FolderLocation -force
    #Create the signature and import the user's details im html format.
    $signaturehtml = @"
    <HTML>
    <HEAD>
    <BODY link="000000">
    $($lTopHyperlink)<img border=0 width=$logoTopWidth height=$logoTopHeight src="$logoTopUrl">
    <br>
    <br>
    <span style='font-size:10.0pt;font-family:"Arial";color:#000000'>
    <b>$strname</b>
    </span>
    <br>
    <br>
    <span style='font-size:8.0pt;font-family:"Arial";color:#000000'>
    <b>$strTitle</b>
    <br>
    <b>$strDepartment</b>
    <br>
    <br>
    $strCompany | $strStreet. | $strCity, $strState $strPostCode | $strCountry
    $($br)
    $strphone7$($uprightSlash1)$strmobile7$($uprightSlash2)$strfax7
    <br>
    <br>
    <a href=mailto:$strEmail>$strEmail</a>$($urlshttp)
    </span>
    <br>
    <br>
    $($lBottomHyperlink)<img border=0 width=$logoBottomWidth height=$logoBottomHeight src="$logoBottomUrl">$($a1)
    $($banner)
    <b>$($includeHolidayMessage)<b>
    <br />
    <br />
    <br />
    </body>
    </html>
"@
    $signaturtxt = @"
    $strname
    $strtitle
    $strDepartment
    $strCompany | $strStreet. | $strCity, $strState. $strPostCode | $strCountry
    $strphone7$($uprightSlash1)$strmobile7$($uprightSlash2)$strfax7
    $strEmail$($urls1)$($urls2)$($urls3)
    $($holidayMessage)
"@
    #Output the files to outlook signature location.
    #Output HTM file and trim extra spaces and or empty new lines
    $signaturehtml | Out-File "$FolderLocation\\$strName.htm"
    ((Get-Content "$FolderLocation\\$strName.htm") -replace ('\s{2,5}', ' ')).Trim() | Out-File -Encoding ascii "$FolderLocation\\$strName.htm"
    (Get-Content "$FolderLocation\\$strName.htm") | ? {$_.trim() -ne "" } | set-content "$FolderLocation\\$strName.htm"
    #Copy new HTM to RTF format
    Copy-Item "$FolderLocation\\$strName.htm" "$FolderLocation\\$strName.rtf"
    #Output TXT file and trim extra spaces and or empty new lines
    $signaturtxt | Out-File "$FolderLocation\\$strName.txt"
    ((Get-Content "$FolderLocation\\$strName.txt") -replace ('\s{2,5}', ' ')).Trim() | Out-File -Encoding ascii "$FolderLocation\\$strName.txt"
    (Get-Content "$FolderLocation\\$strName.txt") | ? {$_.trim() -ne "" } | set-content "$FolderLocation\\$strName.txt"
 
    #Lock user from making changes to signature if set to Yes
    if ($lockSignature -eq $true){
    New-ItemProperty HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name 'NewSignature' -Value "$strName" -PropertyType 'String' -Force  
    New-ItemProperty HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name 'ReplySignature' -Value "$strName" -PropertyType 'String' -Force
    }elseif ($lockSignature -eq $false){
    $valNewSignature = Get-ItemProperty -Path HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name "NewSignature" -ErrorAction SilentlyContinue
    if($valNewSignature -ne $null){
      Remove-ItemProperty HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name "NewSignature"
    }
    $valReplySignature = Get-ItemProperty -Path HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name "ReplySignature" -ErrorAction SilentlyContinue
    if($valReplySignature -ne $null){
      Remove-ItemProperty HKCU:'\Software\Microsoft\Office\16.0\Common\MailSettings' -Name "ReplySignature"
    }
    }
    
    #Find Outlook Default Profile and Set as Default Signature
    $RE = 'Identity Eid'
    $Key = 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles'
    Get-ChildItem $Key -Rec -EA SilentlyContinue | ForEach-Object {
    $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
    If ($CurrentKey -match $RE){
      $CurrentKey|Set-ItemProperty -name "New Signature" -value "$strName"
      $CurrentKey|Set-ItemProperty -name "Reply-Forward Signature" -value "$strName"
    }
    }
}

    

#Invoke the signature function.
Update-Signature
