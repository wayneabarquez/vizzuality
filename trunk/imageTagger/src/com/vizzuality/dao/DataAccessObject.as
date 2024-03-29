package com.vizzuality.dao
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
		
	public class DataAccessObject {
		
		private var sentence:String="";
		private var dbFile:File = File.applicationStorageDirectory.resolvePath("DBV.db");
		private var sqlConect:SQLConnection;
		private var sqlStatement: SQLStatement;
		private var result:ArrayCollection;
		
		
		public function get dbResult():ArrayCollection {
	    	return result;
		}


		public function set dbResult(value:ArrayCollection):void {
	    	result = value;
		}
	 
	
		public function DataAccessObject() {
		}
		

		public function openConnection(str:String):void {
		    sentence = str;
		    sqlConect = new SQLConnection();
		    sqlConect.addEventListener(SQLEvent.OPEN, sqlConnectionOpenHandler);
		    sqlConect.addEventListener(SQLErrorEvent.ERROR, sqlConnectionErrorHandler);
		    sqlConect.open(dbFile);		
		}
		
		
		private function sqlConnectionOpenHandler(ev:SQLEvent):void {
			sqlStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConect;

			sqlStatement.text = sentence;
			
			sqlStatement.addEventListener(SQLEvent.RESULT, handlerStatement);
			sqlStatement.addEventListener(SQLErrorEvent.ERROR, sqlConnectionErrorHandler);
			
			sqlStatement.execute();
		}
				
		
		
		private function sqlConnectionErrorHandler(ev:SQLErrorEvent):void {
			Alert.show("Error: " +  ev.error.message);
		}	
		
				
		private function handlerStatement(ev:SQLEvent):void {
			var result:SQLResult = sqlStatement.getResult();
			dbResult = new ArrayCollection(result.data);
		}
		
		
		public function createTables():void {
			var sqlCreate1:String = 
		    "CREATE TABLE IF NOT EXISTS user (" + 
		    "    alias TEXT PRIMARY KEY, " + 
		    "    token TEXT" +
		    ")";
			
			openConnection(sqlCreate1);
			
			var sqlCreate2:String =
			"CREATE TABLE IF NOT EXISTS photos (" +
			"id INTEGER PRIMARY KEY AUTOINCREMENT,"+
			"login TEXT," +
			"path TEXT," +
			"scientific TEXT DEFAULT NULL,"+ 
			"kingdom TEXT," + 
			"phylum TEXT," + 
			"clas TEXT," + 
			"orde TEXT," + 
			"family TEXT," + 
			"genus TEXT," + 
			"binomial TEXT," + 
			"lat TEXT," +
			"lon TEXT," +
			"zoom INTEGER," +
			"FOREIGN KEY (login) REFERENCES user(alias) " +
			"ON UPDATE CASCADE " +
			"ON DELETE SET NULL)";
			
			openConnection(sqlCreate2);			
		}
		
		
		public function getLatitudes(path:String):void {
			var sqlSentence: String = "SELECT lat,lon,zoom FROM photos WHERE path='"+path+"'";
			openConnection(sqlSentence);
		}
		
		
		public function updateLatitudes(lat:String,lon:String,zoom:int,path:String):void {
			var sqlSentence: String = "UPDATE photos SET lat = '"+lat+"', lon = '"+lon+"', zoom = '"+zoom+"' WHERE path = '"+path+"'";
			openConnection(sqlSentence);
		}
		
		
		public function getTaxonomy(path:String):void {
			var sqlSentence: String = "SELECT kingdom,phylum,clas,orde,family,genus,binomial FROM photos WHERE path='"+path+"'";
			openConnection(sqlSentence);
		}
		
	
		public function countHandler(sqlArray: ArrayCollection):int {
			var numRows:int = sqlArray.length;
			var count: int;
			for (var i:int = 0; i < numRows; i++) {
		        var output:String = "";
		        for (var columnName:String in sqlArray[i]) {
		            count=sqlArray[i][columnName];
		        }
		    }	
		    return count;
	    }
	    
		
		
		public function showTable(result: ArrayCollection):void {
			if (result.length!=0) {
				var numRows:int = result.length;
			    for (var i:int = 0; i < numRows; i++) {
			        var output:String = "";
			        for (var columnName:String in result[i]) {
			            output += columnName + ": " + result[i][columnName] + "; ";
			        }
			        trace("row[" + i.toString() + "]\t", output);
			    }
		    }
		}

	}
}