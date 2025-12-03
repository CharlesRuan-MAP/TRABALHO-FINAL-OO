# Sistema de Gestão de Tarefas e Projetos

> Projeto final da disciplina de **Programação Orientada a Objetos** - Universidade de Brasília (UnB)

Sistema web completo para gestão de tarefas e projetos, desenvolvido em **Python** com framework **Bottle**, implementando os **4 pilares da Orientação a Objetos**.

## Funcionalidades Principais

- **Sistema de Autenticação Avançado**: Login, registro, logout com sessões
- **Gestão de Usuários com Permissões**: Usuários comuns e Administradores
- **CRUD Completo de Tarefas**: Criar, editar, excluir e marcar como concluída
- **CRUD Completo de Projetos**: Organizar tarefas em projetos
- **Dashboard Personalizado**: Diferente para usuários e administradores
- **Interface Responsiva**: Design moderno e intuitivo com CSS customizado
- **Relacionamentos Complexos**: Tarefas associadas a projetos e usuários

---

---

## Tecnologias Utilizadas

- **Backend**: Python 3.x + Bottle Framework
- **Frontend**: HTML5 + CSS3 + JavaScript
- **Persistência**: JSON Files
- **Arquitetura**: MVC (Model-View-Controller)
- **Autenticação**: Sistema de sessão com cookies

---


## Estrutura de Pastas

```bash
TRABALHO-FINAL-OO-main/
├── app.py                 # Aplicação principal
├── config.py             # Configurações do projeto
├── main.py              # Ponto de entrada
├── requirements.txt     # Dependências do projeto
├── README.md           # Este arquivo
├── teste_heranca.py    # Teste dos 4 pilares da OO
├── controllers/        # Controladores (Rotas)
│   ├── base_controller.py    # Classe base com utilitários
│   ├── home_controller.py    # Página inicial
│   ├── auth_controller.py    # Autenticação (login/logout)
│   ├── register_controller.py # Registro de usuários
│   ├── task_controller.py    # Gestão de tarefas
│   ├── projeto_controller.py # Gestão de projetos
│   └── user_controller.py    # Área administrativa
├── models/            # Entidades do sistema
│   ├── user.py              # Usuarios (com herança)
│   ├── task.py              # Tarefas
│   └── projeto.py           # Projetos
├── services/          # Lógica de negócio
│   ├── auth_service.py      # Serviço de autenticação
│   ├── user_service.py      # Serviço de usuários
│   ├── task_service.py      # Serviço de tarefas
│   └── projeto_service.py   # Serviço de projetos
├── views/            # Templates HTML
│   ├── layout.tpl           # Layout base
│   ├── home_publica.tpl     # Home para visitantes
│   ├── home_logada.tpl      # Dashboard para usuários logados
│   ├── login.tpl            # Página de login
│   ├── register.tpl         # Página de registro
│   ├── tasks.tpl            # Lista de tarefas
│   ├── task_form.tpl        # Formulário de tarefas
│   ├── projetos.tpl         # Lista de projetos
│   ├── projeto_form.tpl     # Formulário de projetos
│   ├── projeto_detalhes.tpl # Detalhes do projeto com tarefas
│   ├── admin_usuarios.tpl   # Gestão de usuários (admin)
│   └── admin_user_form.tpl  # Formulário admin de usuários
├── static/           # Arquivos estáticos
│   ├── css/
│   │   ├── style.css       # Estilos principais
│   │   └── helper.css      # Estilos auxiliares
│   └── js/
│       ├── main.js         # JavaScript principal
│       └── helper.js       # JavaScript auxiliar
└── data/            # Persistência em JSON
    ├── users.json          # Dados dos usuários
    ├── tasks.json          # Dados das tarefas
    └── projetos.json       # Dados dos projetos
```


---

## Descrição das Pastas

### `controllers/`
Contém as classes responsáveis por lidar com as rotas da aplicação. Exemplos:
- `user_controller.py`: rotas para listagem, adição, edição e remoção de usuários.
- `base_controller.py`: classe base com utilitários comuns.

### `models/`
Define as classes que representam os dados da aplicação. Exemplo:
- `user.py`: classe `User`, com atributos como `id`, `name`, `email`, etc.

### `services/`
Responsável por salvar, carregar e manipular dados usando arquivos JSON. Exemplo:
- `user_service.py`: contém métodos como `get_all`, `add_user`, `delete_user`.

### `views/`
Contém os arquivos `.tpl` utilizados pelo Bottle como páginas HTML:
- `layout.tpl`: estrutura base com navegação e bloco `content`.
- `users.tpl`: lista os usuários.
- `user_form.tpl`: formulário para adicionar/editar usuário.

### `static/`
Arquivos estáticos como:
- `css/style.css`: estilos básicos.
- `js/main.js`: scripts JS opcionais.
- `img/BottleLogo.png`: exemplo de imagem.

### `data/`
Armazena os arquivos `.json` que simulam o banco de dados:
- `users.json`: onde os dados dos usuários são persistidos.

---

## ▶️ Como Executar

1. Crie o ambiente virtual na pasta fora do seu projeto:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\\Scripts\\activate     # Windows
```

2. Entre dentro do seu projeto criado a partir do template e instale as dependências:
```bash
pip install -r requirements.txt
```

3. Rode a aplicação:
```bash
python main.py
```

4. Accese sua aplicação no navegador em: [http://localhost:8080](http://localhost:8080)

---

## Credenciais de Teste


1. Usuário Comum

Email: teste@email.com

Senha: 123456

2. Administrador

Email: admin@email.com

Senha: admin123

---

---
## ✍️ Como Extender o Projeto

Para adicionar novas entidades (ex: Categorias):

Crie o Model em models/categoria.py

Crie o Service em services/categoria_service.py

Crie o Controller em controllers/categoria_controller.py

Crie as Views em views/categorias.tpl e views/categoria_form.tpl

---

## 🧠 Autor e Licença
Projeto desenvolvido como template didático para disciplinas de Programação Orientada a Objetos, baseado no [BMVC](https://github.com/hgmachine/bmvc_start_from_this).
Você pode reutilizar, modificar e compartilhar livremente.

[Cauã Clemente] - [cacaclecontato@gmail.com]
[Charles Ruan] - [charlesruan321@gmail.com]
[Kevin Sousa] - [kevinlkat10@gmail.com]
Universidade de Brasília (UnB) - 2025