<?php
include_once 'connection.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
class SaveData {

    public function insert($sql){
        if(Constants::connect() != null){
            $result = Constants::connect()->query($sql);
            if ($result) {
                http_response_code(200);
                $msg["state"]= "success";
                $msg["message"]="success";                        
            }else{
                http_response_code(500);
                $msg["state"]= "error";
                $msg["message"]= "Erreur survenue lors de l'enregistrement de la plaque";
            }
            mysqli_close(Constants::connect());
        }else {
            http_response_code(401);
             $msg["state"]= "error";
                $msg["message"]= "Mysql connect error";
        }
        echo json_encode($msg);
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
          $msg["state"]= "error";
                $msg["message"]= "Error: Invalid JSON received, no content";
        // Handle decoding error
       echo json_encode($msg);
        return;
    }
} else {
    $msg["state"]= "error";
                $msg["message"]= "Error: Invalid request";
        // Handle decoding error
      echo json_encode($msg);
        return;
}

///
/// PERFORM QUERY
/// 
if ($transaction == 'news') {
    try {
    $textes = Constants::connect()->real_escape_string($data['textes'] ?? '');
    $auteur = Constants::connect()->real_escape_string($data['auteur'] ?? '');
    $contenu = Constants::connect()->real_escape_string($data['contenu'] ?? '');

    if (isset($data['image']) && isset($data['image2'])) {
        $base64_image1 = $data['image'];
        $base64_image2 = $data['image2'];

        // Decode the base64 string into binary data
        $decoded_image1 = base64_decode($base64_image1);
        $decoded_image2 = base64_decode($base64_image2);
        
        // Set a path to save the file
        $upload_path1 = 'news1_' . rand(1, 9999).'_'. date('YmdHis') . '.jpg';
        $upload_path2 = 'news2_' . rand(1, 9999).'_'. date('YmdHis') . '.jpg';
        
        // Save the image data to a file
        if (file_put_contents("images/".$upload_path1, $decoded_image1)) {
           
        } else {
            $last_error = error_get_last();
            $errorMessage = $last_error['message'] ?? 'An unknown error occurred.';
            http_response_code(500);
            echo json_encode(['status' => 'error', 'message' => 'Failed to save the image1.'.$errorMessage]);
            return;
        }
        if (file_put_contents("images/".$upload_path2, $decoded_image2)) {
           
        } else {
            $last_error = error_get_last();
            $errorMessage = $last_error['message'] ?? 'An unknown error occurred.';
            http_response_code(500);
            echo json_encode(['status' => 'error', 'message' => 'Failed to save the image2.'.$errorMessage]);
            return;
        }
    } else {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'No image data received.']);
    }
    
    if (empty($upload_path1) || empty($auteur) || empty($upload_path2) || empty($contenu)) {
        http_response_code(403);
        echo json_encode(['status' => 'erreur', 'message' => 'Des champs obligatoires sont manquants.']);
        Constants::connect()->close();
        exit();
    }
    $sql = "INSERT INTO realisations (textes, auteur, image, image2, date_pub, contenu) 
            VALUES ('$textes', '$auteur', '$upload_path1', '$upload_path2', '".date('Y-m-d H:i:s')."', '$contenu');";
    } catch (\Throwable $th) {
        http_response_code(500);
        echo json_encode(['status' => 'erreur', 'message' => $th->getMessage()]);
        Constants::connect()->close();
        exit();
    }
    // print($sql);
}else if ($transaction == 'client') {
    $sql = "SELECT plaques.id ID, plaques.numero numPlaque, plaques.ville villePlaque,engin.marque marqueEngin, engin.couleur couleurEngin, engin.shasi, engin.genre, engin.num_moteur, engin.annee_fabrication, engin.annee_circulation,engin.puissance, engin.usage_moto, engin.status, engin.created_at, conducteurs.nom condNom, conducteurs.tel condTel, conducteurs.active, conducteurs.nnCarte cardID, conducteurs.nom2 cond2Nom, conducteurs.tel2 cond2Tel, conducteurs.nnCarte2 cardID2 FROM plaques INNER JOIN engin ON engin.plaque=plaques.numero INNER JOIN conducteurs ON conducteurs.id_engin=engin.id";
    // print($sql);
}
else if ($transaction == 'news_views') {
    $newsID=trim(htmlspecialchars($data['newsID']));
    $sql = "INSERT INTO news_views ( news_id, count) VALUES ( '$newsID', 1) ON DUPLICATE KEY UPDATE count = count + 1;";

    // UPDATE news_views SET count=count+1 WHERE news_id=$newsID
}
else{
    http_response_code(401);
        echo json_encode(['status' => 'erreur', 'message' => 'No gateway found']);
    return;
}
$save = new SaveData();
$save->insert($sql);

?>