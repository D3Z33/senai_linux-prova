# 🛡️ Senai - Linux_Prova 🛡️

**Uma simulação de prova interativa e um estudo de caso sobre segurança digital no Linux.**

---

## 📋 Descrição do Projeto

**Linux_Prova - Senai** é uma aplicação interativa, executada no terminal Linux, que simula uma prova de múltipla escolha com uma série de comandos e práticas voltadas para a administração e segurança do sistema. Este projeto vai além de um simples teste: ele ilustra como um malware pode operar camuflado em um script aparentemente inofensivo, capturando informações e executando ações críticas sem o conhecimento do usuário.

Esse projeto é ideal para treinamento em cibersegurança, pois mostra como um "script de prova" pode ser manipulado para realizar atividades maliciosas, ensinando conceitos essenciais de segurança para profissionais e estudantes da área.

---

## 🎯 Objetivo Educacional

Este projeto tem como objetivos:
- **Demonstrar a importância de validar scripts desconhecidos** e a análise criteriosa antes de executá-los.

- **Simular técnicas de engenharia social** e **engenharia de confiança**, exemplificando como scripts podem capturar dados sem o conhecimento do usuário.

- **Exibir os riscos de comandos camuflados e persistência de malware**, utilizando práticas comuns em ataques reais.

- **Todo o projeto simula técnicas frequentemente utilizadas por cibercriminosos** para capturar **credenciais sensíveis**, demonstrando como essas práticas podem, em **situações reais*, comprometer completamente o **sistema de uma empresa*.

Este projeto se destina a profissionais de TI, equipes de segurança e estudantes que buscam aprofundar seu entendimento sobre os perigos de scripts maliciosos e as melhores práticas de segurança.

---

## 🔍 Visão Geral do Projeto

O projeto **Senai - Linux_Prova** oferece:
1. **Prova de múltipla escolha** com perguntas técnicas de Linux e cibersegurança.

2. **Ações camufladas** como captura de senhas, criptografia de arquivos e envio de dados a servidores remotos, disfarçadas como “backup” e “remoção de logs”.

3. **Captura e envio de dados** como progresso da prova e informações de IP e credenciais.

4. **Configuração de um dashboard** para acompanhamento em tempo real do progresso dos alunos.


> ⚠️ **Atenção**: Este projeto é destinado exclusivamente para fins educacionais em ambientes controlados.

---

## 🖥️ Execução do Projeto

O projeto pode ser executado de duas formas: **Modo Padrão (sem Dashboard)** e **Modo Completo (com Dashboard)**. Veja abaixo os detalhes de cada um.

---

### 1️⃣ Modo Padrão (Prova Simples - Sem Dashboard)

 > **Ideal para simulações de prova sem monitoramento externo**.

#### Passo a Passo
1. **Clone o Repositório**:
   ```bash
   git clone https://github.com/D3Z33/senai_linux-prova
   cd senai_linux-prova
   ```

2. **Execute o script**:
   ```bash
   sudo bash ./prova_linux.sh
   ```
   
> **Durante a execução, o usuário deverá**:

- *Inserir a senha para conceder permissões sudo, se não, dará erro (**valide**).*

- *Inserir nome de usuário e senha (que serão capturados como parte da simulação de malware para o Telegram).*

---

### 2️⃣ Modo Completo (Com Dashboard para Monitoramento)
> **Ideal para a pessoa que está aplicando a prova e deseja monitorar o progresso dos alunos em tempo real**.

#### Passo a Passo para Configuração
1. **Clone o Repositório**:
   ```bash
   git clone https://github.com/D3Z33/senai_linux-prova
   cd senai_linux-prova
   ```

2. **Configuração do Apache**
   - Instale o Apache
   ```bash
   sudo apt update
   sudo apt install apache2 -y
   ```

- **Configure o Apache para servir os arquivos do dashboard:**
  - Copie a pasta `dashboard` para o diretório `/var/www/html/`.
  - Verifique se o Apache está acessível no IP configurado (ex: `http://<SEU_IP_SERVER>/dashboard`).

3. **Dê Permissões ao Script da Prova e Arquivo JSON:**
   ```bash
   chmod +x prova_linux.sh
   sudo touch /var/www/html/dashboard/progress.json
   sudo chmod 666 /var/www/html/dashboard/progress.json
   ```

4. **Execute o Script da Prova**:
   ```bash
   sudo bash ./prova_linux
   ```

5. **Execute o Script do Dashboard em Outro Terminal para Monitoramento**:
   ```bash
   sudo bash ./dashboard.sh
   ```
 
- O dashboard exibirá em tempo real o progresso dos alunos e o número de máquinas criptografadas e apagadas. Ele requer uma conexão ativa com o servidor Apache para atualizar os dados.

---

## ⚙️ Estrutura do Projeto
   ```bash
   Linux_Prova-Senai/
├── prova_linux.sh          # Script principal da prova
├── dashboard/
│   ├── update.php          # Atualiza o progresso do aluno
│   ├── get_status.php      # Exibe o progresso atual de cada aluno
│   ├── get_apagadas.php    # Exibe o número de máquinas apagadas
│   ├── update_apagadas.php # Incrementa o contador de máquinas apagadas
│   └── progress.json       # Armazena o progresso dos alunos (JSON)
├── dashboard.sh            # Script do dashboard para exibir progresso em tempo real
└── README.md               # Este arquivo README
   ```

