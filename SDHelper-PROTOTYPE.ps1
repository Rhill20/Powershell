add-Type -AssemblyName System.windows.forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "SD Helper"
$form.BackColor = [System.Drawing.Color]::Gray
$form.Width = 1000
$form.Height = 1000

$Picture = New-Object System.Windows.Forms.PictureBox
$Picture.Width = 900
$Picture.Height = 150
$Picture.Top = 750
$Picture.Left = 25
$Picture.ImageLocation = "Image Location"

$form.Controls.Add($Picture)

$clocklabel = New-Object System.Windows.Forms.Label
$clocklabel.Location = New-Object System.Drawing.Point(300,25)
$clocklabel.Autosize = $true
$clocklabel.Font = New-Object System.Drawing.Font("Times New Roman",40,[System.Drawing.Fontstyle]::Bold)
$Form.Controls.Add($clocklabel)

$notesBox = New-Object System.Windows.Forms.TextBox
$notesbox.Location = New-Object System.Drawing.Point (50, 125)
$notesBox.BackColor = [System.Drawing.Color]::DarkGray
$notesbox.Multiline = $true
$notesBox.Text = "Notes:"
$notesbox.Width = 900
$notesbox.Height = 350


$Notesave = New-object System.Windows.Forms.Button
$Notesave = New-Object System.Windows.Forms.Button
$Notesave.Height = 20
$Notesave.Width = 80
$Notesave.Location = New-Object System.Drawing.Point(425,490)
$Notesave.BackColor = [System.Drawing.Color]::SlateGray
$Notesave.DialogResult = [System.Windows.Forms.DialogResult]::None
$Notesave.Text = "save"
$Notesave.Add_click({
    $SFDIA = New-Object System.Windows.Forms.SaveFileDialog
    $SFDIA.Filter = "Text Files (*.txt)|*.txt|ALL files (*.*)|*.*"
    $SFDIA.Title = "Save"
    $SFDIA.ShowDialog()

    if ($SFDIA.FileName -ne "") {
        $notesBox.Text | Out-File -FilePath $SFDIA.FileName
    }
})


$form.Controls.Add($Notesave)
$form.AcceptButton = $Notesave

$form.Controls.Add($notesBox)

$exitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = New-Object System.Drawing.Point(800,25)
$exitButton.BackColor = [System.Drawing.Color]::SlateGray
$exitbutton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$exitButton.Text = "Exit"
$exitButton.Add_Click({ $form.Close() })

$Form.AcceptButton = $exitButton

$Form.Controls.Add($exitButton)


$LinksButton = New-Object System.Windows.Forms.Button
$LinksButton.Location = New-object System.Drawing.Point(100,550)
$LinksButton.Text = "LINKS"
$LinksButton.Height = 40
$LinksButton.Width = 100
$LinksButton.BackColor = [System.Drawing.Color]::SlateGray
$LinksButton.Add_Click({
    $LinksForm = New-Object System.Windows.Forms.Form
    $LinksForm.BackColor = [System.Drawing.Color]::Gray
    $LinksForm.Width = 1200
    $LinksForm.Height = 1000
    $LinksForm.Text = "Links"

    $LinksTextBox = New-Object System.Windows.Forms.TextBox
    $LinksTextBox.Location = New-Object System.Drawing.Point(100, 100)
    $LinksTextBox.BackColor = [System.Drawing.Color]::DarkGray
    $LinksTextBox.Multiline = $true
    $LinksTextBox.Width = 900
    $LinksTextBox.Height = 900
    $lINKSTextBox.ReadOnly = $true
    $LinksTextBox.Font = New-Object System.Drawing.Font("Times new Roman", 24)
    $LinksTextBox.ScrollBars = "vertical"
    $LinksForm.Controls.Add($LinksTextBox)

    $linksButtonOk = New-Object System.Windows.Forms.Button
    $linksButtonOk.Text = "Exit"
    $linksButtonOk.BackColor = [System.Drawing.Color]::SlateGray
    $LinksButtonOk.Location = New-Object System.Drawing.Point(25, 25)
    $LinksButtonOk.DialogResult = [System.Windows.Forms.DialogResult]::OK
    

    $LinksFilePath = "File Path "
    $LinksReader = [System.IO.StreamReader]::new($LINKSFilePath)
    $Linkstext = $LinksReader.ReadToEnd()
    $LINKSReader.Close()
    $Linkstext = Get-Content $LinksFilePath -Raw
    $LinksTextBox.Text = $Linkstext



    $LinksForm.Controls.Add($linksButtonOk)

    $LinksForm.AcceptButton = $linksButtonOk

    $LinksForm.ShowDialog() | Out-Null
})

