<?php

require_once './DbOperation.php';

$response = array();

	if ($_SERVER['REQUEST_METHOD']=='POST'){
		if(
				isset($_POST['Email']) and  
					isset($_POST['passwd'])) {

					$db = new DbOperation();
					$result = $db->login($_POST['Email'],$_POST['passwd']);
					if($result != NULL){
						if(count($result)===1){
							//if(password_verify($_POST['passwd'],$result[0]) )
							if(md5($_POST['passwd']) == $result[0] )
							{
								$response['error']=false;
								$response['message']="logged successfully";
								$response['Email']=$_POST['Email'];
							}
							else{
								$response['error']=true;
								$response['message']="wrong password!!";
								//pour test
								$response['passwordSent']=$_POST['passwd'];
								$response['passwordStored']=$result[œ0];

							}
						}else{
							$response['error']=true;
							$i=0;
							while( $response['error'] and $i < count($result) ){
								if( password_verify($_POST['passwd'],$result[$i]) ){
									$response['error']=false;
									$response['message']="logged successfully"; 
									$response['Email']=$result['email'];
								}
							}
							$response['message']="Some error occured please try again";
							$response['Email']=$_POST['Email'];
							$response['passwordSent']=$_POST['passwd'];
						}
					}else{
						$response['error']=true;
						$response['message']="non trouvé!";
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