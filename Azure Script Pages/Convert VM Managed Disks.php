<!DOCTYPE html>
<?php include '../Template.php'; ?>
<link rel="stylesheet" href="../Styles/ScriptForm-Stylesheet.css">

<!-- Banner -->
<div class="page-banner">
  <div class="container text-center">
    <h1>Azure Convert Virtual Machine to Mangaged Disks</h1>      
    <p>Please complete the below fields to run the PowerShell script</p>
  </div>
</div>



<?php
// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <div class="script-form" >
    <form class="script-form" name="testForm" id="testForm" action="Convert VM Managed Disks.php" method="post" />
        Username*:  <input type="text" name="username" id="username" maxlength="40" value="<?php echo 'username@company.com'; ?>" /><br />	
	Password*:  <input type="password" name="password" id="password" /><br />       		
	Azure Subscription ID*: <input type="text" name="subid" id="subid" minlength="36" maxlength="36" value="<?php echo 'abcdefgh-1234-5678-abcd-123456789abc'; ?>" /><br />	
        Resource Group*:  <input type="text" name="rgName" id="rgName" /><br />
        Virtual Machine Name*:  <input type="text" name="vmtName" id="vmName" /><br />
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    </div>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["username"])) && (!empty($_POST["password"])) && (!empty($_POST["subid"])) && (!empty($_POST["rgName"])) && (!empty($_POST["vmName"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $username = $_POST["username"];
    $password = $_POST["password"];
    $subid = $_POST["subid"];
    $rgName = $_POST["rgName"];
    $vmName = $_POST["vmName"];
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "../Azure-Scripts/Convert-VM-Managed-Disks.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -username '$username' -password '$password' -subid '$subid' -rgName '$rgName' -$vmName '$vmName' -Time '$Time'");
    
    ?>
    <div class="script-output" >
        <p><?= $query ?></p>    
    </div>    
    <?php 
    
    // Button to Download Log File
    $log = "../Azure-Script-Logs/" . $user[0] . $subid . "-HubLog.txt";
    file_put_contents($log, $query);
    
    ?>
    <form method="get" action="../Azure-Script-Logs/<?= $log ?>" >
        <input type="submit" name="download-log" value="Download Log" />
    </form>
    <?php             
}

//Else the user hit submit without all required fields being filled out:
else
{
    ?>
    <div class="no-fields" >
        <p> Sorry, you did not complete all required fields. Please go back and repeat again. </p>    
    </div> 
    <?php
}
?>
    
</body>
</html>