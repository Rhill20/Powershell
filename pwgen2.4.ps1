Add-Type -AssemblyName System.Windows.Forms
# Made by ryker hill, This is free to use Source code is owned by me
$phoneticAlphabet = @{
    'A' = 'Alpha'
    'B' = 'Bravo'
    'C' = 'Charlie'
    'D' = 'Delta'
    'E' = 'Echo'
    'F' = 'Foxtrot'
    'G' = 'Golf'
    'H' = 'Hotel'
    'I' = 'India'
    'J' = 'Juliet'
    'K' = 'Kilo'
    'L' = 'Lima'
    'M' = 'Mike'
    'N' = 'November'
    'O' = 'Oscar'
    'P' = 'Papa'
    'Q' = 'Quebec'
    'R' = 'Romeo'
    'S' = 'Sierra'
    'T' = 'Tango'
    'U' = 'Uniform'
    'V' = 'Victor'
    'W' = 'Whiskey'
    'X' = 'X-ray'
    'Y' = 'Yankee'
    'Z' = 'Zulu'
}




$form = New-Object System.Windows.Forms.Form
$form.Text = "Password Generator"
$form.BackColor = [System.Drawing.Color]::Gray
$form.Width = 700
$form.Height = 350
$form.FormBorderStyle = [System.windows.forms.FormBorderStyle]::FixedDialog

$wordPool = ( "Better", "Border", "Branch", "Couple", "Copper", "Costly", "Fishing", "Fabric", "Handle", "Hidden",
"Artist", "Attack", "Brother", "Broken", "Fisher", "Button", "Basket", "Battle", "Bigger",  
"Castle", "Charge", "Coffee", "Combat", "Danger", "Dinner", "Doctor", "Dollar", "Driver", "Lumber", "Energy", "Escape", "Expert", "Father", "Family",
"Forest", "Hazard", "Hornet", "Invest", "Jungle", "Kitten", "Letter", "Luxury", "Market", "Pallet", 
 "Mother", "Normal", "Office", "Outlaw", "Parent", "Planet", "Police", "Remote", "Safety", "Salary", "Social", "Spring", "Glasses",
"Stolen", "Sudden", "System", "Talent", "Treaty", "Verify", "Volume", "Wealth", "Winter", "Zebra", "Dragon", "Pillow", "Rocket", "Shadow", "Window", "Market",
"Person", "Church", "Street", "Nature", "Friend", "Future", "Summer", "Season", "Garden", "Career", "Speech", "Credit", "Target", "Middle", "Finish", "Actor",
"Bench", "Agent", "Adult", "Sport", "Basic", "Boost", "Clean", "Build", "Delay", "Draft", "Dozen", "Happy", "Heavy", "Glass", "First", "Human", "Grade", "Grass",
"Metal", "Local", "Lucky", "Money", "Lunch", "Month", "Magic", "Order", "Paper", "Power", "Price", "Prime", "Royal", "Sharp", "Table", "Staff", "Tower", "Track",
"Start", "State", "Trend", "Smart", "Thick", "Trust", "Solid", "Space", "World", "Urban", "Drive") 

#generate by pulling words and numbers

$bgen = New-Object System.Windows.Forms.Button
$bgen.Location = New-Object System.Drawing.Point(230,225)
$bgen.Size = New-Object System.Drawing.Size(75,25)
$bgen.BackColor = [System.Drawing.Color]::SlateGray
$bgen.Text = "Generate"
$bgen.Add_Click({
    $generatedPasswordsHistory = @()

    $randomWords = ($wordPool | Get-Random -Count 2) -join ""

    # Cryptographically secure random number
    $secureRandom = New-Object byte[] 4
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($secureRandom)
    $randomNumber = [BitConverter]::ToUInt32($secureRandom, 0) % 9000 + 1000

    $specialCharacters = '!@#$%&?'
    $randomSpecialChar = $specialCharacters[(Get-Random -Maximum $specialCharacters.Length)]
    
    $password = $randomWords + $randomNumber.ToString() + $randomSpecialChar

    # Check if the password is unique
    while ($generatedPasswordsHistory -contains $password) {
        # Regenerate if the password is not unique
        $randomWords = ($wordPool | Get-Random -Count 2) -join ""
        $randomNumber = [BitConverter]::ToUInt32($secureRandom, 0) % 9000 + 1000
        $randomSpecialChar = $specialCharacters[(Get-Random -Maximum $specialCharacters.Length)]
        $password = $randomWords + $randomNumber.ToString() + $randomSpecialChar
    }

    # Add the generated password to the history
    $generatedPasswordsHistory += $password

    # Set the generated password to the textbox
    $textBox.Text = $password
})
$form.Controls.add($bgen)
$form.Controls.Add($txtpassword)


