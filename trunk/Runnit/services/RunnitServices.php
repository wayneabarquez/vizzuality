<?php

class RunnitServices {
	
	function __construct() {
	    $this->conn = pg_connect ("host=67.23.44.117 dbname=runnit user=postgres password=postgres");
		
	}
    
    public function login($email,$pass) {

        $email=pg_escape_string($email);
        $pass=pg_escape_string($pass);
        
        // create page view database table
        $sql = "SELECT * FROM users WHERE (email='$email' AND pass='$pass') OR (username='$email' AND pass='$pass')";        
        $result = pg_query($this->conn, $sql);
        if(pg_num_rows($result)<1) {
            $_SESSION['logged']=false;
            throw new Exception("user not logged in");
        } else {
 
            $_SESSION['logged']=true;
            $res=pg_fetch_assoc($result);
            $_SESSION['user']=$res;
    	    return $res;           
        }
	}
	
	public function getComments($on_id,$table) {
	    $table=pg_escape_string($table);
	    
	    $sql="SELECT c.id,commenttext,c.created_when,username,u.id as user_id from comments as c INNER JOIN users as u ON c.user_fk=u.id  WHERE on_id=$on_id AND on_table='$table'";	    

	    //Check if the user has avatars or not
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    if($result) {
    	    foreach ($result as &$comment) {
    	        $targetPicture=getcwd()."/../media/avatar/".$comment['user_id'].".jpg";
                if (file_exists($targetPicture)) {
                    $comment['avatar'] = $comment['user_id'].".jpg";
                } else {
                    //no image for the run, select random
                    $comment['avatar'] = "0.jpg";
                }
            }	        
	    }	    
	    
	    return $result; 
	     
	}
	
	
	public function isUsernameFree($username) {
	    $username=pg_escape_string($username);
	    $sql="SELECT id from users WHERE username='$username'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        return false;
	    }
	       
