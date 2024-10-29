<?php
// Caminho do arquivo onde estão os dados
$file = '/var/www/html/dashboard/progress.json';

// Verifica se o arquivo existe
if (file_exists($file)) {
    // Lê o conteúdo do arquivo JSON
    $data = json_decode(file_get_contents($file), true);

    // Exibe o progresso de cada aluno
    foreach ($data as $nickname => $progress) {
        echo "$nickname,$progress\n";
    }
} else {
    echo "Nenhum dado encontrado.";
}
?>