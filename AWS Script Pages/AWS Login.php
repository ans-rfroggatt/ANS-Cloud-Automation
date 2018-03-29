<!DOCTYPE html>
<?php include '../Template.php'; ?>
<link rel="stylesheet" href="../Styles/ScriptForm-Stylesheet.css">

<!-- Banner -->
<div class="page-banner">
  <div class="container text-center">
    <h1>AWS Login Test</h1>      
    <p>Please complete the below fields to run the PowerShell script</p>
  </div>
</div>



<?php
// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <div class = "github">
    <a href="https://raw.githubusercontent.com/ans-rfroggatt/ANS-Cloud-Automation/master/AWS-Scripts/AWS-Login.ps1">
        <img  class="github-logo" src="/Images/GitHub.png" >
    </a>
    </div> 

    <div class="script-form" >
        <form class="script-form" name="testForm" id="testForm" action="AWS Login.php" method="post" />
        Customer*:  <input type="text" name="Customer" id="Customer" maxlength="40" /><br />	
	AccessKey*:  <input type="password" name="AccessKey" id="AccessKey" /><br />       		
	SecretKey*:  <input type="password" name="SecretKey" id="SecretKey" /><br />	
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    </div>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["Customer"])) && (!empty($_POST["AccessKey"])) && (!empty($_POST["SecretKey"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $Customer = $_POST["Customer"];
    $AccessKey = $_POST["AccessKey"];
    $SecretKey = $_POST["SecretKey"];
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "../AWS-Scripts/AWS-Login.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -AccessKey '$AccessKey' -SecretKey '$SecretKey'");
    
    ?>
    <div class="script-output" >
        <p><?= $query ?></p>    
    </div>    
    <?php 
     
    
    // Button to Download Log File
    $log = "../AWS-Script-Logs/" . $Customer . "-Log.txt";
    file_put_contents($log, $query);
    
    ?>
    <form method="get" action="../AWS-Script-Logs/<?= $log ?>" >
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