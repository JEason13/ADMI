# Author:       Jacob Eason 
# Date:         2/3/2023
# Class:        Cybersecurity 
# Teacher:      Mr. O
# Name:         Active Directory Management Interface (A.D.M.I.)
# File:         Main.ps1

#-------------------------------------------Program Start-------------------------------------------#

#add WinForms & sys.drawing to session 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing



#-------------------variables-------------------#
#user icons
$User0Icon = ".\res\logo\logo0.gif"

#security credentials 
$SecurityCred0 = "Apple-Horse-Mighty-Dingleberry"
$User0SecCred = "CyberSecurityW"

#-------------------functions-------------------#
#user window functions
function ADMI_User0 {
    $UserIcon = $User0Icon
    $CurrentUser = $env:computername 
    ADMI_AppWindow    
}
function ADMI_InvokeCommand {
    $CommandOuputText = Invoke-expression $UserCommand
    $CommandOuputText > $ADMIoutput
    return $CommandOuputText
}

function ADMI_UserWindowStaging {
    #instantiate a new form object
    $MainForm = New-Object system.Windows.Forms.Form
    $MainForm.Width = 275
    $MainForm.Height = 400
    $MainForm.text = "User Selection"
    #$MainForm.Location = New-Object System.Drawing.Point(100, 300)
    #user0
    #create new logo (PictureBox object)
    $logo =  New-Object System.Windows.Forms.PictureBox

    #logo properties
    $logo.BackColor = [System.Drawing.Color]::Transparent
    $logo.Location = New-Object System.Drawing.size(50,50)
    $logo.ImageLocation = $User0Icon
    $logo.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::CenterImage
    $logo.Size = New-Object System.Drawing.Size(150,150) 

    #add logo to screen
    $MainForm.Controls.Add($logo)

    #user name label
    $NameLabel = New-Object System.Windows.Forms.Label
    $NameLabel.ForeColor = 'yellow'
    $NameLabel.Location = New-Object System.Drawing.Point(100,20)
    $NameLabel.Size = New-Object System.Drawing.Size(280,140)
    $NameLabel.Text = "User Login"
    $MainForm.Controls.Add($NameLabel)
    
    $User0Button = New-Object System.Windows.Forms.Button
    $User0Button.Location = New-Object System.Drawing.Point(85,265)
    $User0Button.Size = New-Object System.Drawing.Size(75,23)
    $User0Button.ForeColor = 'yellow'
    $User0Button.Text = 'Sign In'
    $User0Button.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $MainForm.AcceptButton = $User0Button
    $MainForm.Controls.Add($User0Button)
    $MainForm.BackColor = 'darkblue'
    
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(50,240)
    $textBox.Size = New-Object System.Drawing.Size(150,20)
    $MainForm.Controls.Add($textBox)
    
    #$MainForm.Topmost = $true
    
    $MainForm.Add_Shown({$textBox.Select()})
    
    #center the window on the screen
    $MainForm.StartPosition = 'CenterScreen'
    
    #shows the screen 
    $result0 = $MainForm.ShowDialog()

    if ($result0 -eq [System.Windows.Forms.DialogResult]::OK)
    {     
        $User0SecCredCheck = $textBox.Text
        #ADMI_user0
        if ($User0SecCredCheck.Equals($User0SecCred)){
            ADMI_user0
        }
        
        if ($User0SecCredCheck -ne $User0SecCred){
            ADMI_ErrorSecurityCredentials
            ADMI_UserWindowStaging
        }

    }

    #set bg color

    #[void]$MainForm.ShowDialog()
    $MainForm.Dispose()
}

function ADMI_CloseWindow {
    $Window = $Function:ADMI_AppWindow.$MainForm.Close
    if ($Window -eq $false){
        return $true
    }
    else {
        return $false
    }
}

