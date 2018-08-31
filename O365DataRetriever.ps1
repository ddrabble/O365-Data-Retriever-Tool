﻿<#
O365 Data Retriever - Release 0.1.0 (Aug 22nd, 2018)
#>

#Load the Assemblies
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, system.windows.forms

#Refer to the XAML file
[string]$xamlContent = Get-Content $(Join-Path -Path $PSScriptRoot -ChildPath 'MainWindow.xaml' )
[xml]$xml = $xamlContent.Replace('{0}',$PSScriptRoot)
$xamlFile = $xml

#Read & Load the xaml file
$reader=(New-Object System.Xml.XmlNodeReader $xamlFile)
$Window = [Windows.Markup.XamlReader]::Load( $reader )


##################
# START SCRIPTING
##################

#region FUNCTION New-WPFMessageBox
Function New-WPFMessageBox {
    # Define Parameters
    [CmdletBinding()]
    Param
    (
        # The popup Content
        [Parameter(Mandatory = $True, Position = 0)]
        [Object]$Content,

        # The window title
        [Parameter(Mandatory = $false, Position = 1)]
        [string]$Title,

        # The buttons to add
        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateSet('OK', 'OK-Cancel', 'Abort-Retry-Ignore', 'Yes-No-Cancel', 'Yes-No', 'Retry-Cancel', 'Cancel-TryAgain-Continue', 'None')]
        [array]$ButtonType = 'OK',

        # The buttons to add
        [Parameter(Mandatory = $false, Position = 3)]
        [array]$CustomButtons,

        # Content font size
        [Parameter(Mandatory = $false, Position = 4)]
        [int]$ContentFontSize = 14,

        # Title font size
        [Parameter(Mandatory = $false, Position = 5)]
        [int]$TitleFontSize = 14,

        # BorderThickness
        [Parameter(Mandatory = $false, Position = 6)]
        [int]$BorderThickness = 0,

        # CornerRadius
        [Parameter(Mandatory = $false, Position = 7)]
        [int]$CornerRadius = 8,

        # ShadowDepth
        [Parameter(Mandatory = $false, Position = 8)]
        [int]$ShadowDepth = 3,

        # BlurRadius
        [Parameter(Mandatory = $false, Position = 9)]
        [int]$BlurRadius = 20,

        # WindowHost
        [Parameter(Mandatory = $false, Position = 10)]
        [object]$WindowHost,

        # Timeout in seconds,
        [Parameter(Mandatory = $false, Position = 11)]
        [int]$Timeout,

        # Code for Window Loaded event,
        [Parameter(Mandatory = $false, Position = 12)]
        [scriptblock]$OnLoaded,

        # Code for Window Closed event,
        [Parameter(Mandatory = $false, Position = 13)]
        [scriptblock]$OnClosed
    )
    # Dynamically Populated parameters
    DynamicParam {
        # Add assemblies for use in PS Console
        Add-Type -AssemblyName System.Drawing, PresentationCore

        # ContentBackground
        $ContentBackground = 'ContentBackground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ContentBackground = "White"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentBackground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ContentBackground, $RuntimeParameter)

        # FontFamily
        $FontFamily = 'FontFamily'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Drawing.FontFamily]::Families | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($FontFamily, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($FontFamily, $RuntimeParameter)
        $PSBoundParameters.FontFamily = "Segui"

        # TitleFontWeight
        $TitleFontWeight = 'TitleFontWeight'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Windows.FontWeights] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.TitleFontWeight = "Normal"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleFontWeight, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($TitleFontWeight, $RuntimeParameter)

        # ContentFontWeight
        $ContentFontWeight = 'ContentFontWeight'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Windows.FontWeights] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ContentFontWeight = "Normal"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentFontWeight, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ContentFontWeight, $RuntimeParameter)

        # ContentTextForeground
        $ContentTextForeground = 'ContentTextForeground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ContentTextForeground = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentTextForeground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ContentTextForeground, $RuntimeParameter)

        # TitleTextForeground
        $TitleTextForeground = 'TitleTextForeground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.TitleTextForeground = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleTextForeground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($TitleTextForeground, $RuntimeParameter)

        # BorderBrush
        $BorderBrush = 'BorderBrush'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.BorderBrush = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($BorderBrush, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($BorderBrush, $RuntimeParameter)

        # TitleBackground
        $TitleBackground = 'TitleBackground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.TitleBackground = "White"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleBackground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($TitleBackground, $RuntimeParameter)

        # ButtonTextForeground
        $ButtonTextForeground = 'ButtonTextForeground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ButtonTextForeground = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ButtonTextForeground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ButtonTextForeground, $RuntimeParameter)

        # Sound
        $Sound = 'Sound'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        #$ParameterAttribute.Position = 14
        $AttributeCollection.Add($ParameterAttribute)
        $arrSet = (Get-ChildItem "$env:SystemDrive\Windows\Media" -Filter Windows* | Select-Object -ExpandProperty Name).Replace('.wav', '')
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($Sound, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($Sound, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }
    Begin {
        Add-Type -AssemblyName PresentationFramework
    }
    Process {
        # Define the XAML markup
        [XML]$Xaml = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        x:Name="Window" Title="" SizeToContent="WidthAndHeight" WindowStartupLocation="CenterScreen" WindowStyle="None" ResizeMode="NoResize" AllowsTransparency="True" Background="Transparent" Opacity="1">
    <Window.Resources>
        <Style TargetType="{x:Type Button}">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border>
                            <Grid Background="{TemplateBinding Background}">
                                <ContentPresenter />
                            </Grid>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    <Border x:Name="MainBorder" Margin="10" CornerRadius="$CornerRadius" BorderThickness="$BorderThickness" BorderBrush="$($PSBoundParameters.BorderBrush)" Padding="0" >
        <Border.Effect>
            <DropShadowEffect x:Name="DSE" Color="Black" Direction="270" BlurRadius="$BlurRadius" ShadowDepth="$ShadowDepth" Opacity="0.6" />
        </Border.Effect>
        <Border.Triggers>
            <EventTrigger RoutedEvent="Window.Loaded">
                <BeginStoryboard>
                    <Storyboard>
                        <DoubleAnimation Storyboard.TargetName="DSE" Storyboard.TargetProperty="ShadowDepth" From="0" To="$ShadowDepth" Duration="0:0:1" AutoReverse="False" />
                        <DoubleAnimation Storyboard.TargetName="DSE" Storyboard.TargetProperty="BlurRadius" From="0" To="$BlurRadius" Duration="0:0:1" AutoReverse="False" />
                    </Storyboard>
                </BeginStoryboard>
            </EventTrigger>
        </Border.Triggers>
        <Grid >
            <Border Name="Mask" CornerRadius="$CornerRadius" Background="$($PSBoundParameters.ContentBackground)" />
            <Grid x:Name="Grid" Background="$($PSBoundParameters.ContentBackground)">
                <Grid.OpacityMask>
                    <VisualBrush Visual="{Binding ElementName=Mask}"/>
                </Grid.OpacityMask>
                <StackPanel Name="StackPanel" >
                    <TextBox Name="TitleBar" IsReadOnly="True" IsHitTestVisible="False" Text="$Title" Padding="10" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="$TitleFontSize" Foreground="$($PSBoundParameters.TitleTextForeground)" FontWeight="$($PSBoundParameters.TitleFontWeight)" Background="$($PSBoundParameters.TitleBackground)" HorizontalAlignment="Stretch" VerticalAlignment="Center" Width="Auto" HorizontalContentAlignment="Center" BorderThickness="0"/>
                    <DockPanel Name="ContentHost" Margin="0,10,0,10"  >
                    </DockPanel>
                    <DockPanel Name="ButtonHost" LastChildFill="False" HorizontalAlignment="Center" >
                    </DockPanel>
                </StackPanel>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

        [XML]$ButtonXaml = @"
<Button xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Width="Auto" Height="30" FontFamily="Segui" FontSize="16" Background="Transparent" Foreground="White" BorderThickness="1" Margin="10" Padding="20,0,20,0" HorizontalAlignment="Right" Cursor="Hand"/>
"@

        [XML]$ButtonTextXaml = @"
<TextBlock xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="16" Background="Transparent" Foreground="$($PSBoundParameters.ButtonTextForeground)" Padding="20,5,20,5" HorizontalAlignment="Center" VerticalAlignment="Center"/>
"@

        [XML]$ContentTextXaml = @"
<TextBlock xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Text="$Content" Foreground="$($PSBoundParameters.ContentTextForeground)" DockPanel.Dock="Right" HorizontalAlignment="Center" VerticalAlignment="Center" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="$ContentFontSize" FontWeight="$($PSBoundParameters.ContentFontWeight)" TextWrapping="Wrap" Height="Auto" MaxWidth="500" MinWidth="50" Padding="10"/>
"@

        # Load the window from XAML
        $Window = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $xaml))

        # Custom function to add a button
        Function Add-Button {
            Param($Content)
            $Button = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ButtonXaml))
            $ButtonText = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ButtonTextXaml))
            $ButtonText.Text = "$Content"
            $Button.Content = $ButtonText
            $Button.Add_MouseEnter( {
                    $This.Content.FontSize = "17"
                })
            $Button.Add_MouseLeave( {
                    $This.Content.FontSize = "16"
                })
            $Button.Add_Click( {
                    New-Variable -Name WPFMessageBoxOutput -Value $($This.Content.Text) -Option ReadOnly -Scope Script -Force
                    $Window.Close()
                })
            $Window.FindName('ButtonHost').AddChild($Button)
        }

        # Add buttons
        If ($ButtonType -eq "OK") {
            Add-Button -Content "OK"
        }

        If ($ButtonType -eq "OK-Cancel") {
            Add-Button -Content "OK"
            Add-Button -Content "Cancel"
        }

        If ($ButtonType -eq "Abort-Retry-Ignore") {
            Add-Button -Content "Abort"
            Add-Button -Content "Retry"
            Add-Button -Content "Ignore"
        }

        If ($ButtonType -eq "Yes-No-Cancel") {
            Add-Button -Content "Yes"
            Add-Button -Content "No"
            Add-Button -Content "Cancel"
        }

        If ($ButtonType -eq "Yes-No") {
            Add-Button -Content "Yes"
            Add-Button -Content "No"
        }

        If ($ButtonType -eq "Retry-Cancel") {
            Add-Button -Content "Retry"
            Add-Button -Content "Cancel"
        }

        If ($ButtonType -eq "Cancel-TryAgain-Continue") {
            Add-Button -Content "Cancel"
            Add-Button -Content "TryAgain"
            Add-Button -Content "Continue"
        }

        If ($ButtonType -eq "None" -and $CustomButtons) {
            Foreach ($CustomButton in $CustomButtons) {
                Add-Button -Content "$CustomButton"
            }
        }

        # Remove the title bar if no title is provided
        If ($Title -eq "") {
            $TitleBar = $Window.FindName('TitleBar')
            $Window.FindName('StackPanel').Children.Remove($TitleBar)
        }

        # Add the Content
        If ($Content -is [String]) {
            # Replace double quotes with single to avoid quote issues in strings
            If ($Content -match '"') {
                $Content = $Content.Replace('"', "'")
            }

            # Use a text box for a string value...
            $ContentTextBox = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ContentTextXaml))
            $Window.FindName('ContentHost').AddChild($ContentTextBox)
        }
        Else {
            # ...or add a WPF element as a child
            Try {
                $Window.FindName('ContentHost').AddChild($Content)
            }
            Catch {
                $_
            }
        }

        # Enable window to move when dragged
        $Window.FindName('Grid').Add_MouseLeftButtonDown( {
                $Window.DragMove()
            })

        # Activate the window on loading
        If ($OnLoaded) {
            $Window.Add_Loaded( {
                    $This.Activate()
                    Invoke-Command $OnLoaded
                })
        }
        Else {
            $Window.Add_Loaded( {
                    $This.Activate()
                })
        }

        # Stop the dispatcher timer if exists
        If ($OnClosed) {
            $Window.Add_Closed( {
                    If ($DispatcherTimer) {
                        $DispatcherTimer.Stop()
                    }
                    Invoke-Command $OnClosed
                })
        }
        Else {
            $Window.Add_Closed( {
                    If ($DispatcherTimer) {
                        $DispatcherTimer.Stop()
                    }
                })
        }
        # If a window host is provided assign it as the owner
        If ($WindowHost) {
            $Window.Owner = $WindowHost
            $Window.WindowStartupLocation = "CenterOwner"
        }

        # If a timeout value is provided, use a dispatcher timer to close the window when timeout is reached
        If ($Timeout) {
            $Stopwatch = New-object System.Diagnostics.Stopwatch
            $TimerCode = {
                If ($Stopwatch.Elapsed.TotalSeconds -ge $Timeout) {
                    $Stopwatch.Stop()
                    $Window.Close()
                }
            }
            $DispatcherTimer = New-Object -TypeName System.Windows.Threading.DispatcherTimer
            $DispatcherTimer.Interval = [TimeSpan]::FromSeconds(1)
            $DispatcherTimer.Add_Tick($TimerCode)
            $Stopwatch.Start()
            $DispatcherTimer.Start()
        }

        # Play a sound
        If ($($PSBoundParameters.Sound)) {
            $SoundFile = "$env:SystemDrive\Windows\Media\$($PSBoundParameters.Sound).wav"
            $SoundPlayer = New-Object System.Media.SoundPlayer -ArgumentList $SoundFile
            $SoundPlayer.Add_LoadCompleted( {
                    $This.Play()
                    $This.Dispose()
                })
            $SoundPlayer.LoadAsync()
        }

        # Display the window
        $null = $window.Dispatcher.InvokeAsync{$window.ShowDialog()}.Wait()

    }
}
 #endregion


