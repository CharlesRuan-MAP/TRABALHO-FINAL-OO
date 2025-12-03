from bottle import request
from models.user import UserModel, UsuarioComum

class UserService:
    def __init__(self):
        self.user_model = UserModel()

    def get_all(self):
        users = self.user_model.get_all()
        return users

    def get_by_email(self, email):
        """Busca usuário por email - COMPATÍVEL COM FORMATOS ANTIGO/NOVO"""
        users = self.user_model.get_all()
        for user in users:
            user_email = getattr(user, 'email', None)
            if user_email == email:
                return user
        return None

    def save(self):
        last_id = max([u.id for u in self.user_model.get_all()], default=0)
        new_id = last_id + 1
        name = request.forms.get('name')
        email = request.forms.get('email')
        birthdate = request.forms.get('birthdate')
        senha = "123456"

        user = UsuarioComum(id=new_id, nome=name, email=email, senha=senha, birthdate=birthdate)
        self.user_model.add_user(user)

    def get_by_id(self, user_id):
        return self.user_model.get_by_id(user_id)

    def edit_user(self, user):
        name = request.forms.get('name')
        email = request.forms.get('email')
        birthdate = request.forms.get('birthdate')

        user.nome = name
        user.email = email
        user.birthdate = birthdate

        self.user_model.update_user(user)

    def delete_user(self, user_id):
        self.user_model.delete_user(user_id)