<?php
// Caminho do arquivo de progresso
$file = '/var/www/html/dashboard/progress.json';

// Verifica se o arquivo existe
if (file_exists($file)) {
    $data = json_decode(file_get_contents($file), true);

    // Exibe o progresso de cada aluno
    foreach ($data as $nickname => $progress) {
        echo "$nickname,$progress\n";
    }
} else {
    echo "Nenhum dado de progresso disponível.";
}
?>