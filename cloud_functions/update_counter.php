<?php
try {
    include_once("connection.php");
$file = 'compteur_visites.txt';

// Crée le fichier s’il n’existe pas
if (!file_exists($file)) {
    file_put_contents($file, 0);
}

// Lit la valeur actuelle
$count = (int) file_get_contents($file);
http_response_code(200);
if(!isset($_GET['update']) || strval($_GET['update']) != 'true') {
    echo json_encode(['visits' => $count]);
    return;
}

// Incrémente
$count++;

// Sauvegarde la nouvelle valeur
file_put_contents($file, $count);

// Retourne le compteur en JSON
echo json_encode(['visits' => $count]);
} catch (\Throwable $th) {
    http_response_code(500);
    echo json_encode(['status' => 'erreur', 'message' => $th->getMessage()]);
    Constants::connect()->close();
    exit();
}
?>