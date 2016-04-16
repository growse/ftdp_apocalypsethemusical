<h2>A selection of production images</h2>
<?php
if ($_REQUEST['photo'] == "") {
	$perrow = 6;
	$rowcount = 0;
	$handle = opendir('/var/www/apocalypse-the-musical.com/www/images/photos/small/');
	echo '<table class="thumbnails">';
	while(false != ($file = readdir($handle))) {
		if ($file!="." && $file!="..") {
			if ($rowcount == 0) { 
				echo "<tr>";
			}
			echo('<td><a href="index.php?page=gallery&photo='.$file.'"><img src="images/photos/small/'.$file . '"></a></td>');
			$rowcount++;
			if ($rowcount == $perrow) {
				$rowcount = 0;
				print "</tr>";
			}
		}
	}

	echo '</table>';
} else {
	echo '<img src="images/photos/'.$_REQUEST['photo'].'">';
}
?>