	    return true;
	}
	
	public function registerUser($username,$completename,$email,$password) {
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    
	    if(strlen($username)<5) {
	        throw new Exception('El nombre de usuario debe ser mayor de 5 caracteres.',101);
	    }
	    
	    if(strlen($password)<5) {
	        throw new Exception('El password debe ser mayor de 5 caracteres.',102);
	    }
	    if(strlen($email)<5) {
	        throw new Exception('Tu email es incorrecto.',103);
	    }	 
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE username='$username'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        throw new Exception('Ese nombre de usuario ya esta registrado.',104);
	    }	    
	    	     
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE email='$email'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        throw new Exception('Email ya registrado.',105);
	    }	     
	    
	    $sql="INSERT INTO users(username,pass,completename,email) VALUES('$username','$password','$completename','$email')";
		$result=pg_query($this->conn, $sql);   
	    
	    //get last ID
	    $sql = "SELECT currval('users_id_seq') AS last_value";
	    $result=pg_query($this->conn, $sql);
	    $res=pg_fetch_assoc($result);
	    
	    
	    $user=array();
	    $user['id']=$res['last_value'];
	    $user['username']=$username;
	    $user['completename']=$completename;
	    $user['email']=$email;
	    return $user;
	}
	
	public function updateUser($username,$completename,$email,$password,$locality,$radio) {
	    if (!$_SESSION['logged'] or $_SESSION['user']['username']!=$username) {
	        throw new Exception("user not logged in");
	    }
	    
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    $locality=pg_escape_string($locality);
	    

	    $sql="UPDATE users SET completename='$completename', email='$email'";
	    if(strlen($password)>4) {
	        $sql.=",pass='$password'";
	    }
	    
	    
	    $sql.=",locality='$locality'";   
	    $sql.=",radius_interest=$radio";
	    $sql.=" WHERE username='$username'";
        $result= pg_query($this->conn, $sql);
        return null;
	    
	     
    }

	public function getRunsForBBox($north,$south,$east,$west) {
		$sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and start_point && ST_SetSRID(ST_MakeBox2D(ST_Point($west, $south), ST_Point($east ,$north)),4326)";
	}
	
	public function getAllRuns() {
		if(!$week) {
			$week=0;
		}
		$sql="select x(start_point) as lon, y(start_point) as lat,r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now()";
		return pg_fetch_all(pg_query($this->conn, $sql));  
	}	
	
	public function logout() {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    session_destroy();
	}	    
	
	public function addComment($userId,$comment,$id,$table) {
	    if (!$_SESSION['logged'] or $_SESSION['user']['id']!=$userId) {
	        throw new Exception("user not logged in");
	    }
	    
	    $comment=pg_escape_string($comment);
	    $table=pg_escape_string($table);
	    
	    $sql="INSERT INTO comments(user_fk,commenttext,on_table,on_id) VALUES('$user_fk','$comment','$table','$id')";
        $result= pg_query($this->conn, $sql);
        return null;
	    
	}
	
	public function getAllRunsBBox() {
		$sql="select xmax(extent(start_point)) as east,ymax(extent(start_point)) as north, xmin(extent(start_point)) as west, ymin(extent(start_point)) as south   from run as r where r.event_date > now()";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_assoc($result);		
	}
	
	
	public function getLastUsersInscribedToRuns($runId=0) {
	    if($runId==0) {
    	    $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id order by ur.id DESC limit 3";	        
	    } else {
	        $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id where ur.run_fk= $runId order by ur.id DESC limit 3";
	    }
	    //Check if the user has avatars or not
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    if($result) {
    	    foreach ($result as &$user) {
    	        $targetPicture=getcwd()."/../media/avatar/".$user['user_id'].".jpg";
                if (file_exists($targetPicture)) {
                    $user['avatar'] = $user['user_id'].".jpg";
                } else {
                    //no image for the run, select random
                    $user['avatar'] = "0.jpg";
                }
            }	        
	    }

	    
	    return $result;	    
	    
	}	
	
	public function getHighlightedRun() {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() order by is_displayed_in_home ASC LIMIT 1";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_assoc($result);
	}
	
	public function searchRuns($q,$max,$min,$offset) {
        $q=pg_escape_string($q);
        if(!$offset) {
            $offset=0;
        }
        
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r  left join province as p on r.province_fk=p.id where r.event_date > now() AND (r.name ilike '%$q%' or event_location ilike '%$q%')";
	    if($min>0) {
	        $sql.=" AND distance_meters >= $min";
	    }
	    if($max>0) {
	        $sql.=" AND distance_meters <= $max";	        
	    }
	    
	    $sqlForCount="SELECT COUNT(id) as num_results FROM ($sql) as s";
	    
	    $sql.=" order by event_date ASC limit 20 offset $offset";
        
        $results=array();
        $results['data'] = pg_fetch_all(pg_query($this->conn, $sql));
        
        if($results['data']) {
            $resultCount=pg_query($this->conn, $sqlForCount);
    	    $resultCount=pg_fetch_assoc($resultCount);
            $results['count'] =(int)$resultCount['num_results'];            
        } else {
            $results['count'] =0;  
        }

        
        return $results;  
	}
	
	public function getNextRuns() {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() order by event_date ASC limit 4";
	    
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    foreach ($result as &$run) {
	        $targetPicture=getcwd()."/../media/run/".$run['id']."_small.jpg";
            if (file_exists($targetPicture)) {
                $run['thumbnail'] = $run['id']."_small.jpg";
            } else {
                //no image for the run, select random
                $run['thumbnail'] = "generic/".rand(1,4)."_small.jpg";
            }
        }
	    
	    return $result;   
	}
	
	public function getProvinces() {
	    $sql="select * from province ORDER BY id ASC";
	    return pg_fetch_all(pg_query($this->conn, $sql));	    
	}
	
	
	public function createNewRun($name,$event_location,$distance_meters,$distance_text,$event_date,
	    $category,$awards,$description,$inscription_price,$inscription_location,
	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon,$province_id,$is_selected) {
            if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
    	        throw new Exception("user not logged in");
    	    }
    	    
    	    if($is_selected=='true') {
    	        $is_selected="true";
    	    } else {
    	        $is_selected="false";
    	    }
    	    
	        $sql="INSERT INTO run(name,event_location,distance_meters,distance_text,event_date,category,awards,".
	            "description, inscription_price,inscription_location,inscription_email,inscription_website,province_fk,is_displayed_in_home,start_point,end_point".
	            ") VALUES('$name','$event_location',$distance_meters,'$distance_text','$event_date',".
                "'$category','$awards','$description','$inscription_price','$inscription_location',".
                "'$inscription_email','$inscription_website', $province_id,$is_selected";
                
                if($start_point_lat) {
                    $sql.=",GeomFromText('POINT($start_point_lon $start_point_lat)',4326)";
                } else {
                    $sql.=",null";
                }
                if($end_point_lat) {
                    $sql.=", GeomFromText('POINT($end_point_lon $end_point_lat)',4326)";
                }else {
                    $sql.=",null";
                }              
                $sql.=")";
            $result= pg_query($this->conn, $sql);

	    
	        //get last ID
    	    $sql = "SELECT currval('run_id_seq') AS last_value";
    	    $result=pg_query($this->conn, $sql);
    	    $res=pg_fetch_assoc($result);    	    
    	    $newId= (int)$res['last_value'];
    	    
    	    if (is_int($newId)) {
    	        return $newId;
    	    } else {
    	        return false;
    	    }
 	    
	    }
	    
    	public function updateRun($id,$name,$event_location,$distance_meters,$distance_text,$event_date,
    	    $category,$awards,$description,$inscription_price,$inscription_location,
    	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon, $province_id,$is_selected) {
                if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
        	        throw new Exception("user not logged in");
        	    }
        	    
        	    if($is_selected=='f') {
        	        $is_selected="false";
        	    } else {
        	        $is_selected="true";
        	    }
                
        	        $sql="UPDATE run SET name='$name',event_location='$event_location', distance_meters=$distance_meters, distance_text='$distance_text',event_date='$event_date',category='$category',awards='$awards', description='$description', inscription_price='$inscription_price',inscription_location='$inscription_location',inscription_email='$inscription_email',inscription_website='$inscription_website',province_fk=$province_id,is_displayed_in_home=$is_selected";
        	        
        	    if($start_point_lat) {
        	        $sql.=",start_point=GeomFromText('POINT($start_point_lon $start_point_lat)',4326)";
        	    }    
        	    if($end_point_lat) {
        	        $sql.=",end_point=GeomFromText('POINT($end_point_lon $end_point_lat)',4326)";
        	    }        	    
        	        
        	    $sql.=" WHERE id=$id";
            $result= pg_query($this->conn, $sql);
            return null;

    }
    
    public function getTrackGeometry($id) {
        $sql="select x((ST_Dump(track_geom)).geom) as lon, y((ST_Dump(track_geom)).geom) as lat  from run where id=$id";
        return pg_fetch_all(pg_query($this->conn, $sql)); 
    }
    
    
    public function updateRunGeometry($points,$id) {
        $wkt="MULTIPOINT(";
        foreach ($points as &$p) {
            $wkt.="(".$p['lon']." ". $p['lat'] ."),";
        }
        $wkt=substr($wkt,0,-1);
        $wkt.=")";
        $sql="UPDATE run SET track_geom=geomFromText('$wkt',4326) WHERE id=$id";
        $result= pg_query($this->conn, $sql);
        return null;        
        
    }
    	    
    public function removeRun($id) {
        if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
	        throw new Exception("user not logged in");
	    }
        $sql="DELETE FROM run WHERE id=$id";
        $result= pg_query($this->conn, $sql);
        return null;   	
    }	    
    
    public function getRunsList() {
        $sql="select id ,name,event_location,distance_meters,event_date,category,awards,description,inscription_price,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,province_fk,is_displayed_in_home from run ORDER BY id DESC"; 
		return pg_fetch_all(pg_query($this->conn, $sql));    
    }
    
    public function getRunDetails($id) {
        $sql="select r.id ,r.name,event_location,distance_meters,event_date,category,awards,description,inscription_price,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,is_displayed_in_home,(select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.id=$id";
        $result = pg_query($this->conn, $sql);  
        $run = pg_fetch_assoc($result);
        
        $targetPicture=getcwd()."/../media/run/".$run['id']."_big.jpg";
        if (file_exists($targetPicture)) {
            $run['big_picture'] = $run['id']."_big.jpg";
        } else {
            //no image for the run, select random
            $run['big_picture'] = "generic/".rand(1,4)."_big.jpg";
        }
        
        return $run;
    }
    
    public function getRunsCloseToAnother($id) {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and r.id <> $id order by event_date ASC limit 4";
		return pg_fetch_all(pg_query($this->conn, $sql));        
    }


}

?>
