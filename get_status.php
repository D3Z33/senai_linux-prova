<?php
// Caminho do arquivo onde estão armazenados os progressos
$file = '/var/www/html/dashboard/progress.json';

// Lê e exibe os dados de progresso
if (file_exists($file)) {
    echo file_get_contents($file);
} else {
    echo json_encode([]);
}
?>