function ADMI_AppWindow {
    
    $ValidCommands = ("Get-PSDrive", "get-psdrive", "Get-psdrive", "Get-PSdrive", "Get-Command", "get-command", "Get-command", "Get-Language", "get-language", "Get-language")

    #instantiate a new form object
    $MainForm = New-Object system.Windows.Forms.Form
    $MainForm.Width = 1280
    $MainForm.Height = 740
    $MainForm.text = "User:`t" + $CurrentUser
    
    #create new logo (PictureBox object)
    $logo =  New-Object System.Windows.Forms.PictureBox

    #logo properties
    $logo.BackColor = [System.Drawing.Color]::Transparent
    $logo.Location = New-Object System.Drawing.size(50,50)
    $logo.ImageLocation = $UserIcon
    $logo.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::CenterImage
    $logo.Size = New-Object System.Drawing.Size(150,150) 

    #add logo to screen
    $MainForm.Controls.Add($logo)

    #create new text box, set its location and size 
    $TitleBox = New-Object System.Windows.Forms.RichTextBox 
    $TitleBox.Location = New-Object System.Drawing.Size(250,30) 
    $TitleBox.Size = New-Object System.Drawing.Size(620,200) 

    #text box properties
    $TitleBox.MultiLine = $true 
    $TitleBox.ScrollBars = "Vertical" 
    $TitleBox.ReadOnly=$true

    #add text box to main window
    $MainForm.Controls.Add($TitleBox) 

    #change text color and append text
    $TitleBox.SelectionColor = 'yellow'
    $TitleBox.text = $TitleBox.AppendText("Active Directory Management Interface --->  (A.D.M.I.)`n`n*`tAuthor:  Jacob Eason`n`n*`tDate:    2/3/2023`n`n*`tClass:   Cybersecurity`n`n*`tTeacher:  Mr. O`n`n") + $TitleBox.text
    $TitleBox.text = $TitleBox.AppendText("This project aims to create a PowerShell system or series of PowerShell systems that would allow for the easy management of a Microsoft Active Directory (AD) system.`nThe system would create a graphical user interface (GUI) based platform on which the user can manage a wide array of devices and issue commands to them.`nIn addition, the Active Directory Management Interface (A.D.M.I.) would assist the admin's ability to administrate their users and perform actions quickly.`n`n`nWhether it be user management or a cyber-attack, A.D.M.I. will increase its system's response time and ease of use.`n") + $TitleBox.text

    #set bg color
    $MainForm.BackColor = 'darkblue'
    $TitleBox.BackColor = 'darkblue'
    
    #center the window on the screen
    $MainForm.StartPosition = 'CenterScreen'

    #----------------------UI----------------------#
    $CommandTextBoxLabel = New-Object System.Windows.Forms.Label
    $CommandTextBoxLabel.ForeColor = 'yellow'
    $CommandTextBoxLabel.Location = New-Object System.Drawing.Point(897,35)
    $CommandTextBoxLabel.Size = New-Object System.Drawing.Size(325,20)
    $CommandTextBoxLabel.Text = 'Enter a valid PowerShell or Active Directory command below:'
    $MainForm.Controls.Add($CommandTextBoxLabel)
    
    $CommandTextBox = New-Object System.Windows.Forms.TextBox
    $CommandTextBox.Location = New-Object System.Drawing.Point(900,55)
    $CommandTextBox.Size = New-Object System.Drawing.Size(300,20)
    $MainForm.Controls.Add($CommandTextBox)    
    $MainForm.Add_Shown({$CommandTextBox.Select()})

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(900,80)
    $okButton.Size = New-Object System.Drawing.Size(125,25)
    $okButton.ForeColor = 'yellow'
    $okButton.Text = 'Run Command'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $MainForm.AcceptButton = $okButton
    $MainForm.Controls.Add($okButton)    

    #more buttons! yay!

    $aduserlabel = New-Object System.Windows.Forms.Label
    $aduserlabel.ForeColor = 'yellow'
    $aduserlabel.Location = New-Object System.Drawing.Point(897,135)
    $aduserlabel.Size = New-Object System.Drawing.Size(325,20)
    $aduserlabel.Text = 'Get-ADUser ---> Specify an AD user in the text box below:'
    $MainForm.Controls.Add($aduserlabel)
    
    $adusertextbox = New-Object System.Windows.Forms.TextBox
    $adusertextbox.Location = New-Object System.Drawing.Point(900,155)
    $adusertextbox.Size = New-Object System.Drawing.Size(300,20)
    $MainForm.Controls.Add($adusertextbox)    
    $MainForm.Add_Shown({$adusertextbox.Select()})

    $aduserbutton = New-Object System.Windows.Forms.Button
    $aduserbutton.Location = New-Object System.Drawing.Point(900,180)
    $aduserbutton.Size = New-Object System.Drawing.Size(125,25)
    $aduserbutton.ForeColor = 'yellow'
    $aduserbutton.Text = 'Run Command'
    $aduserbutton.DialogResult = [System.Windows.Forms.DialogResult]::Yes
    $MainForm.AcceptButton = $aduserbutton
    $MainForm.Controls.Add($aduserbutton)    
    
    #$CommandOuputText = ""
    #$CheckCommandBox = $MainForm.ShowDialog()

    #$CommandOutputLabel = New-Object System.Windows.Forms.Label
    #$CommandOutputLabel.ForeColor = 'yellow'
    #$CommandOutputLabel.Location = New-Object System.Drawing.Point(897,120)
    #$CommandOutputLabel.Size = New-Object System.Drawing.Size(325,20)
    #$CommandOutputLabel.Text = 'Command Output:'
    #$MainForm.Controls.Add($CommandOutputLabel)
    
    #$CommandOutput = New-Object System.Windows.Forms.TextBox
    #$CommandOutput.Location = New-Object System.Drawing.Point(900,150)
    #$CommandOutput.Size = New-Object System.Drawing.Size(325,200)
    #$MainForm.Controls.Add($CommandOutput)    

    #$CommandOutput.ReadOnly = $true
    #$CommandOutput.Text = $CommandOutput.AppendText($ADMIoutput)

    $CheckCommandBox = $MainForm.ShowDialog()
    $UserCommand = $CommandTextBox.Text
    if ($CheckCommandBox -eq [Windows.Forms.DialogResult]::OK){
        if ($ValidCommands.Contains($UserCommand)){
            ADMI_InvokeCommand #UN-COMMENT THIS LINE TO RUN COMMANDS VIA THE GUI   ~ JACOB
        }
        ADMI_AppWindow
        #$CommandOutput.Text = $CommandOutput.AppendText($ADMIoutput)

    }

    $GetADUserFromGUI = $adusertextbox.Text
    
    if ($CheckCommandBox -eq [System.Windows.Forms.DialogResult]::Yes){
        #needs to be tested on an Active Directory system 
        #[string]$GetTheADUser = $GetADUserFromGUI.ToString()
        Get-ADUser -Filter 'sAMAccountName -eq $GetADUserFromGUI' #https://stackoverflow.com/questions/20075502/get-aduser-filter-will-not-accept-a-variable
        ADMI_AppWindow
    }

    While (ADMI_CloseWindow -eq $true) {
        [void]$MainForm.ShowDialog()
    }

    $MainForm.Dispose()
}

