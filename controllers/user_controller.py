from bottle import Bottle, request
from .base_controller import BaseController
from services.user_service import UserService
from models.user import UsuarioComum, Administrador

class UserController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.user_service = UserService()
        self.setup_routes()
    def setup_routes(self):
        self.app.route('/admin/usuarios', method='GET', callback=self.list_users)
        self.app.route('/admin/usuarios/add', method=['GET', 'POST'], callback=self.add_user)
        self.app.route('/admin/usuarios/edit/<user_id:int>', method=['GET', 'POST'], callback=self.edit_user)
        self.app.route('/admin/usuarios/delete/<user_id:int>', method='POST', callback=self.delete_user)
        self.app.route('/admin/usuarios/toggle-admin/<user_id:int>', method='POST', callback=self.toggle_admin)
    def _verificar_admin(self):
        usuario = self.get_usuario_atual()
        if not usuario or not hasattr(usuario, 'tipo') or usuario.tipo != 'admin':
            return False
        return True
    def list_users(self):
        if not self.usuario_logado():
            return self.redirect('/login')
        if not self._verificar_admin():
            return self.redirect('/?erro=Acesso negado. Apenas administradores.')
        users = self.user_service.get_all()
        for user in users:
            if not hasattr(user, 'tipo'):
                user.tipo = 'comum'  
        return self.render('admin_usuarios', users=users)
    def add_user(self):
        if not self._verificar_admin():
            return self.redirect('/?erro=Acesso negado.') 
        if request.method == 'GET':
            return self.render('admin_user_form', user=None, action="/admin/usuarios/add")
        else:
            nome = request.forms.get('nome')
            email = request.forms.get('email')
            senha = request.forms.get('senha') or "123456"
            birthdate = request.forms.get('birthdate')
            tipo = request.forms.get('tipo', 'comum')
            if self.user_service.get_by_email(email):
                return self.render('admin_user_form', user=None, action="/admin/usuarios/add", 
                                 erro="Email já cadastrado")
            users = self.user_service.get_all()
            last_id = max([u.id for u in users], default=0)
            new_id = last_id + 1
            if tipo == 'admin':
                user = Administrador(id=new_id, nome=nome, email=email, senha=senha, birthdate=birthdate)
            else:
                user = UsuarioComum(id=new_id, nome=nome, email=email, senha=senha, birthdate=birthdate)
            self.user_service.user_model.add_user(user)
            return self.redirect('/admin/usuarios')
    def edit_user(self, user_id):
        if not self._verificar_admin():
            return self.redirect('/?erro=Acesso negado.')
        user = self.user_service.get_by_id(user_id)
        if not user:
            return "Usuário não encontrado"
        if request.method == 'GET':
            return self.render('admin_user_form', user=user, action=f"/admin/usuarios/edit/{user_id}")
        else:
            user.nome = request.forms.get('nome')
            user.email = request.forms.get('email')
            user.birthdate = request.forms.get('birthdate')
            nova_senha = request.forms.get('senha') 
            if nova_senha:
                if hasattr(user, '_senha'):
                    user._senha = user._criptografar_senha(nova_senha)
            self.user_service.user_model.update_user(user)
            return self.redirect('/admin/usuarios')
    def delete_user(self, user_id):
        if not self._verificar_admin():
            return self.redirect('/?erro=Acesso negado.')
        usuario_atual = self.get_usuario_atual()
        if usuario_atual and usuario_atual.id == user_id:
            return self.redirect('/admin/usuarios?erro=Você não pode excluir sua própria conta.')
        self.user_service.delete_user(user_id)
        return self.redirect('/admin/usuarios')
    def toggle_admin(self, user_id):
        if not self._verificar_admin():
            return self.redirect('/?erro=Acesso negado.')
        user = self.user_service.get_by_id(user_id)
        if user and hasattr(user, 'tipo'):
            if user.tipo == 'admin':
                novo_user = UsuarioComum(id=user.id, nome=user.nome, email=user.email, senha="temp", birthdate=user.birthdate)
                novo_user._senha = user.get_senha_criptografada()
            else:
                novo_user = Administrador(id=user.id, nome=user.nome, email=user.email, senha="temp", birthdate=user.birthdate)
                novo_user._senha = user.get_senha_criptografada()
            self.user_service.user_model.update_user(novo_user)
        
        return self.redirect('/admin/usuarios')

user_routes = Bottle()
user_controller = UserController(user_routes)