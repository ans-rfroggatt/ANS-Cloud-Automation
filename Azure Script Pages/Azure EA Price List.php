<!DOCTYPE html>
<?php include '../Template.php'; ?>
<link rel="stylesheet" href="../Styles/ScriptForm-Stylesheet.css">

<!-- Banner -->
<div class="page-banner">
  <div class="container text-center">
    <h1>Azure EA Price List</h1>      
    <p>Please complete the below fields to run the PowerShell script</p>
  </div>
</div>



<?php
// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <div class = "github">
    <a href="https://raw.githubusercontent.com/ans-rfroggatt/ANS-Cloud-Automation/master/Azure-Scripts/Get-EA-PriceList.ps1">
        <img  class="github-logo" src="/Images/GitHub.png" >
    </a>
    </div> 

    <div class="script-form" >
        <form class="script-form" name="testForm" id="testForm" action="Azure EA Price List.php" method="post" />
        Enrollment ID*:  <input type="text" name="EnrollmentID" id="EnrollmentID" maxlength="15" /><br />	
	EA API Key*:  <input type="password" name="APIKey" id="APIKey"  /><br />	     		
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    </div>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["EnrollmentID"])) && (!empty($_POST["APIKey"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $EnrollmentID = $_POST["EnrollmentID"];
    $APIKey = $_POST["APIKey"];
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "../Azure-Scripts/Get-EA-PriceList.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -EnrollmentID '$EnrollmentID' -APIKey '$APIKey'");
    
    ?>
    <div class="script-output" >
        <p><?= $query ?></p>    
    </div>    
    <?php 
    
    // Button to download CSV
    $csv = "$EnrollmentID-PriceList.csv";
           
    ?>
    <form method="get" action="../Azure-Script-Exports/<?= $csv ?>" >
        <input type="submit" name="download-csv" value="Download CSV" />
    </form>
    <?php 
    
    // Button to Download Log File
    $log = "../Azure-Script-Logs/PriceListLog.txt";
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