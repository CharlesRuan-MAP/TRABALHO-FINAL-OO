import json
import os
from datetime import datetime

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Projeto:
    def __init__(self, id, nome, descricao, usuario_id, data_criacao=None):
        self.id = id
        self.nome = nome
        self.descricao = descricao
        self.usuario_id = usuario_id 
        self.data_criacao = data_criacao or datetime.now().strftime("%Y-%m-%d %H:%M")
    def __repr__(self):
        return f"Projeto(id={self.id}, nome='{self.nome}', usuario_id={self.usuario_id})"
    def to_dict(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'descricao': self.descricao,
            'usuario_id': self.usuario_id,
            'data_criacao': self.data_criacao
        }
    @classmethod
    def from_dict(cls, data):
        return cls(**data)

class ProjetoModel:
    FILE_PATH = os.path.join(DATA_DIR, 'projetos.json')
    def __init__(self):
        self.projetos = self._load()
    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return [Projeto.from_dict(item) for item in data]
    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([p.to_dict() for p in self.projetos], f, indent=4, ensure_ascii=False)
    def get_all(self):
        return self.projetos
    def get_by_id(self, projeto_id):
        return next((p for p in self.projetos if p.id == projeto_id), None)
    def get_by_usuario(self, usuario_id):
        return [p for p in self.projetos if p.usuario_id == usuario_id]
    def add_projeto(self, projeto):
        self.projetos.append(projeto)
        self._save()
    def update_projeto(self, updated_projeto):
        for i, projeto in enumerate(self.projetos):
            if projeto.id == updated_projeto.id:
                self.projetos[i] = updated_projeto
                self._save()
                break
    def delete_projeto(self, projeto_id):
        self.projetos = [p for p in self.projetos if p.id != projeto_id]
        self._save()