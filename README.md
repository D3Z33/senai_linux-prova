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
-
- **Simular técnicas de engenharia social** e **engenharia de confiança**, exemplificando como scripts podem capturar dados sem o conhecimento do usuário.
- 
- **Exibir os riscos de comandos camuflados e persistência de malware**, utilizando práticas comuns em ataques reais.
-
- **Todo o projeto simula técnicas frequentemente utilizadas por cibercriminosos** para capturar **credenciais sensíveis**, demonstrando como essas práticas podem, em *situações reais*, comprometer completamente o **sistema de uma empresa*.
-
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
   
Durante a execução, o usuário deverá:

Inserir a senha para conceder permissões sudo.
Inserir nome de usuário e senha (que serão capturados como parte da simulação de malware).

---

### 2️⃣ Modo Completo (Com Dashboard para Monitoramento)
> ** Ideal para a pessoa que está aplicando a prova e deseja monitorar o progresso dos alunos em tempo real.

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



   
