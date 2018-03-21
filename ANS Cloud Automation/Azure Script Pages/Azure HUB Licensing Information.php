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


<div class="script-form" >
<?php

// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <form class="script-form" name="testForm" id="testForm" action="Azure HUB Licensing Information.php" method="post" />
        Username:  <input type="text" name="username" id="username" maxlength="30" value="<?php echo 'FirstName.LastName@Company.com'; ?>" /><br />	
	Password:  <input type="password" name="password" id="password" /><br />       		
	Azure Subscription ID: <input type="text" name="subid" id="subid" minlength="36" maxlength="36" /><br />	
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["username" & "password" & "subid"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $username = $_POST["username"];
    $password = $_POST["password"];
    $subid = $_POST["subid"];
    // Best practice tip: We run out POST data through a custom regex function to clean any unwanted characters, e.g.:
    // $username = cleanData($_POST["username"]);
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "/ANS Cloud Automation/Azure Scripts/Azure HUB Licensing Information.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -username '$username' -password '$password' -subId '$subid'");
    echo $query;    
}

//Else the user hit submit without all required fields being filled out:
else 
{
    echo "Sorry, you did not complete all required fields. Please go back and repeat again.";
}
?>
    
</div>
</body>
</html>