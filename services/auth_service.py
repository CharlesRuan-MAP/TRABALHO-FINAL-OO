from models.user import UserModel, UsuarioComum, Administrador

class AuthService:
    def __init__(self):
        self.user_model = UserModel()
        self._criar_usuarios_teste()
    def _criar_usuarios_teste(self):
        print("AUTH_SERVICE: Verificando usuários de teste...")
    #usuario de teste
        if not self.user_model.get_by_email("teste@email.com"):
            usuario_teste = UsuarioComum(
                id=1,
                nome="Usuário Teste",
                email="teste@email.com",
                senha="123456",
                birthdate="2000-01-01"
            )
            self.user_model.add_user(usuario_teste)
            print("AUTH_SERVICE: Usuário comum de teste criado - teste@email.com / 123456")
        
        #admin
        if not self.user_model.get_by_email("admin@email.com"):
            admin = Administrador(
                id=2,
                nome="Administrador",
                email="admin@email.com",
                senha="admin123",
                birthdate="1990-01-01"
            )
            self.user_model.add_user(admin)
            print("AUTH_SERVICE: Administrador criado - admin@email.com / admin123")
        
        #ver se tem users
        usuarios = self.user_model.get_all()
        print(f"AUTH_SERVICE: Total de usuários no sistema: {len(usuarios)}")
        for usuario in usuarios:
            nome = getattr(usuario, 'nome', None) or getattr(usuario, 'name', 'Sem nome')
            email = getattr(usuario, 'email', 'Sem email')
            tipo = getattr(usuario, 'tipo', 'desconhecido')
            print(f"{nome} ({email}) - {tipo}")
    
    def get_usuario_por_email(self, email):
#buscar pelo email
        usuario = self.user_model.get_by_email(email)
        if usuario:
            nome = getattr(usuario, 'nome', None) or getattr(usuario, 'name', 'Sem nome')
            print(f"AUTH_SERVICE: Usuário encontrado - {nome} ({usuario.email})")
        else:
            print(f"AUTH_SERVICE: Usuário NÃO encontrado - {email}")
        return usuario
    
    def fazer_login(self, email, senha):
    #verificar login
        print(f"AUTH_SERVICE: Tentando login com email: '{email}'")
        
        usuario = self.get_usuario_por_email(email)
        if not usuario:
            print("AUTH_SERVICE: Login FALHOU - Usuário não encontrado")
            return False
        if email == "teste@email.com" and senha == "123456":
            print("AUTH_SERVICE: Login APROVADO (usuário teste)")
            return True
        if email == "admin@email.com" and senha == "admin123":
            print("AUTH_SERVICE: Login APROVADO (administrador)")
            return True
#ver senha criptografada
        if hasattr(usuario, 'verificar_senha'):
            resultado = usuario.verificar_senha(senha)
            print(f"AUTH_SERVICE: Verificação de senha - Válida? {resultado}") 
            if resultado:
                print(f"AUTH_SERVICE: Login APROVADO (usuário registrado)")
            else:
                print(f"AUTH_SERVICE: Senha incorreta para usuário registrado")
            return resultado
        
        print("AUTH_SERVICE: Login FALHOU - Método de verificação não disponível")
        return False
    
    def criar_usuario(self, nome, email, senha, birthdate, tipo="comum"):
        try:
            print(f"AUTH_SERVICE: Criando novo usuário - {email}")
            #ver se email ja existe
            if self.get_usuario_por_email(email):
                print(f"AUTH_SERVICE: Email já cadastrado - {email}")
                return False
            users = self.user_model.get_all()
            last_id = max([u.id for u in users], default=0)
            new_id = last_id + 1
            if tipo == "admin":
                novo_usuario = Administrador(
                    id=new_id,
                    nome=nome,
                    email=email,
                    senha=senha,
                    birthdate=birthdate
                )
            else:
                novo_usuario = UsuarioComum(
                    id=new_id,
                    nome=nome,
                    email=email,
                    senha=senha,
                    birthdate=birthdate
                )
            
            self.user_model.add_user(novo_usuario)
            print(f"AUTH_SERVICE: Novo usuário criado com sucesso - {email}")
            return True
            
        except Exception as e:
            print(f"AUTH_SERVICE: Erro ao criar usuário - {e}")
            return False