$form.Controls.Add($LinksButton)

$CMDButton = New-Object System.Windows.Forms.Button
$CMDButton.Location = New-object System.Drawing.Point(225,550)
$CMDButton.Text = "Commands"
$CMDButton.Height = 40
$CMDButton.Width = 100
$CMDButton.BackColor = [System.Drawing.Color]::SlateGray
$CMDButton.Add_Click({
    $CMDForm = New-Object System.Windows.Forms.Form
    $CMDForm.BackColor = [System.Drawing.Color]::Gray
    $CMDForm.Width = 1200
    $CMDForm.Height = 1000
    $CMDForm.Text = "Commands"

    $CMDTextBox = New-Object System.Windows.Forms.TextBox
    $CMDTextBox.Location = New-Object System.Drawing.Point(100, 100)
    $CMDTextBox.BackColor = [System.Drawing.Color]::DarkGray
    $CMDTextBox.Multiline = $true
    $CMDTextBox.Width = 900
    $CMDTextBox.Height = 900
    $CMDTextBox.ReadOnly = $true
    $CMDTextBox.Font = New-Object System.Drawing.Font("Times new Roman", 12)
    $CMDTextBox.ScrollBars = "vertical"
    $CMDForm.Controls.Add($CMDTextBox)

    $CMDFilePath = "Filepath"
    $CMDReader = [System.IO.StreamReader]::new($CMDFilePath)
    $CMDtext = $CMDReader.ReadToEnd()
    $CMDReader.Close()
    $CMDtext = Get-Content $CMDFilePath -Raw
    $CMDTextBox.Text = $CMDtext


    $CMDButtonOk = New-Object System.Windows.Forms.Button
    $CMDButtonOk.Text = "Exit"
    $CMDButtonOk.BackColor = [System.Drawing.Color]::SlateGray
    $CMDButtonOk.Location = New-Object System.Drawing.Point(25, 25)
    $CMDButtonOk.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $CMDTextBox.Text = $CMDtext

    $CMDForm.Controls.Add($CMDButtonOk)

    $CMDForm.AcceptButton = $CMDButtonOk

    $CMDForm.ShowDialog() | Out-Null
})

$form.Controls.Add($CMDButton)

# SDD was meant to be something else. didnt work. Ask me if you care lol SDD = military alphabet 
$SDDButton = New-Object System.Windows.Forms.Button
$SDDButton.Location = New-object System.Drawing.Point(350,550)
$SDDButton.Text = "M Alphabet"
$SDDButton.Height = 40
$SDDButton.Width = 100
$SDDButton.BackColor = [System.Drawing.Color]::SlateGray
$SDDButton.Add_Click({
    $SDDForm = New-Object System.Windows.Forms.Form
    $SDDForm.BackColor = [System.Drawing.Color]::Gray
    $SDDForm.Width = 1200
    $SDDForm.Height = 1000
    $SDDForm.Text = "M Alphabet"

    $SDDTextBox = New-Object System.Windows.Forms.TextBox
    $SDDTextBox.Location = New-Object System.Drawing.Point(100, 100)
    $SDDTextBox.BackColor = [System.Drawing.Color]::DarkGray
    $SDDTextBox.Multiline = $true
    $SDDTextBox.Width = 900
    $SDDTextBox.Height = 900
    $SDDTextBox.ReadOnly = $true
    $SDDTextBox.ScrollBars = "vertical"
    $SDDTextBox.Font = New-Object System.Drawing.Font("Times new Roman", 24)
    $SDDForm.Controls.Add($SDDTextBox)

    $SDDButtonOk = New-Object System.Windows.Forms.Button
    $SDDButtonOk.Text = "Exit"
    $SDDButtonOk.BackColor = [System.Drawing.Color]::SlateGray
    $SDDButtonOk.Location = New-Object System.Drawing.Point(25, 25)
    $SDDButtonOk.DialogResult = [System.Windows.Forms.DialogResult]::OK
  
    $SDDFilePath = "File Path "
    $SDDReader = [System.IO.StreamReader]::new($SDDFilePath)
    $SDDtext = $SDDReader.ReadToEnd()
    $SDDReader.Close()
    $SDDtext = Get-Content $SDDFilePath -Raw
    $SDDTextBox.Text = $SDDtext

    $SDDForm.Controls.Add($SDDButtonOk)

    $SDDForm.AcceptButton = $SDDButtonOk

    $SDDForm.ShowDialog() | Out-Null
})

$form.Controls.Add($SDDButton)

