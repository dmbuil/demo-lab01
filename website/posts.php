<html>
<head>
<style>body{font-family: "Segoe UI";}</style>
</head>
	<body>
		<h1>VDC Demo Site</h1>

		<?php
		$hn=gethostname();
		echo "<p><i>Proudly served from node: ".$hn."</i></p>";
		?>
		<p>Database Server: {lab.db.fqdn}</p>
		<a href='new.php'>Create new Post</><br>
		<a href='posts.php?delete=true'>Delete all Posts</a>

		<?php
		# Delete Posts
		if (isset($_GET['delete'])){
			$con = mysqli_connect('{lab.db.fqdn}', '{lab.db.user}', '{lab.db.password}');
			mysqli_select_db($con, 'acmedb');

			$result = mysqli_query($con, "DELETE FROM `posts`");
		}

		$con = mysqli_connect('{lab.db.fqdn}', '{lab.db.user}', '{lab.db.password}');
		mysqli_select_db($con, 'acmedb');
		
		if (!$con) {
		    echo "Error: No se pudo conectar a MySQL." . PHP_EOL;
		    echo "errno de depuración: " . mysqli_connect_errno() . PHP_EOL;
		    echo "error de depuración: " . mysqli_connect_error() . PHP_EOL;
		    exit;
		}

		$result = mysqli_query($con, "SELECT * FROM `posts`");

		# Lists all posts
		while ($post = mysqli_fetch_assoc($result)){
		        $link = "<a href='post.php?id=".$post['id']. "'>";
		        echo $link;
		        echo "<h3>".$post['title']."</h3>";
		        echo "</a>";
		        echo "<p>Hostname: ".$post['hostname']."</p>";
		        echo "<p>".$post['body']."</p>";
		        echo "<hr />";
		}
		?>
	</body>
</html>
