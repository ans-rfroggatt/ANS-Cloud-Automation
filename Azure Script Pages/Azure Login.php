<!DOCTYPE html>
<?php include '../Template.php'; ?>
<link rel="stylesheet" href="../Styles/ScriptForm-Stylesheet.css">

<!-- Banner -->
<div class="page-banner">
  <div class="container text-center">
    <h1>Azure Login Test</h1>      
    <p>Please complete the below fields to run the PowerShell script</p>
  </div>
</div>



<?php
// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <div class="script-form" >
    <form class="script-form" name="testForm" id="testForm" action="Azure Login.php" method="post" /> 		
	Azure Subscription ID*: <input type="text" name="subid" id="subid" minlength="36" maxlength="36" value="<?php echo 'abcdefgh-1234-5678-abcd-123456789abc'; ?>" /><br />	
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    </div>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["subid"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $subid = $_POST["subid"];
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "../Azure-Scripts/Azure-Login.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -subid '$subid'");
    
    ?>
    <div class="script-output" >
        <p><?= $query ?></p>    
    </div>    
    <?php 
    
    // Button to download CSV
    $csv = $subid . "-HubCSV.csv";
           
    ?>
    <form method="get" action="../Azure-Script-Exports/<?= $csv ?>" >
        <input type="submit" name="download-csv" value="Download CSV" />
    </form>
    <?php 
    
    // Button to Download Log File
    $log = "../Azure-Script-Logs/" . $subid . "-HubLog.txt";
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