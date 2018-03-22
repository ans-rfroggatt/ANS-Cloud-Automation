<!DOCTYPE html>
<?php include '../Template.php'; ?>
<link rel="stylesheet" href="../Styles/ScriptForm-Stylesheet.css">

<!-- Banner -->
<div class="page-banner">
  <div class="container text-center">
    <h1>Azure HUB Licensing Information</h1>      
    <p>Please complete the below fields to run the PowerShell script</p>
  </div>
</div>



<?php
// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <div class="script-form" >
    <form class="script-form" name="testForm" id="testForm" action="Azure HUB Licensing Information.php" method="post" />
        Username:  <input type="text" name="username" id="username" maxlength="40" value="<?php echo 'username@company.com'; ?>" /><br />	
	Password:  <input type="password" name="password" id="password" /><br />       		
	Azure Subscription ID: <input type="text" name="subid" id="subid" minlength="36" maxlength="36" value="<?php echo 'abcdefgh-1234-5678-abcd-123456789abc'; ?>" /><br />	
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    </div>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["username"])) && (!empty($_POST["password"])) && (!empty($_POST["subid"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $username = $_POST["username"];
    $password = $_POST["password"];
    $subid = $_POST["subid"];
    // Best practice tip: We run out POST data through a custom regex function to clean any unwanted characters, e.g.:
    // $username = cleanData($_POST["username"]);
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "../Azure-Scripts/Azure-HUB-Licensing-Information.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -username '$username' -password '$password' -subId '$subid'");
    
    ?>
    <div class="script-output" >
        <p><?= $query ?></p>    
    </div>    
    <?php 
    
    
    // Button to download CSV
    $user = explode('@',$username);
    $csv = $user[0] . $subid . "-HubCSV.csv";
           
    ?>
    <form method="get" action="../Azure Script Exports/<?= $csv ?>" >
        <input type="submit" name="download-csv" value="Download CSV" />
    </form>
    <?php 
    
    // Button to Download Log File
    $log = "../Azure Script Logs/" . $user[0] . $subid . "-HubLog.txt";
    file_put_contents($log, $query);
    
    ?>
    <form method="get" action="../Azure Script Logs/<?= $log ?>" >
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