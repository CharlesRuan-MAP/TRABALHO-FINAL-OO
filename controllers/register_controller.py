from bottle import Bottle, request, response
from .base_controller import BaseController
from services.user_service import UserService
from models.user import UsuarioComum

class RegisterController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.user_service = UserService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/register', method=['GET', 'POST'], callback=self.register)
        self.app.route('/registro', method=['GET', 'POST'], callback=self.register)

    def register(self):
        if request.method == 'GET':
            return self.render('register')
        else:
            nome = request.forms.get('nome')
            email = request.forms.get('email')
            senha = request.forms.get('senha')
            confirmar_senha = request.forms.get('confirmar_senha')
            birthdate = request.forms.get('birthdate')
            
            print(f"REGISTER: Tentativa de registro - {email}")
            #Validações
            if not nome or not email or not senha:
                return self.render('register', erro="Todos os campos são obrigatórios")
            if senha != confirmar_senha:
                return self.render('register', erro="As senhas não coincidem")
            if len(senha) < 6:
                return self.render('register', erro="A senha deve ter pelo menos 6 caracteres")
            #ver se ja tem esse email
            if self.user_service.get_by_email(email):
                return self.render('register', erro="Este email já está cadastrado")
            try:
                #novo user
                users = self.user_service.get_all()
                last_id = max([u.id for u in users], default=0)
                new_id = last_id + 1  
                novo_usuario = UsuarioComum(
                    id=new_id,
                    nome=nome,
                    email=email,
                    senha=senha,  #criptografar 
                    birthdate=birthdate
                )
                print(f"REGISTER: Senha criptografada: {novo_usuario.get_senha_criptografada()}")

                self.user_service.user_model.add_user(novo_usuario)
                print(f"REGISTER: Novo usuário criado - {email}")
                usuario_salvo = self.user_service.get_by_email(email)
                if usuario_salvo:
                    print(f"REGISTER: Usuário confirmado no banco - {usuario_salvo.nome}")
                else:
                    print(f"REGISTER: ERRO - Usuário não encontrado após criação")    
                #login automatic
                print(f"REGISTER: Fazendo login automático para {email}")
                response.set_cookie('usuario_logado', email, path='/')
                print(f"REGISTER: Cookie 'usuario_logado' definido: {email}")
                #mandar pra HOME
                print("REGISTER: Redirecionando para /")
                return self.redirect('/')
            except Exception as e:
                print(f"REGISTER ERRO: {e}")
                import traceback
                traceback.print_exc()
                return self.render('register', erro="Erro ao criar conta")

register_routes = Bottle()
register_controller = RegisterController(register_routes)