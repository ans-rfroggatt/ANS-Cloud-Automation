<!DOCTYPE html>
<?php include '../Template.php'; ?>
<link rel="stylesheet" href="../Styles/ScriptForm-Stylesheet.css">

<!-- Banner -->
<div class="page-banner">
  <div class="container text-center">
    <h1>Azure Zombie VHDs (ARM)</h1>      
    <p>
        Please complete the below fields to run the PowerShell script <br />
    </p>
    <p>
        There are 3 options for using this script: <br />
        1. Filter by storage account, specifying the Resource Group and Storage Account name - quick <br />
        2. Filter using a match in a Storage Account name - moderate <br />
        3. No filter. Gets all VHDs in all storage accounts in the subscription - slow <br />
    </p>
  </div>
</div>



<?php
// If there was no submit variable passed to the script (i.e. user has visited the page without clicking submit), display the form:
if(!isset($_POST["submit"]))
{
    ?>
    <div class="script-form" >
        <form class="script-form" name="testForm" id="testForm" action="Azure Zombie VHDs (ARM).php" method="post" />
        Username*:  <input type="text" name="username" id="username" maxlength="40" value="<?php echo 'username@company.com'; ?>" /><br />	
	Password*:  <input type="password" name="password" id="password" /><br />       		
	Azure Subscription ID*: <input type="text" name="subid" id="subid" minlength="36" maxlength="36" value="<?php echo 'abcdefgh-1234-5678-abcd-123456789abc'; ?>" /><br />
        Script Option*:  <input type="text" name="option" id="option" maxlength="1" /><br />	
	Resource Group:  <input type="text" name="resourcegroup" id="resourcegroup" value="<?php echo 'Resource Group Name if using option 1'; ?>" /><br />       		
	Storage Account Name: <input type="text" name="StorageAccountName" id="StorageAccountName" maxlength="24" value="<?php echo 'Storage Account Name if using option 1'; ?>" /><br />
        Search String: <input type="text" name="searchstring " id="searchstring" value="<?php echo 'Search String if using option 2'; ?>" /><br />
        <input type="submit" name="submit" id="submit" value="Submit" />
    </form>
    </div>
    <?php    
}
// Else if submit was pressed, check if all of the required variables have a value:
elseif((isset($_POST["submit"])) && (!empty($_POST["username"])) && (!empty($_POST["password"])) && (!empty($_POST["subid"])) && (!empty($_POST["option"])))
{
    // Get the variables submitted by POST in order to pass them to the PowerShell script:
    $username = $_POST["username"];
    $password = $_POST["password"];
    $subid = $_POST["subid"];
    $option = $_POST["option"];
    $resourcegroup = $_POST["resourcegroup"];
    $StorageAccountName = $_POST["StorageAccountName"];
    $searchstring = $_POST["searchstring"];
         
    // Path to the PowerShell script. Remember double backslashes:
    $psScriptPath = "../Azure-Scripts/Azure-Zombie-VHDs-ARM.ps1";
 
    // Execute the PowerShell script, passing the parameters:
    $query = shell_exec("powershell -command $psScriptPath -username '$username' -password '$password' -subId '$subid' -option '$option' -resourcegroup $resourcegroup -StorageAccountName $StorageAccountName -searchstring $searchstring");
    
    ?>
    <div class="script-output" >
        <p><?= $query ?></p>    
    </div>    
    <?php 
    
    // Button to download CSV
    $user = explode('@',$username);
    $csv = $user[0] . $subid . "-ARMVHD-CSV.csv";
           
    ?>
    <form method="get" action="../Azure-Script-Exports/<?= $csv ?>" >
        <input type="submit" name="download-csv" value="Download CSV" />
    </form>
    <?php 
    
    // Button to Download Log File
    $log = "../Azure-Script-Logs/" . $user[0] . $subid . "-ARMVHD-Log.txt";
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