function ADMI_ErrorSecurityCredentials {
    $ErrorWindowSecCred = New-Object system.Windows.Forms.Form
    $ErrorWindowSecCred.Width = 310
    $ErrorWindowSecCred.Height = 150
    $ErrorWindowSecCred.BackColor = 'darkblue'
    $ErrorWindowSecCred.StartPosition = 'CenterScreen'
    $ErrorWindowSecCred.text = "ADMI Security Login"

    $Errorlabel = New-Object System.Windows.Forms.Label
    $Errorlabel.ForeColor = 'yellow'
    $Errorlabel.Location = New-Object System.Drawing.Point(10,20)
    $Errorlabel.Size = New-Object System.Drawing.Size(280,140)
    $Errorlabel.Text = "--Incorrect Security Credentials--`nPlease Try again, or click `"Cancel`" to exit...`n`nExit this window to continue"
    $ErrorWindowSecCred.Controls.Add($Errorlabel)

    $ErrorWindowSecCred.ShowDialog()
    $ErrorWindowSecCred.Dispose()

}

function ADMI_MasterLogin {
    $MasterLoginForm = New-Object system.Windows.Forms.Form
    $MasterLoginForm.Width = 310
    $MasterLoginForm.Height = 200
    $MasterLoginForm.BackColor = 'darkblue'
    $MasterLoginForm.StartPosition = 'CenterScreen'
    $MasterLoginForm.text = "ADMI Security Login"
    
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(75,120)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.ForeColor = 'yellow'
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $MasterLoginForm.AcceptButton = $okButton
    $MasterLoginForm.Controls.Add($okButton)
    
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(150,120)
    $cancelButton.Size = New-Object System.Drawing.Size(75,23)
    $cancelButton.ForeColor = 'yellow'
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $MasterLoginForm.CancelButton = $cancelButton
    $MasterLoginForm.Controls.Add($cancelButton)
    
    $label = New-Object System.Windows.Forms.Label
    $label.ForeColor = 'yellow'
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Please enter the ADMI security credentials below:'
    $MasterLoginForm.Controls.Add($label)
    
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $MasterLoginForm.Controls.Add($textBox)
    
    $MasterLoginForm.Topmost = $true
    
    $MasterLoginForm.Add_Shown({$textBox.Select()})
    $result = $MasterLoginForm.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $UserSecCred = $textBox.Text
     
        if ($UserSecCred.Equals($SecurityCred0)){
            ADMI_UserWindowStaging
        }

        if ($UserSecCred -ne $SecurityCred0){
            ADMI_ErrorSecurityCredentials
            ADMI_MasterLogin
        }

    }

    if ($result -ne [System.Windows.Forms.DialogResult]::OK)
    {
        Exit-PSSession
    }
            
    $MasterLoginForm.Dispose()
}


#---------------------------------------Run Program---------------------------------------#

ADMI_MasterLogin
