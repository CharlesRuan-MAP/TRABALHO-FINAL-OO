import json
import os
from dataclasses import dataclass, asdict
from typing import List
import hashlib
from abc import ABC, abstractmethod

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')
#class abastrata
class UsuarioBase(ABC):
    def __init__(self, id, nome, email, senha, tipo):
        self.id = id
        self.nome = nome
        self.email = email
        self._senha = self._criptografar_senha(senha)  #encapsularmento
        self.tipo = tipo
    #metodo privado
    def _criptografar_senha(self, senha):
        return hashlib.sha256(senha.encode()).hexdigest()
    #encapsualr Getter
    def get_senha_criptografada(self):
        return self._senha
    def verificar_senha(self, senha):
        return self._senha == self._criptografar_senha(senha)
    #abstract, metodo abstrato
    @abstractmethod
    def pode_gerenciar_usuarios(self):
        pass
    @abstractmethod
    def get_permissoes(self):
        pass
#herança, usuario comum
class UsuarioComum(UsuarioBase):
    def __init__(self, id, nome, email, senha, birthdate):
        super().__init__(id, nome, email, senha, "comum")
        self.birthdate = birthdate
    #polimorfismo
    def pode_gerenciar_usuarios(self):
        return False
    def get_permissoes(self):
        return ["ver_tarefas", "criar_tarefas", "editar_proprias_tarefas"]
    def to_dict(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'email': self.email,
            'senha': self.get_senha_criptografada(),
            'tipo': self.tipo,
            'birthdate': self.birthdate
        }
#Admin
class Administrador(UsuarioBase):
    def __init__(self, id, nome, email, senha, birthdate):
        super().__init__(id, nome, email, senha, "admin")
        self.birthdate = birthdate
    def pode_gerenciar_usuarios(self):
        return True
    def get_permissoes(self):
        return ["ver_tarefas", "criar_tarefas", "editar_todas_tarefas", "gerenciar_usuarios", "gerenciar_projetos"]
    def to_dict(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'email': self.email,
            'senha': self.get_senha_criptografada(),
            'tipo': self.tipo,
            'birthdate': self.birthdate
        }
#manter classe original
class User:
    def __init__(self, id, name, email, birthdate):
        self.id = id
        self.name = name
        self.email = email
        self.birthdate = birthdate
    def __repr__(self):
        return (f"User(id={self.id}, name='{self.name}', email='{self.email}', "
                f"birthdate='{self.birthdate}')")
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'birthdate': self.birthdate
        }
    @classmethod
    def from_dict(cls, data):
        return cls(**data)
class UserModel:
    FILE_PATH = os.path.join(DATA_DIR, 'users.json')
    def __init__(self):
        self.users = self._load()
    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            usuarios = []
            for item in data:
                if 'tipo' in item:
                    if item['tipo'] == 'admin':
                        user = Administrador(
                            id=item['id'],
                            nome=item['nome'],
                            email=item['email'],
                            senha="temp",  
                            birthdate=item['birthdate']
                        )
                        user._senha = item['senha']  #manter senha criptografada
                    else:
                        user = UsuarioComum(
                            id=item['id'],
                            nome=item['nome'],
                            email=item['email'],
                            senha="temp",
                            birthdate=item['birthdate']
                        )
                        user._senha = item['senha']
                    usuarios.append(user)
                else:
                    #compatibilidade com usuarios antigos
                    usuarios.append(User.from_dict(item))
            return usuarios
    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            dados_para_salvar = []
            for user in self.users:
                if hasattr(user, 'to_dict'):
                    dados_para_salvar.append(user.to_dict())
                else:
                    #users antigos
                    dados_para_salvar.append({
                        'id': user.id,
                        'name': user.name,
                        'email': user.email,
                        'birthdate': user.birthdate
                    })
            json.dump(dados_para_salvar, f, indent=4, ensure_ascii=False)
    # Mantém os outros métodos iguais
    def get_all(self):
        return self.users
    def get_by_id(self, user_id: int):
        return next((u for u in self.users if u.id == user_id), None)
    def get_by_email(self, email: str):
        return next((u for u in self.users if u.email == email), None)
    def add_user(self, user):
        self.users.append(user)
        self._save()
    def update_user(self, updated_user):
        for i, user in enumerate(self.users):
            if user.id == updated_user.id:
                self.users[i] = updated_user
                self._save()
                break
    def delete_user(self, user_id: int):
        self.users = [u for u in self.users if u.id != user_id]
        self._save()