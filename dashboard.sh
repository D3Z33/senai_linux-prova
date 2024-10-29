#!/bin/bash

# Definindo as cores
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
PURPLE=$(tput setaf 5)
NC=$(tput sgr0)  # Resetar a cor

# Carrinho no terminal para cada aluno com cores
criar_dashboard() {
  clear
  tput setaf 6  # Define a cor do título em ciano
  echo "----------------------------------------------"
  echo "             🏆 Progresso dos Alunos 🏆"
  echo "----------------------------------------------"
  echo ""
  tput sgr0  # Reseta a cor para o conteúdo

  # Loop para exibir o progresso em tempo real
  while :; do
    clear
    tput setaf 6  # Define a cor do título em ciano
    echo "----------------------------------------------"
    echo "             🏆 Progresso dos Alunos 🏆"
    echo "----------------------------------------------"
    echo ""
    tput sgr0  # Reseta a cor para o conteúdo

    # Recolher os dados de todos os alunos (progresso e nickname)
    wget --quiet -qO- http://172.31.19.2/dashboard/get_status.php | while read -r linha; do
      nickname=$(echo $linha | cut -d ',' -f 1)
      progresso=$(echo $linha | cut -d ',' -f 2)

      # Cor para o nickname
      tput setaf 2  # Verde para o nome do aluno
      printf "%s: " "$nickname"
      tput sgr0  # Reseta a cor

      # Exibir o carrinho se movendo conforme o progresso
      for ((i=0; i<$progresso; i++)); do
        tput setaf 3  # Amarelo para as barras de progresso
        printf "█"
      done
      tput setaf 5  # Roxo para o carrinho
      printf "🏎️  "  # Carrinho de corrida
      tput sgr0  # Reseta a cor após exibir o carrinho
      printf "%d%%" "$((progresso * 10))"  # Exibe o progresso em porcentagem
      echo ""
    done

    # Exibir o progresso de apagamento/criptografia com cor em vermelho
    tput setaf 1  # Vermelho para o progresso de apagamento
    echo "----------------------------------------------"
    echo ""
    echo "Máquinas que sofreram Backup e remoção de LOG's: $(wget --quiet -qO- http://172.31.19.2/dashboard/get_apagadas.php)"
    echo ""
    echo "----------------------------------------------"
    echo ""
    tput sgr0  # Reseta as cores

    sleep 2  # Atualizar a cada 2 segundos
  done
}

# Chamar a função para criar o dashboard
criar_dashboard