from bottle import Bottle, request, response
from .base_controller import BaseController
from services.auth_service import AuthService

class AuthController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.auth_service = AuthService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/login', method=['GET', 'POST'], callback=self.login)
        self.app.route('/logout', method='GET', callback=self.logout)

    def login(self):
        if request.method == 'GET':
            return self.render('login')
        else:
            email = request.forms.get('email')
            senha = request.forms.get('senha')
            
            print(f"AUTH_CONTROLLER: Tentativa de login - Email: '{email}'")
            
            if self.auth_service.fazer_login(email, senha):
                print(f"AUTH_CONTROLLER: Login BEM-SUCEDIDO para {email}")
                
                #CRIAR COOKIE DE SESSÃO
                response.set_cookie('usuario_logado', email, path='/')
                print(f"AUTH_CONTROLLER: Cookie 'usuario_logado' criado: {email}")
                
                return self.redirect('/')
            else:
                print("AUTH_CONTROLLER: Login FALHOU")
                return self.render('login', erro="Email ou senha incorretos")

    def logout(self):
        print("AUTH_CONTROLLER: Fazendo logout")
        response.delete_cookie('usuario_logado')
        #REDIRECIONAR PARA HOME PUBLICA EM VEZ DE LOGIN
        return self.redirect('/')

auth_routes = Bottle()
auth_controller = AuthController(auth_routes)