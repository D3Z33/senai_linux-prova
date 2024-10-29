<?php
// Captura o número de máquinas apagadas
$num_apagadas = isset($_POST['num_apagadas']) ? $_POST['num_apagadas'] : 0;

// Atualiza o arquivo com o número de máquinas apagadas
file_put_contents('/var/www/html/dashboard/apagadas.txt', $num_apagadas);
?>