$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Width = 400
$textBox.Height = 200
$textBox.Text = $password
$textBox.BackColor = ([System.Drawing.Color]::DarkGray)
$textBox.Location = New-Object System.Drawing.Point(142.5, 175)
$form.Controls.Add($textBox)

#conversion button 
$button = New-Object System.Windows.Forms.Button
$button.Text = 'Phonetic'
$button.Width = 80
$button.BackColor = [System.Drawing.Color]::SlateGray
$button.Location = New-Object System.Drawing.Point(380, 225)
$button.Add_Click({
    $inputText = $textBox.Text.ToUpper()
    $convertedLetters = foreach ($char in $inputText -split '') {
        if ($char -match '\w') {
            if ($phoneticAlphabet.ContainsKey($char)) {
                $phoneticAlphabet[$char]
            } else {
                $char
            }
        } else {
            $char
        }
    }

    $convertedText = $convertedLetters -join ' '

    # new windows for phonetic
    $resultForm = New-Object System.Windows.Forms.Form
    $resultForm.Text = 'Phonetic'
    $resultForm.Width = 625
    $resultForm.Height = 100
    $resultForm.BackColor = [System.Drawing.Color]::Gray

    # label for text
    $resultLabel = New-Object System.Windows.Forms.Label
    $resultLabel.Text = $convertedText
    $resultLabel.BackColor = [System.Drawing.Color]::Gray
    $resultLabel.AutoSize = $true
    $resultLabel.Location = New-Object System.Drawing.Point(20, 20)
    $resultForm.Controls.Add($resultLabel)

   
    $resultForm.ShowDialog() | Out-Null
})
$form.Controls.Add($button)



$copyButton = New-Object System.Windows.Forms.Button
$copyButton.Text = "Copy"
$copyButton.Size = New-Object System.Drawing.Size(75,25)
$copyButton.Size = New-Object System.Drawing.Size(75, 25)
$copyButton.Location = New-Object System.Drawing.Point(530, 225)
$copyButton.BackColor = [System.Drawing.Color]::SlateGray




$copyButton.Add_Click({
    $text = $textBox.Text
    [System.Windows.Forms.Clipboard]::SetText($text)
})
$form.Controls.Add($copyButton)