#region CLICK CONNECT BUTTON
############################

#region Load all the controls
$AdminTextbox = $Window.findname('AdminTextBox')
$AdminPwdTextbox = $Window.findname('PasswordBox')
$ConnectButton = $Window.findname('ConnectButton')
$DisconnectButton = $Window.findname('DisconnectButton')
$TenantTextBlock = $Window.findname('TenantTextBlock')
$OrgNameTextBlock = $Window.findname('OrgNameTextBlock')
$CountryTextBlock = $Window.findname('CountryTextBlock')
$TechContactTextBlock = $Window.findname('TechContactTextBlock')
$ContactPhoneNbrTextBlock = $Window.findname('ContactPhoneNbrTextBlock')
$TotalNbrPlansTextBlock = $Window.findname('TotalNbrPlansTextBlock')
$TotalLicensesTextBlock = $Window.findname('TotalLicensesTextBlock')
$TotalAssignedLicensesTextBlock = $Window.findname('TotalAssignedLicensesTextBlock')
$DirSyncEnabledTextBlock = $Window.findname('DirSyncEnabledTextBlock')
$PwdSyncEnabledTextBlock = $Window.findname('PwdSyncEnabledTextBlock')
$LastDirSyncTimeTextBlock = $Window.findname('LastDirSyncTimeTextBlock')
$LastPwdSyncTimeTextBlock = $Window.findname('LastPwdSyncTimeTextBlock')
$FeaturesReleaseTextBlock = $Window.findname('FeaturesReleaseTextBlock')
#Tenant Tab
$NbrOfDomainsTextBlock = $Window.findname('NbrOfDomainsTextBlock')
$DomainsDataGrid = $Window.findname('DomainsDataGrid')
$ExportDomainsButton = $Window.findname('ExportDomainsButton')
$NbrOfPlansTextBlock = $Window.findname('NbrOfPlansTextBlock')
$PlansDataGrid = $Window.findname('PlansDataGrid')
$ExportPlansButton = $Window.findname('ExportPlansButton')
$NbrOfGATextBlock = $Window.findname('NbrOfGATextBlock')
$GADataGrid = $Window.findname('GADataGrid')
$ExportGAButton = $Window.findname('ExportGAButton')
$AtAGlanceTextBlock = $Window.findname('AtAGlanceTextBlock')
$NbrOfUsersTextBlock = $Window.findname('NbrOfUsersTextBlock')
$NbrOfSyncedUsersTextBlock = $Window.findname('NbrOfSyncedUsersTextBlock')
$NbrOfCloudUsersTextBlock = $Window.findname('NbrOfCloudUsersTextBlock')
$NbrOfBlockedUsersTextBlock = $Window.findname('NbrOfBlockedUsersTextBlock')
$NbrOfBlockedAndLicensedUsersTextBlock = $Window.findname('NbrOfBlockedAndLicensedUsersTextBlock')
$NbrOfContactsTextBlock = $Window.findname('NbrOfContactsTextBlock')
$NbrOfGuestsTextBlock = $Window.findname('NbrOfGuestsTextBlock')
$NbrOfGroupsTextBlock = $Window.findname('NbrOfGroupsTextBlock')
$NbrOfShdMlbxTtextBlock = $Window.findname('NbrOfShdMlbxTtextBlock')
$NbrofRoomsTextBlock = $Window.findname('NbrofRoomsTextBlock')
$NbrOfEquipTextBlock = $Window.findname('NbrOfEquipTextBlock')
#EXO Tab(s)
$MlbxAndResourcesTotalTextBlock = $Window.findname('MlbxAndResourcesTotalTextBlock')
$MlbxAndResourcesDataGrid = $Window.findname('MlbxAndResourcesDataGrid')
$ExportMlbxAndResButton = $Window.findname('ExportMlbxAndResButton')
$GroupsTextBlock = $Window.findname('GroupsTextBlock')
$GroupsDataGrid = $Window.findname('GroupsDataGrid')
$IncludingO365GroupsTextBlock = $Window.findname('IncludingO365GroupsTextBlock')
$ExportGroupsButton = $Window.findname('ExportGroupsButton')
$AllContactsTextBlock = $Window.findname('AllContactsTextBlock')
$ContactsDataGrid = $Window.findname('ContactsDataGrid')
$ExportContactsButton = $Window.findname('ExportContactsButton')
$NbrOfAdminRolesTextBlock = $Window.findname('NbrOfAdminRolesTextBlock')
$AdminRolesDataGrid  = $Window.findname('AdminRolesDataGrid')
$ExportAdminRolesButton = $Window.findname('ExportAdminRolesButton')
$NbrOfUserRolesTextBlock = $Window.findname('NbrOfUserRolesTextBlock')
$UserRolesDataGrid = $Window.findname('UserRolesDataGrid')
$ExportUserRolesButton = $Window.findname('ExportUserRolesButton')
$NbrOfOWAPoliciesTextBlock = $Window.findname('NbrOfOWAPoliciesTextBlock')
$OWAPoliciesDataGrid = $Window.findname('OWAPoliciesDataGrid')
$ExportOWAPoliciesButton = $Window.findname('ExportOWAPoliciesButton')
$NbrOfMalwareFilterTextBlock = $Window.findname('NbrOfMalwareFilterTextBlock')
$MalwareFilterDataGrid = $Window.findname('MalwareFilterDataGrid')
$ExportMalwareFiltersButton = $Window.findname('ExportMalwareFiltersButton')
$NbrOfConnectionFiltersTextBlock = $Window.findname('NbrOfConnectionFiltersTextBlock')
$ConnectionFilterDataGrid = $Window.findname('ConnectionFilterDataGrid')
$ExportConnFiltersButton = $Window.findname('ExportConnFiltersButton')
$NbrOfSpamFiltersTextBlock = $Window.findname('NbrOfSpamFiltersTextBlock')
$SpamFilterDataGrid = $Window.findname('SpamFilterDataGrid')
$ExportSpamFiltersButton = $Window.findname('ExportSpamFiltersButton')
$NbrOfDkimTextBlock = $Window.findname('NbrOfDkimTextBlock')
$DkimDataGrid = $Window.findname('DkimDataGrid')
$ExportDkimButton = $Window.findname('ExportDkimButton')
$NbrOfRulesTextBlock = $Window.findname('NbrOfRulesTextBlock')
$RulesDataGrid = $Window.findname('RulesDataGrid')
$ExportRulesButton = $Window.findname('ExportRulesButton')
$NbrOfAcceptedDomainsTextBlock = $Window.findname('NbrOfAcceptedDomainsTextBlock')
$AcceptedDomainsDataGrid = $Window.findname('AcceptedDomainsDataGrid')
$ExportAcceptedDomainsButton = $Window.findname('ExportAcceptedDomainsButton')
$NbrOfRemoteDomainsTextBlock = $Window.findname('NbrOfRemoteDomainsTextBlock')
$RemoteDomainsDataGrid = $Window.findname('RemoteDomainsDataGrid')
$ExportRemoteDomainsButton = $Window.findname('ExportRemoteDomainsButton')
$NbrOfQuarantinedDevicesTextBlock = $Window.findname('NbrOfQuarantinedDevicesTextBlock')
$QuarantinedDevicesDataGrid = $Window.findname('QuarantinedDevicesDataGrid')
$ExportQuarantinedButton = $Window.findname('ExportQuarantinedButton')
$NbrOfDeviceAccessRulesTextBlock = $Window.findname('NbrOfDeviceAccessRulesTextBlock')
$DeviceAccessRulesDataGrid = $Window.findname('DeviceAccessRulesDataGrid')
$ExportDeviceAccessRulesButton = $Window.findname('ExportDeviceAccessRulesButton')
$NbrOfMobileDeviceMlbxPoliciesTextBlock = $Window.findname('NbrOfMobileDeviceMlbxPoliciesTextBlock')
$MobileDeviceMlbxPoliciesDataGrid = $Window.findname('MobileDeviceMlbxPoliciesDataGrid')
$ExportDeviceMlbxPolicyButton = $Window.findname('ExportDeviceMlbxPolicyButton')
#SPO Tab(s)
$NbrOfSiteColTextBlock = $Window.findname('NbrOfSiteColTextBlock')
$NbrOfSiteColDataGrid = $Window.findname('NbrOfSiteColDataGrid')
$ExportAllSCButton = $Window.findname('ExportAllSCButton')
$NbrOfHubSitesTextBlock = $Window.findname('NbrOfHubSitesTextBlock')
$NbrOfHubSitesDataGrid = $Window.findname('NbrOfHubSitesDataGrid')
$ExportHubSitesButton = $Window.findname('ExportHubSitesButton')
$NbrOfPersoSiteColTextBlock = $Window.findname('NbrOfPersoSiteColTextBlock')
$NbrOfPersoSiteColDataGrid = $Window.findname('NbrOfPersoSiteColDataGrid')
$ExportAllPersoSCButton = $Window.findname('ExportAllPersoSCButton')
$SPOGlanceTextBlock = $Window.findname('SPOGlanceTextBlock')
$SPOTotalOfSCTextBlock = $Window.findname('SPOTotalOfSCTextBlock')
$SPOTotalStorageTextBlock = $Window.findname('SPOTotalStorageTextBlock')
$SPOTotalStorageAllocatedTextBlock = $Window.findname('SPOTotalStorageAllocatedTextBlock')
$SPOTotalServerResourcesTextBlock = $Window.findname('SPOTotalServerResourcesTextBlock')
$SPOTotalResourcesAllocatedTextBlock = $Window.findname('SPOTotalResourcesAllocatedTextBlock')
$SPOSharingCapabilityTextBlock = $Window.findname('SPOSharingCapabilityTextBlock')
$ReqInvitationWithSameAcctTextBlock = $Window.findname('ReqInvitationWithSameAcctTextBlock')
$SPOExternalUsersInviteSameAcctTextBlock = $Window.findname('SPOExternalUsersInviteSameAcctTextBlock')
$ODFBforGuestEnabledTextBlock = $Window.findname('ODFBforGuestEnabledTextBlock')
$SPODefaultSharingLinkTypeTextBlock = $Window.findname('SPODefaultSharingLinkTypeTextBlock')
$SPOPreventExternalUsersFromResharingTextBlock = $Window.findname('SPOPreventExternalUsersFromResharingTextBlock')
$FileAnonymousLinkTypeTextBlock = $Window.findname('FileAnonymousLinkTypeTextBlock')
$FolderAnonymousLinkTypeTextBlock = $Window.findname('FolderAnonymousLinkTypeTextBlock')
$SPONotifyOwnersItemsResharedTextBlock = $Window.findname('SPONotifyOwnersItemsResharedTextBlock')
$SPODefaultLinkPermissionTextBlock = $Window.findname('SPODefaultLinkPermissionTextBlock')
#Skype & Teams
$NbrOfSkypeUsersTextBlock = $Window.findname('NbrOfSkypeUsersTextBlock')
$NbrOfSkypeUsersDataGrid = $Window.findname('NbrOfSkypeUsersDataGrid')
$ExportSkypeUsersButton = $Window.findname('ExportSkypeUsersButton')

