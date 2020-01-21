<?php

require_once './DbOperation.php';

$response = array();

	if ($_SERVER['REQUEST_METHOD']=='POST'){
		if(		isset($_POST['Email']) and  
				isset($_POST['passwd']) and
				isset($_POST['Lname']) and
				isset($_POST['Fname']) and
				isset($_POST['gender']) and
				isset($_POST['age']) and 
				isset($_POST['role']) 
			){
				$db = new DbOperation();
				if($db->createAccount(
					$_POST['Email'],
					$_POST['passwd'],
					$_POST['Lname'],
					$_POST['Fname'],
					$_POST['gender'],
					$_POST['age'],
					$_POST['role']
				)){
					$response['error']=false;
					$response['message']="Account created successfully"; 
				}else{
					$response['error']=true;
					$response['message']="Some error occured please try again"; 
				}
			}else{
				$response['error']=true;
				$response['message']="Required fields are missing";
			} 
		}else{
			$response['error']=true;
			$response['message']="Invalid Request";
		}

	echo json_encode($response);

?>