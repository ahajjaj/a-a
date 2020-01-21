<?php

     class DbOperation{

     	private $con;
          /*
          const student=0;
          const parent=1;
          const teacher=2;
          */
     	function __construct(){

     		require_once dirname(__FILE__).'/DbConnect.php';

     		$db = new DbConnect();

     		$this->con = $db->connect();
          }
     		/*CRUD -> C -> CREAT*/





          function createAccount($email, $password,$lname,$fname,$gender,$age,$role){
               $password = md5($password);
               $ageI=(int)$age;
               $role=(int)$role;
               $idAccount=rand();
               $idUser=rand();
               $stmt1 = $this->con->prepare('INSERT INTO account (Id_account,passwd) VALUES (?,?)');
               $stmt2 = $this->con->prepare('INSERT INTO user (Id_user,Email,Lname,gender,FName,age) VALUES
                    (?,?,?,?,?,?)');
               switch ($role) {
                    case 0:
                    {
                         $table="student";
                         $id="Id_student";
                    }break;
                    case 1:
                    {
                         $table="parent";
                         $id="Id_parent";

                    }break;
                    case 2:
                    {
                         $table="teacher";
                         $id="Id_teacher";                         
                    }
               }
               $stmt3 = $this->con->prepare('INSERT INTO '.$table.' ('.$id.',Email,Lname,gender,FName,age) VALUES
                    (?,?,?,?,?,?)');    
               $stmt1->bind_param("is",$idAccount,$password);
               $stmt2->bind_param("issssi",$idUser,$email,$lname,$gender,$fname,$ageI);
               $stmt3->bind_param("issssi",$idUser,$email,$lname,$gender,$fname,$ageI);
               if($stmt1->execute() and $stmt2->execute() and $stmt3->execute()){
                    
                    $stmt = $this->con->prepare('INSERT INTO has_an (Id_USER, Id_ACCOUNT) VALUES
                    (?,?)');
                    $stmt->bind_param("ii",$idUser,$idAccount);
                    if($stmt->execute()){
                         return true;
                    }else{
                         return false;
                    }
               }else{
                     return false;
               }

          }     

		function login($email, $password){

               $sqlRequest= 'SELECT user.Id_user,user.Email,account.passwd,account.Id_account FROM has_an,account,user  
                    WHERE has_an.id_USER=user.Id_user
                         and 
                         account.Id_account=has_an.Id_ACCOUNT 
                         and
                         user.Email =?';         
               $finalRequest = $this->con->prepare($sqlRequest);

               $finalRequest->bind_param('s',$email);
               if($finalRequest->execute()){

               //traitement à faire en cas ou la requête s'éxécute
                    $rows=$finalRequest->get_result(); 
                    $results=array();
                    while ($row = $rows->fetch_assoc()) {
                          array_push($results,$row["passwd"]);
                    }
                    return $results;    
               }else{
                    return NULL;
               }
          }
	}
?>  