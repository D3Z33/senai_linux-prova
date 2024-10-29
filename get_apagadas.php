<?php
// Caminho do arquivo onde está o número de máquinas apagadas
$file = '/var/www/html/dashboard/apagadas.txt';

// Verifica se o arquivo existe
if (file_exists($file)) {
    // Lê o número de máquinas apagadas
    $num_apagadas = file_get_contents($file);
    echo $num_apagadas;
} else {
    echo "0";  // Se não houver arquivo, retorna 0
}
?>