#endregion


#Focus on AdminTextBox when Window loads
$AdminTextBox.Focus() | Out-Null


#Enable the "Connect" button if text is entered in the $AdminTextBox
$AdminTextBox.Add_TextChanged({
	if ($AdminTextBox.Text.Length -eq 0){
		$ConnectButton.IsEnabled = $false
	}
	else {
		$ConnectButton.IsEnabled = $true
		$ConnectButton.Background = "#adc5dd"
	}
})


#This happens when the "Connect" button is clicked
$ConnectButton.Add_Click( {

#region top block of the tool
        try {
            $AdminUserName = $AdminTextBox.Text
            [string][ValidateNotNullOrEmpty()]$AdminPwd = $AdminPwdTextbox.Password
            $SecretPwd = ConvertTo-SecureString -String $AdminPwd -AsPlainText -Force
            $creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($AdminUserName, $SecretPwd)
        }
        catch [System.Management.Automation.ErrorRecord] {
            $PwdErrorParams = @{
                Content             = "Password incorrect. Make sure you entered the correct credentials and try again."
                Title               = "Error with credentials"
                TitleBackground     = "LightGray"
                TitleTextForeground = "Red"
                TitleFontSize       = 24
                ContentFontSize     = 16
                BorderThickness     = 1
            }
            New-WPFMessageBox @PwdErrorParams
        }


		#Doing some pre-checks to see if modules are present
		Write-Host "Doing some pre-checks. One moment..." -ForegroundColor Black -BackgroundColor DarkGreen

		#Check ExecutionPolicy is set to "Unrestricted" on computer running the tool (for version 0.1.0)
		$ExecutionPolicy = Get-ExecutionPolicy
		if($ExecutionPolicy -ne "Unrestricted"){
			Write-Host "For this release 0.1.0, the execution policy must be set to Unrestricted. Please change it and try again." -ForegroundColor White -BackgroundColor DarkRed
			$Window.Close()
			break
		}
		else{
			Write-Host "Execution policy set to Unrestricted. OK." -ForegroundColor Green
		}

		#Check if MSOnline module present
		if (!(Get-Module -ListAvailable -Name "MSOnline")){
			Write-Host "Microsoft Online Module not present. Please download it at: https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell#connect-with-the-microsoft-azure-active-directory-module-for-windows-powershell " -ForegroundColor Red
			$Window.Close()
			break
		}
		else{
			Write-Host "Microsoft Online Module present. OK." -ForegroundColor Green
        }
        
		#Check if SharePoint Online module present
		if (!(Get-Module -ListAvailable -Name "Microsoft.Online.SharePoint.PowerShell")){
			Write-Host "SharePoint Online Module not present. Please download it at: https://www.microsoft.com/en-us/download/details.aspx?id=35588" -ForegroundColor Red
			$Window.Close()
			break
		}
		else{
			Write-Host "SharePoint Online Module present. OK." -ForegroundColor Green
		}
		
		#Check if Skype For Business Online module present
		if (!(Get-Module -ListAvailable -Name "SkypeOnlineConnector")){
			Write-Host "Skype For Business Online Module not present. Please download it at: https://www.microsoft.com/en-us/download/details.aspx?id=39366" -ForegroundColor Red
			$Window.Close()
			break
		}
		else{
			Write-Host "Skype For Business Online Module present. OK." -ForegroundColor Green
		}

		#Check if Microsoft Teams module present
		if (!(Get-Module -ListAvailable -Name "MicrosoftTeams")){
			Write-Host "Microsoft Teams Module not present. Please download it at: https://www.powershellgallery.com/packages/MicrosoftTeams/" -ForegroundColor Red
			$Window.Close()
			break
		}
		else{
			Write-Host "Microsoft Teams Module present. OK." -ForegroundColor Green
		}

        
        #Connect to O365
        try {
			Write-Host "Connecting to Msol Service..." -ForegroundColor Cyan
            Connect-MsolService -Credential $creds -ErrorAction Stop

			#Check if user is a Global Admin
			$userLogged = ($creds).UserName
			$GlobalAdminRole = Get-MsolRole -RoleName "Company Administrator"
			$GlobalAdminRoleObjectId = ($GlobalAdminRole).ObjectId
			$GARoleMember = Get-MsolRoleMember -RoleObjectId $GlobalAdminRoleObjectId

			if ($userLogged -in ($GARoleMember.EmailAddress)){
				Write-Host "You are a Global Admin. OK." -ForegroundColor White
			}
			else{
				Write-Host "You are not a Global Admin! Release 0.1.0 is only available for Global Admins. Please try again with the correct account." -ForegroundColor White -BackgroundColor DarkRed
				$Window.Close()
				break
			}

            $ConnectButton.Background = "Green"
            $ConnectButton.Foreground = "White"
            $ConnectButton.Content = "Connected"
            $ConnectButton.IsHitTestVisible = $false
            $AdminPwdTextbox.Clear()
            $AdminPwdTextbox.IsEnabled = $false
            $AdminPwdTextbox.Background = "#bdbfc1"
            $AdminTextBox.IsEnabled = $false
            $AdminTextBox.Background = "#bdbfc1"
        }
        catch {
            $CredsErrorParams = @{
                Content             = "Username or password incorrect. Make sure you entered the correct credentials and try again."
                Title               = "Error with credentials"
                TitleBackground     = "LightGray"
                TitleTextForeground = "Red"
                TitleFontSize       = 24
                ContentFontSize     = 16
                BorderThickness     = 1
            }
            New-WPFMessageBox @CredsErrorParams

            #Clear all and start over
            $AdminTextBox.Clear()
            $AdminPwdTextbox.Clear()
            return
        }

        #Connect to EXO - By default, all accounts you create in Exchange Online are allowed to use Exchange Online PowerShell.
		Write-Host "Connecting to Exchange Online..." -ForegroundColor Cyan

		#If user is MFA enabled
		$UserAuthN = Get-MsolUser -UserPrincipalName ($creds).UserName 
		if(($UserAuthN.StrongAuthenticationMethods) -ne $null){
			Write-Host "You are MFA enabled..." -ForegroundColor Magenta
			Write-Host "Unfortunately, we don't support users enabled for MFA at this point in time. Try again with a user account not MFA enabled." -ForegroundColor White -BackgroundColor DarkRed
			$Window.Close()
			break
		}
		else{
			$EXOsession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $creds -Authentication Basic -AllowRedirection
			Import-PSSession $EXOsession -AllowClobber | Out-Null
		}
		      
        #Need to run the cmdlet now (after connection to EXO) to get the $SPOTenant variable assigned to the connection to SPO
        [System.String]$Tenant = Get-OrganizationConfig | Select-Object -ExpandProperty Name
        $SPOTenant = $Tenant.Replace(".onmicrosoft.com", "")

        #Connect to SPO
        Write-Host "Connecting to SharePoint Online..." -ForegroundColor Cyan
        Connect-SPOService -Url https://$SPOTenant-admin.sharepoint.com -Credential $creds

        #Connect to the Compliance Center
        Write-Host "Connecting to the Compliance Center..." -ForegroundColor Cyan
        $ccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $creds -Authentication Basic -AllowRedirection
        Import-PSSession $ccSession -Prefix cc -AllowClobber | Out-Null

        #Connect to SfBO
		Write-Host "Connecting to Skype for Business Online..." -ForegroundColor Cyan
		
		## SfBO needs WinRM to be started  ### A warning about increasing the WSMan NetworkDelayms value is expected the first time you connect and should be ignored.
		if ((Get-Service -Name WinRM).Status -eq "Stopped"){
			Write-Warning "WinRM is required for SfBO PowerShell Module. Starting the WinRM service..."
			Get-Service -Name WinRM | Start-Service
			Import-Module SkypeOnlineConnector
		}
		else{
			Write-Host "WinRM service already started. OK." -ForegroundColor Green
		}

		#Import-Module SkypeOnlineConnector
        $SfBOsession = New-CsOnlineSession -Credential $creds
        Import-PSSession $SfBOsession -AllowClobber | Out-Null


		#Gathering the data
		Write-Host "Gathering the data... Be patient." -ForegroundColor White

        #Then the "Disconnect" button becomes enabled
        $DisconnectButton.IsEnabled = $true
        $DisconnectButton.Background = "#e29609"


        #Declare the variables for the TextBlocks on top of the tool
        $MSOLCompanyInfo = Get-MsolCompanyInformation
        [System.String]$TenantDisplayName = $MSOLCompanyINfo | Select-Object -ExpandProperty DisplayName
        [System.String]$TenantCountry = $MSOLCompanyINfo | Select-Object -ExpandProperty CountryLetterCode
        [System.String]$TechContact = $MSOLCompanyINfo | Select-Object -ExpandProperty TechnicalNotificationEmails
        [System.String]$TechContactPhone = $MSOLCompanyINfo | Select-Object -ExpandProperty TelephoneNumber
        $MSOLAccountSKU = Get-MsolAccountSku
        $TotalO365Plans = ($MSOLAccountSKU).count
        $TotalLicensesAllPlans = $MSOLAccountSKU | Measure-Object ActiveUnits -Sum | Select-Object -ExpandProperty Sum
        $TotalLicensesAssignedAllPlans = $MSOLAccountSKU | Measure-Object ConsumedUnits -Sum | Select-Object -ExpandProperty Sum


        #Display info on top of the tool -- All TextBlocks (x13)
        $TenantTextBlock.Text = $Tenant
        $OrgNameTextBlock.Text = $TenantDisplayName
        $CountryTextBlock.Text = $TenantCountry
        $TechContactTextBlock.Text = $TechContact
        $ContactPhoneNbrTextBlock.Text = $TechContactPhone
        $TotalNbrPlansTextBlock.Text = $TotalO365Plans
        $TotalNbrPlansTextBlock.Foreground = "Green"
        $TotalLicensesTextBlock.Text = $TotalLicensesAllPlans
        $TotalLicensesTextBlock.Foreground = "Green"
        $TotalAssignedLicensesTextBlock.Text = $TotalLicensesAssignedAllPlans
        $TotalAssignedLicensesTextBlock.Foreground = "Green"

        #Check if DirSync is enabled or not
        [System.String]$DirSyncEnabled = $MSOLCompanyINfo | Select-Object -ExpandProperty DirectorySynchronizationEnabled
        if ($DirSyncEnabled -eq $true) {
            $DirSyncEnabledTextBlock.Text = "Yes"
            $DirSyncEnabledTextBlock.Foreground = "Green"
        }
        else {
            $DirSyncEnabledTextBlock.Text = "No"
            $DirSyncEnabledTextBlock.Foreground = "Red"
        }

        #Check if PasswordSync is enabled or not
        [System.String]$PwdSyncEnabled = $MSOLCompanyINfo | Select-Object -ExpandProperty PasswordSynchronizationEnabled
        if ($PwdSyncEnabled -eq $true) {
            $PwdSyncEnabledTextBlock.Text = "Yes"
            $PwdSyncEnabledTextBlock.Foreground = "Green"
        }
        else {
            $PwdSyncEnabledTextBlock.Text = "No"
            $PwdSyncEnabledTextBlock.Foreground = "Red"
        }

        #Check Last DirSync Time
        $LastDirSyncTime = $MSOLCompanyINfo | Select-Object -ExpandProperty LastDirSyncTime
        if ($DirSyncEnabled -eq $true) {
            $LastDirSyncTimeTextBlock.Text = ($LastDirSyncTime).DateTime
        }
        else {
            $LastDirSyncTimeTextBlock.Text = "N/A"
        }

        #Check Last DirSync Password Sync Time
        $LastPwdSyncTime = $MSOLCompanyINfo | Select-Object -ExpandProperty LastPasswordSyncTime
        if ($PwdSyncEnabled -eq $true) {
            $LastPwdSyncTimeTextBlock.Text = ($LastPwdSyncTime).DateTime
        }
        else {
            $LastPwdSyncTimeTextBlock.Text = "N/A"
        }

        #Check for status of features release in tenant
        [System.String]$FeaturesRelease = Get-OrganizationConfig | Select-Object -ExpandProperty ReleaseTrack
        $FeaturesReleaseTextBlock.Text = $FeaturesRelease

#endregion of Top block of the tool

#region TENANT TAB
        #Domains
        Write-Host "Retrieving MSOL domains..." -ForegroundColor Cyan
		$script:TenantDomains = Get-MsolDomain
        $script:DomainsResults = @()
        foreach ($Domain in $TenantDomains) {
            $DomainProps = @{
                Name = $Domain.Name
				IsDefault = $Domain.IsDefault
				Status = $Domain.Status
				Authentication = $Domain.Authentication
            }
            $script:DomainsResults += New-Object PSObject -Property $DomainProps
        }
        $DomainsResults | Select-Object Name, IsDefault, Status, Authentication

        $NbrOfDomainsTextBlock.Text = ($DomainsResults).Count
        $NbrOfDomainsTextBlock.Foreground = "Red"
        $DomainsDataGrid.ItemsSource = $DomainsResults


        #Export Domains
        $ExportDomainsButton.Add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveDomainsFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveDomainsFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveDomainsFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveDomainsFileDialog.SupportMultiDottedExtensions = $true
                $SaveDomainsFileDialog.FileName

                # Save the file...
                if ($SaveDomainsFileDialog.ShowDialog() -eq 'OK') {
                    $script:DomainsResults | Export-Csv $($SaveDomainsFileDialog.FileName) -NoTypeInformation -Encoding UTF8
                }
            })

        #Plans
        Write-Host "Retrieving Subscription data..." -ForegroundColor Cyan
		$script:Plans = Get-MsolSubscription
		$PlansResults = @()
		foreach($plan in $Plans){
			$PlanProps = @{
				SkuPartNumber = $plan.SkuPartNumber 
				TotalLicenses = $plan.TotalLicenses
				IsTrial = $plan.IsTrial
				Status = $plan.Status
			}
			$PlansResults += New-Object PSObject -Property $PlanProps
		}
		$PlansResults | Select-Object SkuPartNumber, TotalLicenses, IsTrial, Status

        $NbrOfPlansTextBlock.Text = ($PlansResults).count
        $NbrOfPlansTextBlock.Foreground = "Red"
        $PlansDataGrid.ItemsSource = $PlansResults

        #Export Plans
        $ExportPlansButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SavePlansFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SavePlansFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SavePlansFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SavePlansFileDialog.SupportMultiDottedExtensions = $true
                $SavePlansFileDialog.FileName

                # Save the file...
                if ($SavePlansFileDialog.ShowDialog() -eq 'OK') {
                    $script:Plans | Select-Object SkuPartNumber, TotalLicenses, IsTrial, Status | Export-Csv $($SavePlansFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

        #Global Admins 
        Write-Host "Retrieving admin roles..." -ForegroundColor Cyan
        $GArole = Get-MsolRole -RoleName "Company Administrator"
        $GARoleObjectId = ($GArole).ObjectId
        $script:GlobalAdmins = Get-MsolRoleMember -RoleObjectId $GARoleObjectId | Select-Object DisplayName, EmailAddress, IsLicensed
        $GARoleCount = $GlobalAdmins.count
        $NbrOfGATextBlock.Text = $GARoleCount
        $NbrOfGATextBlock.Foreground = "Red"
        $GADataGrid.ItemsSource = $GlobalAdmins

        #Export GA
        $ExportGAButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveGAFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveGAFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveGAFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveGAFileDialog.SupportMultiDottedExtensions = $true
                $SaveGAFileDialog.FileName

                # Save the file...
                if ($SaveGAFileDialog.ShowDialog() -eq 'OK') {
                    $script:GlobalAdmins | Export-Csv $($SaveGAFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

        #At a Glance section (right side)
        Write-Host "Retrieving users..." -ForegroundColor Cyan
        $AllUsersList = Get-MsolUser -All
        $AllUsers = $AllUsersList.count
        $NbrOfUsersTextBlock.Text = $AllUsers

        $SyncedUsers = $AllUsersList | Where-Object {$_.ImmutableId -ne $null}
        $NbrOfSyncedUsersTextBlock.Text = ($SyncedUsers).count

        $CloudUsers = $AllUsersList | Where-Object {$_.ImmutableId -eq $null}
        $NbrOfCloudUsersTextBlock.Text = ($CloudUsers).count

        $BlockedUsers = $AllUsersList | Where-Object {$_.BlockCredential -eq $true -and $_.IsLicensed -eq $false}
        $NbrOfBlockedUsersTextBlock.Text = ($BlockedUsers).count

        $LicensedAndBlockedUsers = $AllUsersList | Where-Object {$_.IsLicensed -eq $true -and $_.BlockCredential -eq $true}
        $NbrOfBlockedAndLicensedUsersTextBlock.Text = ($LicensedAndBlockedUsers).count
        if (($LicensedAndBlockedUsers).count -gt 0) {
            $NbrOfBlockedAndLicensedUsersTextBlock.Foreground = "Red"
        }
        else {
            $NbrOfBlockedAndLicensedUsersTextBlock.Foreground = "Black"
        }
        Write-Host "Retrieving contacts..." -ForegroundColor Cyan
        $AllContactsList = Get-MsolContact -All
        $AllContacts = $AllContactsList.count
        $NbrOfContactsTextBlock.Text = $AllContacts

        $AllGuests = ($AllUsersList | Where-Object {$_.UserType -eq "Guest"}).count
        $NbrOfGuestsTextBlock.Text = $AllGuests
        
        Write-Host "Retrieving groups..." -ForegroundColor Cyan
        $Script:AllGroups = Get-MsolGroup -All
        $NbrOfGroupsTextBlock.Text = $AllGroups.count

        Write-Host "Retrieving mailboxes..." -ForegroundColor Cyan
        $script:AllMailboxesList = Get-Mailbox -ResultSize Unlimited

        $AllSharedMlbx = $AllMailboxesList | where-Object { $_.RecipientTypeDetails -eq 'SharedMailbox' } | Measure-Object
        $NbrOfShdMlbxTtextBlock.Text = $AllSharedMlbx.count

        $AllRooms = $AllMailboxesList | where-Object { $_.RecipientTypeDetails -eq 'RoomMailbox' } | Measure-Object
        $NbrofRoomsTextBlock.Text = $AllRooms.count

        $AllEquipments = $AllMailboxesList | where-Object { $_.RecipientTypeDetails -eq 'EquipmentMailbox' } |  Measure-Object
        $NbrOfEquipTextBlock.Text = $AllEquipments.count
#endregion

#region EXO TAB

        #RECIPIENT tab
        #Mailboxes & Resources
        $script:AllMlbxAndResources = $AllMailboxesList | Select-Object DisplayName, UserPrincipalName, RecipientTypeDetails, PrimarySmtpAddress, `
								ArchiveStatus, ArchiveQuota, AuditEnabled, IsDirSynced, IsShared

        $MlbxAndResourcesTotalTextBlock.Text = $AllMlbxAndResources.Count
        $MlbxAndResourcesTotalTextBlock.Foreground = "Red"
        $MlbxAndResourcesDataGrid.ItemsSource = $AllMlbxAndResources

        #Export Mlbx & Resources
        $ExportMlbxAndResButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveMlbxAndResFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveMlbxAndResFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveMlbxAndResFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveMlbxAndResFileDialog.SupportMultiDottedExtensions = $true
                $SaveMlbxAndResFileDialog.FileName

                # Save the file...
                if ($SaveMlbxAndResFileDialog.ShowDialog() -eq 'OK') {
                    $script:AllMlbxAndResources | Export-Csv $($SaveMlbxAndResFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Groups 
        $AllGroupsResults = @()
        foreach ($Group in $script:AllGroups) {
            $GroupsProps = @{
                DisplayName  = $Group.DisplayName
                EmailAddress = $Group.EmailAddress
                GroupType    = $Group.GroupType
            }
            $AllGroupsResults += New-Object PSObject -Property $GroupsProps
        }
        $AllGroupsResults | Select-Object DisplayName, EmailAddress, GroupType

        $GroupsTextBlock.Text = ($AllGroupsResults).Count
        $GroupsTextBlock.Foreground = "Red"
        $GroupsDataGrid.ItemsSource = $AllGroupsResults


        #Export Groups
        $ExportGroupsButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveAllGroupsFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveAllGroupsFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveAllGroupsFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveAllGroupsFileDialog.SupportMultiDottedExtensions = $true
                $SaveAllGroupsFileDialog.FileName

                # Save the file...
                if ($SaveAllGroupsFileDialog.ShowDialog() -eq 'OK') {
                    $AllGroups | Select-Object DisplayName, EmailAddress, GroupType | Export-Csv $($SaveAllGroupsFileDialog.filename) -NoTypeInformation -Encoding UTF8
                    }
            })


        #Contacts
        Write-Host "Retrieving exchange contacts..." -ForegroundColor Cyan
        $script:ContactsResults = @()
        $script:AllContacts = Get-Contact -ResultSize Unlimited

        foreach ($Contact in $AllContacts) {
            $ContactsProps = @{
                DisplayName        = $Contact.DisplayName
                Company         = $Contact.Company
                Title            = $Contact.Title
                CountryorRegion  = $Contact.CountryOrRegion
                PostalCode      = $Contact.PostalCode
                IsDirSynced      = $Contact.IsDirSynced
                RecipientTypeDetails = $Contact.RecipientTypeDetails
            }
            $script:ContactsResults += New-Object PSObject -Property $ContactsProps
        }
        $ContactsResults | Select-Object DisplayName, Company, Title, CountryOrRegion, PostalCode, IsDirSynced, RecipientTypeDetails

        $AllContactsTextBlock.Text = ($ContactsResults).Count
        $AllContactsTextBlock.Foreground = "Red"
        $ContactsDataGrid.ItemsSource = $ContactsResults

        #Export Contacts
        $ExportContactsButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveAllContactsFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveAllContactsFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveAllContactsFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveAllContactsFileDialog.SupportMultiDottedExtensions = $true
                $SaveAllContactsFileDialog.FileName

                # Save the file...
                if ($SaveAllContactsFileDialog.ShowDialog() -eq 'OK') {
                    $script:ContactsResults | Export-Csv $($SaveAllContactsFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

        #PERMISSIONS tab
        #Admin Roles
        Write-Host "Retrieving admin roles..." -ForegroundColor Cyan
        $script:AdminRolesPerm = Get-RoleGroup -ResultSize Unlimited 
        $script:AdminRolesResults = @()
		
		foreach($AdminRole in $AdminRolesPerm){
			$AdminRoleProps = @{
				Name = $AdminRole.Name
				Description = $AdminRole.Description
				Members = $AdminRole.Members -join "`n"
				Roles = ($AdminRole.Roles) -join "`n"
			}
			$script:AdminRolesResults += New-Object PSObject -Property $AdminRoleProps
		}
		$AdminRolesResults | Select-Object Name, Description, Members, Roles
	
		$NbrOfAdminRolesTextBlock.Text = ($AdminRolesResults).Count
        $NbrOfAdminRolesTextBlock.Foreground = "Red"
        $AdminRolesDataGrid.ItemsSource = $AdminRolesResults

		#Export Admin Roles
        $ExportAdminRolesButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveAdminRolesFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveAdminRolesFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveAdminRolesFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveAdminRolesFileDialog.SupportMultiDottedExtensions = $true
                $SaveAdminRolesFileDialog.FileName

                # Save the file...
                if ($SaveAdminRolesFileDialog.ShowDialog() -eq 'OK') {
                    $script:AdminRolesResults | Export-Csv $($SaveAdminRolesFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #User Roles 
        Write-Host "Retrieving admin role policies..." -ForegroundColor Cyan
		$script:ExoUserRoles = Get-RoleAssignmentPolicy
		$script:UserRolesResults = @()

		foreach($UserRole in $ExoUserRoles){
			$UserRoleProps = @{
				Name = $UserRole.Name
				IsDefault = $UserRole.IsDefault
				Description = $UserRole.Description
				AssignedRoles = ($UserRole.AssignedRoles) -join "`n"
			}
			$script:UserRolesResults += New-Object PSObject -Property $UserRoleProps
		}
		$UserRolesResults | Select-Object Name, IsDefault, Description, AssignedRoles

        $NbrOfUserRolesTextBlock.Text = ($UserRolesResults).Count
        $NbrOfUserRolesTextBlock.Foreground = "Red"
        $UserRolesDataGrid.ItemsSource = $UserRolesResults
     
		#Export User Roles
        $ExportUserRolesButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveUserRolesFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveUserRolesFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveUserRolesFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveUserRolesFileDialog.SupportMultiDottedExtensions = $true
                $SaveUserRolesFileDialog.FileName

                # Save the file...
                if ($SaveUserRolesFileDialog.ShowDialog() -eq 'OK') {
                    $script:UserRolesResults | Export-Csv $($SaveUserRolesFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #OWA Policies
        Write-Host "Retrieving mailbox policies..." -ForegroundColor Cyan
		$script:OWAPolicies = Get-OwaMailboxPolicy
		$script:OWAPoliciesResults = @()

		foreach($OWAPolicy in $OWAPolicies){
			$OWAPolicyProps = @{
				Name = $OWAPolicy.Name
				IsDefault = $OWAPolicy.IsDefault
				WhenCreated = $OWAPolicy.WhenCreated
				WhenChanged = $OWAPolicy.WhenChanged
			}
			$script:OWAPoliciesResults += New-Object PSObject -Property $OWAPolicyProps
		}
		$OWAPoliciesResults | Select-Object Name, IsDefault, WhenCreated, WhenChanged

        $NbrOfOWAPoliciesTextBlock.Text = ($OWAPoliciesResults).Count
        $NbrOfOWAPoliciesTextBlock.Foreground = "Red"
        $OWAPoliciesDataGrid.ItemsSource = $OWAPoliciesResults

		#Export OWA Policies
        $ExportOWAPoliciesButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveOWAPoliciesFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveOWAPoliciesFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveOWAPoliciesFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveOWAPoliciesFileDialog.SupportMultiDottedExtensions = $true
                $SaveOWAPoliciesFileDialog.FileName

                # Save the file...
                if ($SaveOWAPoliciesFileDialog.ShowDialog() -eq 'OK') {
                    $script:OWAPoliciesResults | Export-Csv $($SaveOWAPoliciesFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #PROTECTION tab
        #Malware Filter   
        Write-Host "Retrieving malware policies..." -ForegroundColor Cyan
		$Script:MalwarePolicies = Get-MalwareFilterPolicy
		$Script:MalwarePoliciesResults = @()
		
		foreach($MalwarePolicy in $MalwarePolicies){
			$MalwarePolicyProps = @{
				Name = $MalwarePolicy.Name
				IsDefault = $MalwarePolicy.IsDefault
				Action = $MalwarePolicy.Action
				CustomNotifications = $MalwarePolicy.CustomNotifications
				WhenCreated = $MalwarePolicy.WhenCreated
				WhenChanged = $MalwarePolicy.WhenChanged
			}
			$Script:MalwarePoliciesResults += New-Object PSObject -Property $MalwarePolicyProps
		}
		$MalwarePoliciesResults | Select-Object Name, IsDefault, Action, CustomNotifications, WhenCreated, WhenChanged

		$NbrOfMalwareFilterTextBlock.Text = ($MalwarePoliciesResults).Count
        $NbrOfMalwareFilterTextBlock.Foreground = "Red"
        $MalwareFilterDataGrid.ItemsSource = $MalwarePoliciesResults

		#Export Malware Filter
        $ExportMalwareFiltersButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveMalwareFiltersFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveMalwareFiltersFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveMalwareFiltersFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveMalwareFiltersFileDialog.SupportMultiDottedExtensions = $true
                $SaveMalwareFiltersFileDialog.FileName

                # Save the file...
                if ($SaveMalwareFiltersFileDialog.ShowDialog() -eq 'OK') {
                    $Script:MalwarePoliciesResults | Export-Csv $($SaveMalwareFiltersFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Connection Filter 
        Write-Host "Retrieving hosted filter policies..." -ForegroundColor Cyan
        $script:ConnectionFilterResults = @()
        $script:AllConnectionFilters = Get-HostedConnectionFilterPolicy

        foreach ($Connection in $AllConnectionFilters){
            $ConnectionFilterProps = @{
                Name = $Connection.Name
                Default = $Connection.IsDefault
                SafeList = $Connection.EnableSafeList
                IPAllowList = ($Connection.IPAllowList) -join "`n"
                IPBlockList = ($Connection.IPBlockList) -join "`n"
            }
            $script:ConnectionFilterResults += New-Object PSObject -Property $ConnectionFilterProps
        }
        $ConnectionFilterResults | Select-Object Name, Default, SafeList, IPAllowList, IPBlockList

        $NbrOfConnectionFiltersTextBlock.Text = ($ConnectionFilterResults).Count
        $NbrOfConnectionFiltersTextBlock.Foreground = "Red"
        $ConnectionFilterDataGrid.ItemsSource = $ConnectionFilterResults

		#Export Connection Filter
        $ExportConnFiltersButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveConnFiltersFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveConnFiltersFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveConnFiltersFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveConnFiltersFileDialog.SupportMultiDottedExtensions = $true
                $SaveConnFiltersFileDialog.FileName

                # Save the file...
                if ($SaveConnFiltersFileDialog.ShowDialog() -eq 'OK') {
                    $script:ConnectionFilterResults | Export-Csv $($SaveConnFiltersFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Spam Filter 
        Write-Host "Retrieving content filter policies..." -ForegroundColor Cyan
		$script:SpamFilters = Get-HostedContentFilterPolicy
		$script:SpamFilterResults = @()
	
		foreach ($SpamFilter in $SpamFilters){
            $SpamFilterProps = @{
                Name = $SpamFilter.Name
                Default = $SpamFilter.IsDefault
                SpamAction = $SpamFilter.SpamAction
                HighConfidenceSpamAction = $SpamFilter.HighConfidenceSpamAction
                BulkSpamAction = $SpamFilter.BulkSpamAction
				BulkThreshold = $SpamFilter.BulkThreshold
				LanguageBlockList = $SpamFilter.LanguageBlockList
				RegionBlockList = $SpamFilter.RegionBlockList
				EndUserSpamNotificationFrequency = $SpamFilter.EndUserSpamNotificationFrequency
            }
            $script:SpamFilterResults += New-Object PSObject -Property $SpamFilterProps
        }
        $SpamFilterResults | Select-Object Name, IsDefault, SpamAction, HighConfidenceSpamAction, BulkSpamAction, BulkThreshold, LanguageBlockList, RegionBlockList, EndUserSpamNotificationFrequency

		$NbrOfSpamFiltersTextBlock.Text = ($SpamFilterResults).Count
        $NbrOfSpamFiltersTextBlock.Foreground = "Red"
        $SpamFilterDataGrid.ItemsSource = ($SpamFilterResults)

		#Export Spam Filter
        $ExportSpamFiltersButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveSpamFiltersFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveSpamFiltersFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveSpamFiltersFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveSpamFiltersFileDialog.SupportMultiDottedExtensions = $true
                $SaveSpamFiltersFileDialog.FileName

                # Save the file...
                if ($SaveSpamFiltersFileDialog.ShowDialog() -eq 'OK') {
                    $script:SpamFilterResults | Export-Csv $($SaveSpamFiltersFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Dkim
        Write-Host "Retrieving dkim signing policies..." -ForegroundColor Cyan
		$script:Dkim = Get-DkimSigningConfig
		$script:DkimResults = @()

		foreach ($DkimSigning in $Dkim){
            $DkimProps = @{
                Domain = $DkimSigning.Domain
                Enabled = $DkimSigning.Enabled
                Status = $DkimSigning.Status
                LastChecked = $DkimSigning.LastChecked
            }
            $script:DkimResults += New-Object PSObject -Property $DkimProps
        }
        $DkimResults | Select-Object Domain, Enabled, Status, LastChecked
		
		$NbrOfDkimTextBlock.Text = ($DkimResults).Count
        $NbrOfDkimTextBlock.Foreground = "Red"
		$DkimDataGrid.ItemsSource = $DkimResults

		#Export Spam Filter
        $ExportDkimButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveDkimFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveDkimFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveDkimFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveDkimFileDialog.SupportMultiDottedExtensions = $true
                $SaveDkimFileDialog.FileName

                # Save the file...
                if ($SaveDkimFileDialog.ShowDialog() -eq 'OK') {
                    $script:DkimResults | Export-Csv $($SaveDkimFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #MAIL FLOW tab
        #Rules
        Write-Host "Retrieving transport rules..." -ForegroundColor Cyan
        $script:TransportRules = Get-TransportRule | Select-Object Name, State, Mode, Priority, Comments, ActivationDate, ExpiryDate
        $NbrOfRulesTextBlock.Text = ($TransportRules).Count
        $NbrOfRulesTextBlock.Foreground = "Red"
        $RulesDataGrid.ItemsSource = ($TransportRules)

		#Export Rules
        $ExportRulesButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveRulesFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveRulesFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveRulesFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveRulesFileDialog.SupportMultiDottedExtensions = $true
                $SaveRulesFileDialog.FileName

                # Save the file...
                if ($SaveRulesFileDialog.ShowDialog() -eq 'OK') {
                    $script:TransportRules | Export-Csv $($SaveRulesFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Accepted Domains
        Write-Host "Retrieving accepted domains..." -ForegroundColor Cyan
		$script:AcceptedDomains = Get-AcceptedDomain
		$script:AcceptedDomainsResults = @()
		
		foreach ($AcceptedDomain in $AcceptedDomains) {
            $AcceptedDomainProps = @{
                DomainName = $AcceptedDomain.DomainName
                Default = $AcceptedDomain.Default
                DomainType = $AcceptedDomain.DomainType
                ExternallyManaged = $AcceptedDomain.ExternallyManaged
                AddressBookEnabled = $AcceptedDomain.AddressBookEnabled
            }
            $script:AcceptedDomainsResults += New-Object PSObject -Property $AcceptedDomainProps
        }
        $AcceptedDomainsResults | Select-Object DomainName, Default, DomainType, ExternallyManaged, AddressBookEnabled
	
		$NbrOfAcceptedDomainsTextBlock.Text = ($AcceptedDomainsResults).Count
        $NbrOfAcceptedDomainsTextBlock.Foreground = "Red"
        $AcceptedDomainsDataGrid.ItemsSource = ($AcceptedDomainsResults)

		#Export Accepted Domains
        $ExportAcceptedDomainsButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveAcceptedDomainsFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveAcceptedDomainsFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveAcceptedDomainsFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveAcceptedDomainsFileDialog.SupportMultiDottedExtensions = $true
                $SaveAcceptedDomainsFileDialog.FileName

                # Save the file...
                if ($SaveAcceptedDomainsFileDialog.ShowDialog() -eq 'OK') {
                    $script:AcceptedDomainsResults | Export-Csv $($SaveAcceptedDomainsFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Remote Domains
        Write-Host "Retrieving remote domains..." -ForegroundColor Cyan
        $script:RemoteDomainsResults = @()
        $script:RemoteDomains = Get-RemoteDomain

        foreach ($RemoteDomain in $RemoteDomains) {
            $RemoteDomainProps = @{
                Name = $RemoteDomain.Name
                DomainName = $RemoteDomain.DomainName
                AllowedOOFType = $RemoteDomain.AllowedOOFType
                AutoReplyEnabled = $RemoteDomain.AutoReplyEnabled
                AutoForwardEnabled = $RemoteDomain.AutoForwardEnabled
                DeliveryReportEnabled = $RemoteDomain.DeliveryReportEnabled
                NDREnabled = $RemoteDomain.NDREnabled
                MeetingForwardNotificationEnabled = $RemoteDomain.MeetingForwardNotificationEnabled
            }
            $script:RemoteDomainsResults += New-Object PSObject -Property $RemoteDomainProps
        }
        $RemoteDomainsResults | Select-Object Name, DomainName, AllowedOOFType, AutoReplyEnabled, AutoForwardEnabled, DeliveryReportEnabled, NDREnabled, MeetingForwardNotificationEnabled

        $NbrOfRemoteDomainsTextBlock.Text = ($RemoteDomainsResults).Count
        $NbrOfRemoteDomainsTextBlock.Foreground = "Red"
        $RemoteDomainsDataGrid.ItemsSource = ($RemoteDomainsResults)

		#Export Remote Domains
        $ExportRemoteDomainsButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveRemoteDomainsFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveRemoteDomainsFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveRemoteDomainsFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveRemoteDomainsFileDialog.SupportMultiDottedExtensions = $true
                $SaveRemoteDomainsFileDialog.FileName

                # Save the file...
                if ($SaveRemoteDomainsFileDialog.ShowDialog() -eq 'OK') {
                    $script:RemoteDomainsResults | Export-Csv $($SaveRemoteDomainsFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

	
        #MOBILE DEVICES tab
        #Quarantined Devices
        Write-Host "Retrieving mobile devices..." -ForegroundColor Cyan
        $script:DevicesResults = @()
        $script:QuarantinedDevices =  Get-MobileDevice -ResultSize Unlimited | Where-Object {$_.DeviceAccessState -eq "Quarantined"}

        if ($QuarantinedDevices) {
            foreach ($DeviceUser in $QuarantinedDevices) {
				$SplitIdentity = ($QuarantinedDevices.Identity).IndexOf("\")
				$DeviceUserName = ($QuarantinedDevices.Identity).Substring(0, $SplitIdentity)
                
				$DeviceProps = @{
                    Name              = $DeviceUserName
                    FriendlyName      = $QuarantinedDevices.FriendlyName
                    DeviceOS       = $QuarantinedDevices.DeviceOS
                    DeviceAccessState   = $QuarantinedDevices.DeviceAccessState
                    IsManaged           = $QuarantinedDevices.IsManaged
                    IsCompliant         = $QuarantinedDevices.IsCompliant
                    IsDisabled          = $QuarantinedDevices.IsDisabled
                    WhenCreated = $QuarantinedDevices.WhenCreated
                }
                $script:DevicesResults += New-Object PSObject -Property $DeviceProps
            }
            $DevicesResults | Select-Object Name, FriendlyName, DeviceOS, DeviceAccessState, IsManaged, IsCompliant, IsDisabled, WhenCreated
        }

        $NbrOfQuarantinedDevicesTextBlock.Text = ($DevicesResults).Count
        $NbrOfQuarantinedDevicesTextBlock.Foreground = "Red"
        $QuarantinedDevicesDataGrid.ItemsSource = ($DevicesResults)

		#Export Quarantined Devices
        $ExportQuarantinedButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveQuarantinedFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveQuarantinedFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveQuarantinedFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveQuarantinedFileDialog.SupportMultiDottedExtensions = $true
                $SaveQuarantinedFileDialog.FileName

                # Save the file...
                if ($SaveQuarantinedFileDialog.ShowDialog() -eq 'OK') {
                    $script:DevicesResults | Export-Csv $($SaveQuarantinedFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Device Access Rules   
        Write-Host "Retrieving active sync device access policies..." -ForegroundColor Cyan  
		$script:DeviceAccessRules = Get-ActiveSyncDeviceAccessRule
		$script:DeviceAccessRulesResults = @()
	
		foreach ($DeviceAccessRule in $DeviceAccessRules) {
                $DeviceAccessRuleProps = @{
                    Name = $DeviceAccessRule.Name
                    QueryString = $DeviceAccessRule.QueryString
                    Characteristic = $DeviceAccessRule.Characteristic
                    AccessLevel = $DeviceAccessRule.AccessLevel
                }
                $script:DeviceAccessRulesResults += New-Object PSObject -Property $DeviceAccessRuleProps
            }
            $DeviceAccessRulesResults | Select-Object Name, QueryString, Characteristic, AccessLevel
	
		$NbrOfDeviceAccessRulesTextBlock.Text = ($DeviceAccessRulesResults).Count
        $NbrOfDeviceAccessRulesTextBlock.Foreground = "Red"
        $DeviceAccessRulesDataGrid.ItemsSource = ($DeviceAccessRulesResults)

		#Export Device Access Rules
        $ExportDeviceAccessRulesButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveDeviceAccessRulesFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveDeviceAccessRulesFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveDeviceAccessRulesFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveDeviceAccessRulesFileDialog.SupportMultiDottedExtensions = $true
                $SaveDeviceAccessRulesFileDialog.FileName

                # Save the file...
                if ($SaveDeviceAccessRulesFileDialog.ShowDialog() -eq 'OK') {
                    $script:DeviceAccessRulesResults | Export-Csv $($SaveDeviceAccessRulesFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })


        #Device Mailbox Policies
        Write-Host "Retrieving mobile devices mailbox policy..." -ForegroundColor Cyan
        $script:DeviceMlbxPolicies = Get-MobileDeviceMailboxPolicy
		$script:DeviceMlbxPoliciesResults = @()
	
		foreach ($DeviceMlbxPolicy in $DeviceMlbxPolicies) {
                $DeviceMlbxPoliciesProps = @{
                    Name = $DeviceMlbxPolicy.Name
                    IsDefault = $DeviceMlbxPolicy.IsDefault
                    AllowSimplePassword = $DeviceMlbxPolicy.AllowSimplePassword
                    MinPasswordLength = $DeviceMlbxPolicy.MinPasswordLength
					MaxPasswordFailedAttempts = $DeviceMlbxPolicy.MaxPasswordFailedAttempts
					PasswordHistory = $DeviceMlbxPolicy.PasswordHistory
					MinPasswordComplexCharacters = $DeviceMlbxPolicy.MinPasswordComplexCharacters
					DeviceEncryptionEnabled = $DeviceMlbxPolicy.DeviceEncryptionEnabled
					RequireDeviceEncryption = $DeviceMlbxPolicy.RequireDeviceEncryption
					AllowCamera = $DeviceMlbxPolicy.AllowCamera

                }
                $script:DeviceMlbxPoliciesResults += New-Object PSObject -Property $DeviceMlbxPoliciesProps
            }
            $DeviceMlbxPoliciesResults | Select-Object Name, IsDefault, AllowSimplePassword, MinPasswordLength, MaxPasswordFailedAttempts, `
							 PasswordHistory, MinPasswordComplexCharacters, DeviceEncryptionEnabled, RequireDeviceEncryption, AllowCamera
	
		$NbrOfMobileDeviceMlbxPoliciesTextBlock.Text = ($DeviceMlbxPoliciesResults).Count
        $NbrOfMobileDeviceMlbxPoliciesTextBlock.Foreground = "Red"
        $MobileDeviceMlbxPoliciesDataGrid.ItemsSource = ($DeviceMlbxPoliciesResults)

		#Export Device Mailbox Policies
        $ExportDeviceMlbxPolicyButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveDeviceMlbxPolicyFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveDeviceMlbxPolicyFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveDeviceMlbxPolicyFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveDeviceMlbxPolicyFileDialog.SupportMultiDottedExtensions = $true
                $SaveDeviceMlbxPolicyFileDialog.FileName

                # Save the file...
                if ($SaveDeviceMlbxPolicyFileDialog.ShowDialog() -eq 'OK') {
                    $script:DeviceMlbxPoliciesResults | Export-Csv $($SaveDeviceMlbxPolicyFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

#endregion

#region SPO TAB

        #Site Collections tab
        Write-Host "Retrieving SPO sites..." -ForegroundColor Cyan
        $script:SPOSiteCollectionsResults = @()
        $script:SPOSiteCollectionsAll = Get-SPOSite -Limit All -IncludePersonalSite $true 
		$script:SPOSiteCollections = $SPOSiteCollectionsAll | Where-Object {$_.Url -notlike "*/personal*"}

		foreach($site in $SPOSiteCollections){
			$SCProps = @{
				Title = $site.Title
				Url = $site.Url
				StorageLimit = (($site.StorageQuota) / 1024).ToString("N")
				StorageUsed = (($site.StorageUsageCurrent) / 1024).ToString("N")
				Owner = $site.Owner
				SharingCapability = $site.SharingCapability
				LockState = $site.LockState
				Template = $site.Template
				ConditionalAccessPolicy = $site.ConditionalAccessPolicy
			}
			$script:SPOSiteCollectionsResults += New-Object PSObject -Property $SCProps
		}
		$SPOSiteCollectionsResults | Select-Object Title, Url, StorageLimit, StorageUsed, Owner, SharingCapability, LockState, Template, ConditionalAccessPolicy

		$NbrOfSiteColTextBlock.Text = ($SPOSiteCollectionsResults).Count
        $NbrOfSiteColTextBlock.Foreground = "Red"
        $NbrOfSiteColDataGrid.ItemsSource = ($SPOSiteCollectionsResults)

		#Export All Site Collections
        $ExportAllSCButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveAllSCFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveAllSCFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveAllSCFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveAllSCFileDialog.SupportMultiDottedExtensions = $true
                $SaveAllSCFileDialog.FileName

                # Save the file...
                if ($SaveAllSCFileDialog.ShowDialog() -eq 'OK') {
                    $script:SPOSiteCollections | `
                        Select-Object `
                            @{N='Title';E={$_.Title}}, `
                            @{N='Url';E={$_.Url}}, `
                            @{N='StorageLimit';E={(($_.StorageQuota) / 1024).ToString("N")}}, `
                            @{N='StorageUsed';E={(($_.StorageUsageCurrent) / 1024).ToString("N")}}, `
                            @{N='Owner';E={$_.Owner}}, `
                            @{N='SharingCapability';E={$_.SharingCapability}}, `
                            @{N='LockState';E={$_.LockState}}, `
                            @{N='Template';E={$_.Template}}, `
                            @{N='ConditionalAccessPolicy';E={$_.ConditionalAccessPolicy}} | `
                                Export-Csv $($SaveAllSCFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

        #SPO At A Glance section
        $SPOTenantData = Get-SPOTenant
		$SPOTotalOfSCTextBlock.Text = $SPOSiteCollectionsAll.Count
        $SPOTotalOfSCTextBlock.Foreground = "Green"
		$SPOTotalStorageTextBlock.Text = (($SPOTenantData.StorageQuota / 1024) / 1024).ToString("N") ## Number in TB
        $SPOTotalStorageTextBlock.Foreground = "Green"
		$SPOTotalStorageAllocatedTextBlock.Text = ($SPOTenantData.StorageQuotaAllocated / 1024).ToString("N") ## Number in GB
		$SPOTotalStorageAllocatedTextBlock.Foreground = "Green"
		$SPOTotalServerResourcesTextBlock.Text = $SPOTenantData.ResourceQuota
		$SPOTotalServerResourcesTextBlock.Foreground = "Green"
		$SPOTotalResourcesAllocatedTextBlock.Text = $SPOTenantData.ResourceQuotaAllocated
		$SPOTotalResourcesAllocatedTextBlock.Foreground = "Green"
		$SPOSharingCapabilityTextBlock.Text = $SPOTenantData.SharingCapability
		$SPOSharingCapabilityTextBlock.Foreground = "Green"
		$SPOExternalUsersInviteSameAcctTextBlock.Text = $SPOTenantData.RequireAcceptingAccountMatchInvitedAccount ## True or False
		$SPOExternalUsersInviteSameAcctTextBlock.Foreground = "Green"
		$ODFBforGuestEnabledTextBlock.Text = $SPOTenantData.OneDriveForGuestsEnabled ##True or False
		$ODFBforGuestEnabledTextBlock.Foreground = "Green"
		$SPODefaultSharingLinkTypeTextBlock.Text = $SPOTenantData.DefaultSharingLinkType
		$SPODefaultSharingLinkTypeTextBlock.Foreground = "Green"
		$SPOPreventExternalUsersFromResharingTextBlock.Text = $SPOTenantData.PreventExternalUsersFromResharing ##True or False
		$SPOPreventExternalUsersFromResharingTextBlock.Foreground = "Green"
		$FileAnonymousLinkTypeTextBlock.Text = $SPOTenantData.FileAnonymousLinkType
		$FileAnonymousLinkTypeTextBlock.Foreground = "Green"
		$FolderAnonymousLinkTypeTextBlock.Text = $SPOTenantData.FolderAnonymousLinkType
		$FolderAnonymousLinkTypeTextBlock.Foreground = "Green"
		$SPONotifyOwnersItemsResharedTextBlock.Text = $SPOTenantData.NotifyOwnersWhenItemsReshared ##True or False
		$SPONotifyOwnersItemsResharedTextBlock.Foreground = "Green"
		$SPODefaultLinkPermissionTextBlock.Text = $SPOTenantData.DefaultLinkPermission
		$SPODefaultLinkPermissionTextBlock.Foreground = "Green"


        #Hub Sites tab
        Write-Host "Retrieving SPO Hub sites..." -ForegroundColor Cyan
		$script:HubSitesResults = @()
		$script:SPOHubsites = Get-SPOHubSite

		foreach($Hubsite in $SPOHubsites){
			$HubsitesProps = @{
				Title = $Hubsite.Title
				Description = $Hubsite.Description
				SiteUrl = $Hubsite.SiteUrl
				
			}
			$script:HubSitesResults += New-Object PSObject -Property $HubsitesProps
		}
		$HubSitesResults | Select-Object Title, Description, SiteUrl

		$NbrOfHubSitesTextBlock.Text = ($HubSitesResults).Count
        $NbrOfHubSitesTextBlock.Foreground = "Red"
        $NbrOfHubSitesDataGrid.ItemsSource = ($HubSitesResults)

		#Export All Site Collections
        $ExportHubSitesButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveHubSitesFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveHubSitesFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveHubSitesFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveHubSitesFileDialog.SupportMultiDottedExtensions = $true
                $SaveHubSitesFileDialog.FileName

                # Save the file...
                if ($SaveHubSitesFileDialog.ShowDialog() -eq 'OK') {
                    $script:HubSitesResults | Export-Csv $($SaveHubSitesFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })

#endregion

#region ODFB TAB
	
		#Personal Sites tab
		$script:PersoSiteCollectionsResults = @()
		$script:PersoSiteCollections = $SPOSiteCollectionsAll | Where-Object {$_.Url -like "*/personal*"}

		foreach($PersoSite in $PersoSiteCollections){
			$PersoSCProps = @{
				Title = $PersoSite.Title
				StorageLimit = (($PersoSite.StorageQuota) / 1024).ToString("N")
				StorageUsed = (($PersoSite.StorageUsageCurrent) / 1024).ToString("N")
				Owner = $PersoSite.Owner
				SharingCapability = $PersoSite.SharingCapability
				LockState = $PersoSite.LockState
				Template = $PersoSite.Template
			}
			$script:PersoSiteCollectionsResults += New-Object PSObject -Property $PersoSCProps
		}
		$PersoSiteCollectionsResults | Select-Object Title, StorageLimit, StorageUsed, Owner, SharingCapability, LockState, Template

		$NbrOfPersoSiteColTextBlock.Text = ($PersoSiteCollectionsResults).Count
        $NbrOfPersoSiteColTextBlock.Foreground = "Red"
        $NbrOfPersoSiteColDataGrid.ItemsSource = ($PersoSiteCollectionsResults)

		#Export All Site Collections
        $ExportAllPersoSCButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveAllPersoSCFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveAllPersoSCFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveAllPersoSCFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveAllPersoSCFileDialog.SupportMultiDottedExtensions = $true
                $SaveAllPersoSCFileDialog.FileName

                # Save the file...
                if ($SaveAllPersoSCFileDialog.ShowDialog() -eq 'OK') {
                    $script:PersoSiteCollections | `
                        Where-Object {$_.Url -like "*/personal*"} | `
                            Select-Object `
                                @{N='Title';E={$_.Title}}, `
                                @{N='StorageLimit';E={(($_.StorageQuota) / 1024).ToString("N")}}, `
                                @{N='StorageUsed';E={(($_.StorageUsageCurrent) / 1024).ToString("N")}}, `
                                @{N='Owner';E={$_.Owner}}, `
                                @{N='SharingCapability';E={$_.SharingCapability}}, `
                                @{N='LockState';E={$_.LockState}}, `
                                @{N='Template';E={$_.Template}} | `
                                    Export-Csv $($SaveAllPersoSCFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })
#endregion

#region SKYPE & TEAMS TAB
        Write-Host "Retrieving Skype Users..." -ForegroundColor Cyan
		$script:SkypeUsersResults = @()
		$script:SkypeUsers = Get-CsOnlineUser

		foreach($SfboUser in $SkypeUsers){
			$SkypeUsersProps = @{
				DisplayName = $SfboUser.DisplayName
				UserPrincipalName = $SfboUser.UserPrincipalName
				Enabled = $SfboUser.Enabled
				UsageLocation = $SfboUser.UsageLocation
				SipProxyAddress = $SfboUser.SipProxyAddress
				ProxyAddresses = ($SfboUser.ProxyAddresses) -join "`n"
				InterpretedUserType = $SfboUser.InterpretedUserType
				HideFromAddressLists = $SfboUser.HideFromAddressLists
				EnterpriseVoiceEnabled = $SfboUser.EnterpriseVoiceEnabled
				EnabledForRichPresence = $SfboUser.EnabledForRichPresence
				ArchivingPolicy = $SfboUser.ArchivingPolicy
				TeamsMeetingPolicy = $SfboUser.TeamsMeetingPolicy
				TeamsCallingPolicy = $SfboUser.TeamsCallingPolicy
				TeamsMessagingPolicy = $SfboUser.TeamsMessagingPolicy
			}
			$script:SkypeUsersResults += New-Object PSObject -Property $SkypeUsersProps
		}
		$SkypeUsersResults | Select-Object DisplayName, UserPrincipalName, Enabled, UsageLocation, SipProxyAddress, ProxyAddresses, InterpretedUserType, HideFromAddressLists, EnterpriseVoiceEnabled, EnabledForRichPresence, ArchivingPolicy, TeamsMeetingPolicy, TeamsCallingPolicy, TeamsMessagingPolicy

		$NbrOfSkypeUsersTextBlock.Text = ($SkypeUsersResults).Count
        $NbrOfSkypeUsersTextBlock.Foreground = "Red"
        $NbrOfSkypeUsersDataGrid.ItemsSource = ($SkypeUsersResults)

		#Export Skype Users
        $ExportSkypeUsersButton.add_Click( {
                # Show the "Save As" dialog window and define a default location (on the Desktop...)
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
                $SaveSkypeUsersFileDialog = New-Object System.Windows.Forms.SaveFileDialog
                $SaveSkypeUsersFileDialog.InitialDirectory = "C:\$env:USERNAME\Desktop\"
                $SaveSkypeUsersFileDialog.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|Excel Worksheet (*.xls)|*.xls|All Files (*.*)|*.*"
                $SaveSkypeUsersFileDialog.SupportMultiDottedExtensions = $true
                $SaveSkypeUsersFileDialog.FileName

                # Save the file...
                if ($SaveSkypeUsersFileDialog.ShowDialog() -eq 'OK') {
                    $script:SkypeUsersResults | Export-Csv $($SaveSkypeUsersFileDialog.filename) -NoTypeInformation -Encoding UTF8
                }
            })
    }) #end of $ConnectButton.Add_Click

#endregion


#region CLICK DISCONNECT BUTTON
###############################
$DisconnectButton.Add_Click( {


		#Disconnect from EXO and Compliance Center
		Write-Host "Disconnected from Exchange Online" -ForegroundColor DarkGreen
		Write-Host "Disconnected from Skype for Business" -ForegroundColor DarkGreen
		Write-Host "Disconnected from Compliance Center" -ForegroundColor DarkGreen
		Get-PSSession | Remove-PSSession

        #Disconnect from SharePoint Online
        Disconnect-SPOService
        Write-Host "Disconnected from SharePoint Online" -ForegroundColor DarkGreen

        #Clear all boxes & tabs
        $AdminTextbox.Clear()
        $AdminTextbox.Background = "#FFFFFFFF"
        $AdminTextbox.IsEnabled = $true
        $AdminPwdTextbox.Clear()
        $AdminPwdTextbox.Background = "#FFFFFFFF"
        $AdminPwdTextbox.IsEnabled = $true
        $TenantTextBlock.Text = ""
        $OrgNameTextBlock.Text = ""
        $CountryTextBlock.Text = ""
        $TechContactTextBlock.Text = ""
        $ContactPhoneNbrTextBlock.Text = ""
        $DirSyncEnabledTextBlock.Text = ""
        $PwdSyncEnabledTextBlock.Text = ""
        $LastDirSyncTimeTextBlock.Text = ""
        $LastPwdSyncTimeTextBlock.Text = ""
        $FeaturesReleaseTextBlock.Text = ""
        $TotalNbrPlansTextBlock.Text = ""
        $TotalLicensesTextBlock.Text = ""
        $TotalAssignedLicensesTextBlock.Text = ""

        #Tenant Tab
        $NbrOfDomainsTextBlock.Text = ""
        $DomainsDataGrid.ItemsSource = ""
        $NbrOfPlansTextBlock.Text = ""
        $PlansDataGrid.ItemsSource = ""
        $NbrOfGATextBlock.Text = ""
        $GADataGrid.ItemsSource = ""
        $NbrOfUsersTextBlock.Text = ""
        $NbrOfSyncedUsersTextBlock.Text = ""
        $NbrOfCloudUsersTextBlock.Text = ""
        $NbrOfBlockedUsersTextBlock.Text = ""
        $NbrOfBlockedAndLicensedUsersTextBlock.Text = ""
        $NbrOfContactsTextBlock.Text = ""
        $NbrOfGuestsTextBlock.Text = ""
        $NbrOfGroupsTextBlock.Text = ""
        $NbrOfShdMlbxTtextBlock.Text = ""
        $NbrofRoomsTextBlock.Text = ""
        $NbrOfEquipTextBlock.Text = ""

        #Exo Tabs
        $MlbxAndResourcesTotalTextBlock.Text = ""
        $MlbxAndResourcesDataGrid.ItemsSource = ""
        $GroupsTextBlock.Text = ""
        $GroupsDataGrid.ItemsSource = ""
        $AllContactsTextBlock.Text = ""
        $ContactsDataGrid.ItemsSource = ""
        $AdminRolesDataGrid.ItemsSource = ""
        $NbrOfAdminRolesTextBlock.Text = ""
        $NbrOfUserRolesTextBlock.Text = ""
        $UserRolesDataGrid.ItemsSource = ""
        $NbrOfOWAPoliciesTextBlock.Text = ""
        $OWAPoliciesDataGrid.ItemsSource = ""
        $NbrOfMalwareFilterTextBlock.Text = ""
        $MalwareFilterDataGrid.ItemsSource = ""
        $NbrOfConnectionFiltersTextBlock.Text = ""
        $ConnectionFilterDataGrid.ItemsSource = ""
        $NbrOfSpamFiltersTextBlock.Text = ""
        $SpamFilterDataGrid.ItemsSource = ""
		$NbrOfDkimTextBlock.Text = ""
        $DkimDataGrid.ItemsSource = ""
        $NbrOfRulesTextBlock.Text = ""
        $RulesDataGrid.ItemsSource = ""
        $NbrOfAcceptedDomainsTextBlock.Text = ""
        $AcceptedDomainsDataGrid.ItemsSource = ""
        $NbrOfRemoteDomainsTextBlock.Text = ""
        $RemoteDomainsDataGrid.ItemsSource = ""
        $NbrOfQuarantinedDevicesTextBlock.Text = ""
        $QuarantinedDevicesDataGrid.ItemsSource = ""
        $NbrOfDeviceAccessRulesTextBlock.Text = ""
        $DeviceAccessRulesDataGrid.ItemsSource = ""
        $NbrOfMobileDeviceMlbxPoliciesTextBlock.Text = ""
        $MobileDeviceMlbxPoliciesDataGrid.ItemsSource = ""

		#Spo Tabs
		$NbrOfSiteColTextBlock.Text = ""
        $NbrOfSiteColDataGrid.ItemsSource = ""
		$NbrOfHubSitesTextBlock.Text = ""
        $NbrOfHubSitesDataGrid.ItemsSource = ""
		$NbrOfPersoSiteColTextBlock.Text = ""
        $NbrOfPersoSiteColDataGrid.ItemsSource = ""
		$SPOTotalOfSCTextBlock.Text = ""
		$SPOTotalStorageTextBlock.Text = ""
		$SPOTotalStorageAllocatedTextBlock.Text = ""
		$SPOTotalServerResourcesTextBlock.Text = ""
		$SPOTotalResourcesAllocatedTextBlock.Text = ""
		$SPOSharingCapabilityTextBlock.Text = ""
		$SPOExternalUsersInviteSameAcctTextBlock.Text = ""
		$ODFBforGuestEnabledTextBlock.Text = ""
		$SPODefaultSharingLinkTypeTextBlock.Text = ""
		$SPOPreventExternalUsersFromResharingTextBlock.Text = ""
		$FileAnonymousLinkTypeTextBlock.Text = ""
		$FolderAnonymousLinkTypeTextBlock.Text = "" 
		$SPONotifyOwnersItemsResharedTextBlock.Text = ""
		$SPODefaultLinkPermissionTextBlock.Text = ""

		#Skype & Teams
		$NbrOfSkypeUsersTextBlock.Text = ""
		$NbrOfSkypeUsersDataGrid.ItemsSource = ""

        #Change the status of the "Connect" button & "Disconnect" button
        $ConnectButton.Background = $null
        $ConnectButton.Foreground = "Black"
        $ConnectButton.Content = "Connect"
        $ConnectButton.IsHitTestVisible = $true

        #Disconnect button becomes disabled again...
        $DisconnectButton.IsEnabled = $false

        #Pop-up window to confirm services disconnected
        $ConfirmationParams = @{
            Title             = "Confirmation"
			TitleTextForeground = "White"
            TitleBackground   = "Green"
            TitleFontSize     = 20
            Content           = "You are now disconnected from Office 365 services"
            ContentFontWeight = "Medium"
            ContentFontSize   = 14
            BorderThickness   = 0.5
        }
        New-WPFMessageBox @ConfirmationParams
    })

#endregion

#Show the GUI
$Window.ShowDialog() | Out-Null


