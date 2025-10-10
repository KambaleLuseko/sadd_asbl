<?php
include_once 'connection.php';
class SelectAll {

    public function select($query){
        if(Constants::connect() != null){
            $result = Constants::connect()->query($query);
            // var_dump($result);

            if (!empty($result) && $result->num_rows > 0) {
                $array = array();
                while ($row=$result->fetch_assoc()) {
                   array_push($array, $row);
                }
                print(json_encode($array));
            } else {
                print(json_encode("No data found"));
            }  
        }else {
            print(json_encode("Cannot connect to Database Server"));
        }
    }
}
$sql = '';
// print json_encode($_POST);
// return;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Read the raw POST data from the request body
    $json = file_get_contents('php://input');

    // Decode the JSON data into a PHP array or object
    $data = json_decode($json, true); // true for associative array
    // Now you can access your data
    if ($data !== null) {
        $transaction = $data['transaction'];
    } else {
        // Handle decoding error
        echo "Error: Invalid JSON received, no content";
        return;
    }
} else {
    echo "Error: This endpoint only accepts POST requests.";
}

///
/// PERFORM QUERY
/// 
if ($transaction == 'news') {
    $sql = "SELECT realisations.*, (SELECT count FROM news_views WHERE news_id=realisations.id) viewCount FROM realisations ORDER BY id DESC;";
    // print($sql);
}else if ($transaction == 'videos') {
    $sql = "SELECT * FROM videos ORDER BY id DESC LIMIT 1;";
    // print($sql);
}
else if ($transaction == 'login') {
    $username=trim(htmlspecialchars($data['username']));
    $password=trim(htmlspecialchars($data['password']));
    $hashedPassword=sha1($password);
    $sql = "SELECT * from compte where admin='$username' and password='$hashedPassword'";
    // echo json_encode($sql);
    // return ;
}else{
    print(json_encode("No gateway found"));
}
$zakuuza = new SelectAll();
$zakuuza->select($sql);

?>