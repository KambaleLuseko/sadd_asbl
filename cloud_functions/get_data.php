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
    $sql = "SELECT * FROM realisations ORDER BY id DESC;";
    // print($sql);
}else if ($transaction == 'client') {
    $sql = "SELECT plaques.id ID, plaques.numero numPlaque, plaques.ville villePlaque,engin.marque marqueEngin, engin.couleur couleurEngin, engin.shasi, engin.genre, engin.num_moteur, engin.annee_fabrication, engin.annee_circulation,engin.puissance, engin.usage_moto, engin.status, engin.created_at, conducteurs.nom condNom, conducteurs.tel condTel, conducteurs.active, conducteurs.nnCarte cardID, conducteurs.nom2 cond2Nom, conducteurs.tel2 cond2Tel, conducteurs.nnCarte2 cardID2 FROM plaques INNER JOIN engin ON engin.plaque=plaques.numero INNER JOIN conducteurs ON conducteurs.id_engin=engin.id";
    // print($sql);
}
else if ($transaction == 'platestock') {
    $sql = "SELECT * FROM stock_plaques";
}
else if ($transaction == 'login') {
    $username=trim(htmlspecialchars($_POST['username']));
    $password=trim(htmlspecialchars($_POST['password']));
    $level=trim(htmlspecialchars($_POST['level']));
    $sql = "SELECT `id`, `nom`, `username`,  `niveau` from users where username='$username' and password='$password' and niveau='$level'";
}else{
    print(json_encode("No gateway found"));
}
$zakuuza = new SelectAll();
$zakuuza->select($sql);

?>