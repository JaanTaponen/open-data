<?php
	/*Perushaku joka palauttaa koko tietokannan ristitaulukkona.*/
    if (isset($_POST['hae']) === true) {
        require('connect.php');
        $query = mysql_query("
        
        ")
		/*Itse kysely. Tähän pitäisi vielä lisätä sanitointi
		sekä eri kyselytyyppejä.*/
        $result = mysql_query("SELECT * FROM *;");
    }
?>