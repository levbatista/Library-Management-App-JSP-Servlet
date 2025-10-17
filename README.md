# 📚 Sistema de Gerenciamento de Biblioteca Web

## 🌟 Visão Geral do Projeto

Esta é uma aplicação web completa desenvolvida em Java para o gerenciamento de uma biblioteca, focada na gestão do acervo (Livros), cadastro de usuários e no controle do fluxo de empréstimos e devoluções.

O projeto foi construído utilizando a arquitetura de **desenvolvimento em camadas (MVC)**, garantindo a separação de responsabilidades entre a lógica de negócio e a camada de apresentação.

## 🚀 Funcionalidades Principais

| Categoria | Funcionalidade | Descrição |
| :--- | :--- | :--- |
| **Livros** | **CRUD Completo** | Cadastro, leitura, atualização e exclusão de informações sobre o acervo. |
| **Usuários** | **CRUD Completo** | Gestão de membros com registro, listagem e alteração de dados. |
| **Empréstimos** | **Registro e Devolução** | Criação de novos empréstimos e marcação de devolução de livros, controlando a relação entre Livro e Usuário. |
| **Consultas** | **Listagem Detalhada** | Visualização de todos os empréstimos ativos. |

## 🛠️ Tecnologias Utilizadas

A aplicação utiliza o ecossistema Java e padrões de mercado:

| Categoria | Tecnologia | Uso Principal |
| :--- | :--- | :--- |
| **Linguagem** | Java | Lógica de negócio (Backend). |
| **Servidor** | Apache Tomcat | Servidor de aplicação. |
| **Padrões Web** | Servlets e JSP | **Servlets** como Controladores e **JSP** para a camada de Views. |
| **Persistência** | JPA (Hibernate) | Mapeamento Objeto-Relacional e acesso ao banco de dados. |
| **Banco de Dados** | MySQL | Armazenamento de dados. |
| **Build/Gerenciamento** | Maven | Gerenciador de dependências. |
| **Design/Front-end** | Tailwind CSS | Framework CSS para estilização moderna e responsiva. |

## ⚙️ Configuração e Inicialização

O projeto utiliza o **Maven** para gerenciar as dependências. Para inicializar e rodar, é necessário que o ambiente possua os seguintes pré-requisitos configurados:

1.  **JDK (Java Development Kit)**
2.  **Apache Tomcat**
3.  **MySQL Server**

O arquivo de configuração da persistência (localizado em `persistence.xml`) deve ser ajustado para as credenciais do ambiente MySQL local antes de compilar e executar no servidor Tomcat.

---

## 🤝 Colaboradores

Desenvolvido em colaboração por:

| Nome | GitHub |
| :--- | :--- |
| **Leverson Batista** | [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/levbatista) |
| **Pedro Oliveira** | [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/PHonz11) |