$BomgarButton = New-Object System.Windows.Forms.Button
$BomgarButton.Location = New-Object System.Drawing.Point(600,550)
$BomgarButton.BackColor = [System.Drawing.Color]::SlateGray
$BomgarButton.Height = 20
$BomgarButton.Width = 100
$BomgarButton.Text = "Bomgar Open"
$BomgarButton.Add_Click({ 
    Start-process -FilePath "Filepath"
 })

$Form.AcceptButton = $BomgarButton

$Form.Controls.Add($BomgarButton)

$EndBomgarButton = New-Object System.Windows.Forms.Button
$EndBomgarButton.Location = New-Object System.Drawing.Point(600,570)
$EndBomgarButton.BackColor = [System.Drawing.Color]::SlateGray
$EndBomgarButton.Height = 20
$EndBomgarButton.Width = 100
$EndBomgarButton.Text = "Bomgar close"
$EndBomgarButton.Add_Click({ 
    $process = Get-Process -name "bomgar-rep"
    If ($process) {
        Stop-Process -ID $process.Id   
    }
})

$Form.AcceptButton = $EndBomgarButton

$Form.Controls.Add($EndBomgarButton)

$LTButton = New-Object System.Windows.Forms.Button
$LTButton.Location = New-Object System.Drawing.Point(725,550)
$LTButton.BackColor = [System.Drawing.Color]::SlateGray
$LTButton.Height = 20
$LTButton.Width = 100
$LTButton.Text = "Software Open"
$LTButton.Add_Click({ 
    Start-process -FilePath "Filepath "
 })

$Form.AcceptButton = $LTButton

$Form.Controls.Add($LTButton)

$EndLTButton = New-Object System.Windows.Forms.Button
$EndLTButton.Location = New-Object System.Drawing.Point(725,570)
$EndLTButton.BackColor = [System.Drawing.Color]::SlateGray
$EndLTButton.Height = 20
$EndLTButton.Width = 100
$EndLTButton.Text = "software close"
$EndLTButton.Add_Click({ 
    $process = Get-Process -name "software"
    If ($process) {
        Stop-Process -ID $process.Id   
    }
})

$Form.AcceptButton = $EndLTButton

$Form.Controls.Add($EndLTButton)



$AutoButton = New-Object System.Windows.Forms.Button
$AutoButton.Location = New-object System.Drawing.Point(475,550)
$AutoButton.Text = "MailResponses"
$AutoButton.Height = 40
$AutoButton.Width = 100
$AutoButton.BackColor = [System.Drawing.Color]::SlateGray
$AutoButton.Add_Click({
    $AutoForm = New-Object System.Windows.Forms.Form
    $AutoForm.BackColor = [System.Drawing.Color]::Gray
    $AutoForm.Width = 1200
    $AutoForm.Height = 1000
    $AutoForm.Text = "Mail Responses"

    $AutoTextBox = New-Object System.Windows.Forms.TextBox
    $AutoTextBox.Location = New-Object System.Drawing.Point(100, 100)
    $AutoTextBox.BackColor = [System.Drawing.Color]::DarkGray
    $AutoTextBox.Multiline = $true
    $AutoTextBox.Width = 900
    $AutoTextBox.Height = 900
    $AutoTextBox.ReadOnly = $true
    $AutoTextBox.ScrollBars = "vertical"
    $AutoTextBox.Font = New-Object System.Drawing.Font("Times new Roman", 12)
    $AutoForm.Controls.Add($AutoTextBox)

    $AutoFilePath = "Filepath"
    $AutoReader = [System.IO.StreamReader]::new($AutoFilePath)
    $Autotext = $AutoReader.ReadToEnd()
    $AutoReader.Close()
    $Autotext = Get-Content $AutoFilePath -Raw
    $AutoTextBox.Text = $Autotext


    $AutoButtonOk = New-Object System.Windows.Forms.Button
    $AutoButtonOk.Text = "Exit"
    $AutoButtonOk.BackColor = [System.Drawing.Color]::SlateGray
    $AutoButtonOk.Location = New-Object System.Drawing.Point(25, 25)
    $AutoButtonOk.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $AutoTextBox.Text = $Autotext
    

    $AutoForm.Controls.Add($AutoButtonOk)

    $AutoForm.AcceptButton = $AutoButtonOk

    $AutoForm.ShowDialog() | Out-Null
})

$form.Controls.Add($AutoButton)

$timer = New-object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.add_Tick({
    $currentTime = [datetime]::Now. ToString("hh:mm:ss tt")
    $clocklabel.Text = $currentTime
})
$timer.Start()

$form.ShowDialog() | Out-Null