function OpenEncryptedEmail {
    $outlookType = [System.Type]::GetTypeFromProgID("Outlook.Application")
    $outlook = [System.Activator]::CreateInstance($outlookType)
    
    $mailItem = $outlook.CreateItem(0)
    $mailItem.Subject = "Temporary Password"
    $mailItem.Body = "Here is your Temporary Password, " + $textBox.Text 
    $mailItem.sensitivity = 2

    $result = [System.Windows.Forms.MessageBox]::Show("Warning::Encrypt The Email!!", "Do Not Send Unencrypted::Go to Options/Encrypt/Encrypt-Only ", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($result -eq "OK") {
        $mailItem.Display()
    }
}


$ENbutton = New-Object System.Windows.Forms.Button
$ENbutton.Location = New-Object System.Drawing.Point(80, 225)
$ENbutton.Size = New-Object System.Drawing.Size(75, 25)
$ENbutton.Text = "Open Email"
$ENbutton.BackColor = [System.Drawing.Color]::SlateGray
$ENbutton.Add_Click({ OpenEncryptedEmail })

# Add the button to the form
$form.Controls.Add($ENbutton)


$Banner = New-Object System.Windows.Forms.Label
$Banner.Text = "Password Generator"
$Banner.font = New-Object system.Drawing.font("Century schoolbook", 40, [System.Drawing.Fontstyle]::Bold)
$Banner.AutoSize = $true
$Banner.Location = New-Object System.Drawing.Point(50, 20)
$Banner.ForeColor = "black"

$form.Controls.Add($banner)

$CMDButton = New-Object System.Windows.Forms.Button
$CMDButton.Location = New-object System.Drawing.Point(660,130)
$CMDButton.Text = "INFO"
$CMDButton.Height = 60
$CMDButton.Width = 20
$CMDButton.BackColor = [System.Drawing.Color]::SlateGray
$CMDButton.Add_Click({
    $CMDForm = New-Object System.Windows.Forms.Form
    $CMDForm.BackColor = [System.Drawing.Color]::Gray
    $CMDForm.Width = 500
    $CMDForm.Height = 200
    $CMDForm.Text = "Creator Info"

    $CMDTextBox = New-Object System.Windows.Forms.TextBox
    $CMDTextBox.Location = New-Object System.Drawing.Point(5, 5)
    $CMDTextBox.BackColor = [System.Drawing.Color]::DarkGray
    $CMDTextBox.Multiline = $true
    $CMDTextBox.Width = 500
    $CMDTextBox.Height = 500
    $CMDTextBox.ReadOnly = $true
    $CMDTextBox.Font = New-Object System.Drawing.Font("Times new Roman", 18)
    $CMDTextBox.ScrollBars = "vertical"
    $CMDForm.Controls.Add($CMDTextBox)

    $CMDTextBox.Text = "Made By Ryker Hill
Questions or suggestions? Ping me on teams!"

    $CMDForm.Controls.Add($CMDButton)
    $CMDForm.AcceptButton = $CMDButton
    [void]$cmdform.ShowDialog()

})
$form.AcceptButton = $CMDButton
$form.Controls.Add($CMDButton)

#modifying to add KB for verification 
$verifyButton = New-Object System.Windows.Forms.Button
$verifyButton.Location = New-object System.Drawing.Point(193,275)
$verifyButton.Text = "4 Point Verification Required. Click to view procedure."
$verifyButton.Height = 25
$verifyButton.Width = 300
$verifyButton.BackColor = [System.Drawing.Color]::SlateGray
$verifyButton.Add_Click({
    $verifyForm = New-Object System.Windows.Forms.Form
    $verifyForm.BackColor = [System.Drawing.Color]::Gray
    $verifyForm.Width = 600
    $verifyForm.Height = 800
    $verifyForm.Text = "4 Point Verification"

    $verifyTextBox = New-Object System.Windows.Forms.TextBox
    $verifyTextBox.Location = New-Object System.Drawing.Point(5, 5)
    $verifyTextBox.BackColor = [System.Drawing.Color]::DarkGray
    $verifyTextBox.Multiline = $true
    $verifyTextBox.Width = 590
    $verifyTextBox.Height = 780
    $verifyTextBox.ReadOnly = $true
    $verifyTextBox.Font = New-Object System.Drawing.Font("Times new Roman", 18)
    $verifyTextBox.ScrollBars = "vertical"
    $verifyForm.Controls.Add($verifyTextBox)

    $verifyTextBox.Text = "KB0010324 - Password and MFA Verification and Workflow
Please view KB for the full article.

How to Verify Caller / Team Member Identity:

Note: Never provide the below information to a team member, nor give them hints. Rather, they must provide each verification point to the IT agent. 

Note: If the Team Member cannot complete all identity verification points, DO NOT proceed with password or MFA reset. Create an INC assigned to Cybersecurity and include the following detail:

Caller: Field member that could not complete verification

Short Description: Password Reset Denied
Category: Security
Priority: P4
Description:
Phone number used to call in: 
Time of call: 
Team member is able to verify: 
Team member is not able to verify: 
Any additional context for Cybersecurity: 
Was password and/or MFA reset: 

If Caller is a Contractor, perform 2-point identification:
Verify EID (if available)
If during business hours (8am to 5pm of the Managers time zone), call CTR manager for approval to reset password
If not during business hours, ask for CTR manager name only

If Caller is an Employee, perform 4-point verification:
Employee ID
Manager Name
Last 4 of SSN
Year of Birth"

    
    $verifyForm.AcceptButton = $verifyButton
    [void]$verifyForm.ShowDialog()

})
$form.AcceptButton = $verifyButton
$form.Controls.Add($verifyButton)


$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = New-Object System.Drawing.Point(305,125)
$exitButton.BackColor = [System.Drawing.Color]::SlateGray
$exitbutton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$exitButton.Text = "Exit"
$exitButton.Add_Click({ $form.Close() })

$Form.AcceptButton = $exitButton

$Form.Controls.Add($exitButton)


[void]$form.ShowDialog()