---

## 🔑 Conceitos de Cibersegurança Abordados

1. **Uso Indevido de Senhas e Autenticação**
   - **Simulação de Captura de Credenciais:** Durante a execução, o script captura as credenciais do usuário em três etapas, evidenciando como scripts maliciosos podem coletar dados sensíveis.
   - **Aprendizado:** Qualquer solicitação suspeita de senha em scripts deve levantar suspeitas imediatas sobre possíveis capturas de dados.

2. **Camuflagem de Comandos**
   - A função de “backup” e “remoção de logs” disfarça comandos destrutivos que criptografam e apagam dados do sistema.
   - **Aprendizado:** Scripts podem esconder comandos perigosos que executam ações críticas em segundo plano. A análise do código é essencial antes de executar qualquer script desconhecido.

3. **Captura e Transmissão de Dados**
   - **Envio de Informações para o Dashboard e Telegram:** Dados de IP, progresso e senhas são capturados e enviados a servidores remotos e ao Telegram, simulando um cenário de exfiltração de dados.
   - **Aprendizado:** Scripts maliciosos frequentemente incluem mecanismos de exfiltração para capturar e enviar informações confidenciais para fora da rede da vítima.

4. **Engenharia Social e Engenharia de Confiança**
   - **Simulação de Ambiente Seguro:** O usuário acredita estar participando de uma prova inofensiva, exemplificando como hackers exploram a confiança para obter acesso.
   - **Aprendizado:** A engenharia social é uma das técnicas mais eficazes em ataques de cibersegurança. Suspeite de qualquer script que não seja de fonte confiável.

5. **Execução e Persistência com Permissões Elevadas**
   - **Uso de Sudo:** O script é executado com privilégios elevados, permitindo que comandos destrutivos sejam executados com total controle do sistema.
   - **Aprendizado:** Nunca execute scripts desconhecidos com permissões elevadas sem inspeção minuciosa. Esse é o ponto mais vulnerável e explorado em ataques maliciosos.

---

## 🛡️ Lições Importantes

1. **Revise scripts desconhecidos antes de executá-los:** Um script que parece seguro pode conter comandos críticos camuflados.

2. **Desconfie de solicitações de senha:** Scripts que pedem repetidas autenticações podem estar capturando suas credenciais.

3. **Use ambientes de teste controlados:** Se precisar testar um script, use uma máquina virtual ou sandbox para evitar riscos ao sistema principal.

4. **Observe o tráfego de rede:** Scripts que enviam dados para servidores remotos podem ser uma bandeira vermelha.

---

## ⚠️ Aviso de Responsabilidade

Este projeto é um exemplo de simulação educacional, destinado apenas para ambientes de aprendizado controlados. Executá-lo em sistemas reais ou sem permissão adequada pode resultar em perda de dados ou comprometer a segurança do sistema.

---

## ⚙️ Tecnologias Utilizadas

<div style="text-align: center;">

  <img src="https://github.com/D3Z33/senai_linux-prova/blob/main/images/shell.png" alt="Bash Script" width="32" height="32" style="margin-right: 5px;">
  <img src="https://github.com/D3Z33/senai_linux-prova/blob/main/images/apache.png" alt="Apache Server" width="32" height="32" style="margin-right: 5px;">
  <img src="https://github.com/D3Z33/senai_linux-prova/blob/main/images/php.png" alt="PHP" width="32" height="32" style="margin-right: 5px;">
  <img src="https://github.com/D3Z33/senai_linux-prova/blob/main/images/telegram.png" alt="Telegram Bot API" width="32" height="32" style="margin-right: 5px;">
  <img src="https://github.com/D3Z33/senai_linux-prova/blob/main/images/json.png" alt="JSON" width="32" height="32">

</div>

-  **Bash Script:** Linguagem principal utilizada para automação dos processos de prova, envio de dados e controle do fluxo.

-  **Apache Server:** Atua como um servidor intermediário para coleta e exibição dos dados em tempo real, integrando o front-end (dashboard) ao back-end.

-  **PHP:** Script server-side para manipulação e armazenamento dos dados de progresso dos alunos, além de processamento das requisições HTTP para o dashboard.

-  **Telegram Bot API:** Configurado para envio de notificações e captura de dados sensíveis de forma automatizada, garantindo que as atualizações cheguem ao instrutor.

-  **JSON:** Utilizado como estrutura de armazenamento leve e eficaz para persistência dos dados de progresso e status, facilmente manipulável pelo PHP e pelo script Bash.

---

## ⭐ Gostou deste projeto? Deixe um star no repositório e contribua para a conscientização sobre segurança digital!

---

## 🤝 Conecte-se e Colabore

Dúvidas? Sugestões? Colaborações? Vamos conversar!

<p align="center">
  <a href="https://github.com/DZ33" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-DZ33-000?style=for-the-badge&logo=github" alt="GitHub: DZ33" width="100"/>
  </a>
  <span style="margin-left: 10px;">Feito por: <strong>D3Z33</strong></span>
</p>

---



   
