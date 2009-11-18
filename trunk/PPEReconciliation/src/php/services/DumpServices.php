<?php

class DumpServices {
	
	function __construct() {
	}
	
	function login($username,$password) {
		$res=array();
		
		if ($username=="") {
			$res['loginresult']=true;
			$res['username']="Craig";
			$res['userid']="65";
		} else {
			$res['loginresult']=false;
		}
		
		return $res;
	}
	
	function getContriesForRegion($regionId,$page,$perPage) {
		$resul=array();
		
		$res=array();
		for($i=1;$i<25;$i++) {
			$c=array();
			$c['id']=$i;
			$c['name']=$regionId."-".$i;
			$c['numareas']=23;
			$res[]=$c;
		}
		$resul['results'] = $res;
		$resul['total'] = 50; 
		return $resul;
	}
	
	function prepareDownload($countries,$pas,$search) {
		error_log($countries);
	}
	
	function getPendingTasks($page,$perPage) {
		$resul=array();
		$res=array();
		for($i=1;$i<9;$i++) {
			$t=array();
			$t['type'] = $i;
			$t['code'] = "DW541";
			$t['description'] = "Spain";
			$t['what']="Country Download";
			$t['numareas']=2431;
			$t['status'] = "preparingDownload";
			$t['statuspercen'] = 72;
			$t['date'] = "2009/11/".$i." 12:34:00";
			$res[]=$t;
		}
		$resul['results'] = $res;
		$resul['total'] = 50;		
		
		return $resul;
	}
	
	
}
?>