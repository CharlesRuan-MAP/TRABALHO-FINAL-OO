import json
import os
from datetime import datetime

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Task:
    def __init__(self, id, title, description, usuario_id=None, projeto_id=None, completed=False):
        self.id = id
        self.title = title
        self.description = description
        self.usuario_id = usuario_id      
        self.projeto_id = projeto_id     
        self.completed = completed
        self.created_at = datetime.now().strftime("%Y-%m-%d %H:%M")
    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
            'usuario_id': self.usuario_id,
            'projeto_id': self.projeto_id,
            'completed': self.completed,
            'created_at': self.created_at
        }
    @classmethod
    def from_dict(cls, data):
        #ver a compatibilidade
        usuario_id = data.get('usuario_id')
        projeto_id = data.get('projeto_id')
        completed = data.get('completed', False)
        created_at = data.get('created_at')
        task = cls(
            id=data['id'],
            title=data['title'],
            description=data['description'],
            usuario_id=usuario_id,
            projeto_id=projeto_id,
            completed=completed
        )
        
        #manter se existir
        if created_at:
            task.created_at = created_at
            
        return task
class TaskModel:
    FILE_PATH = os.path.join(DATA_DIR, 'tasks.json')
    def __init__(self):
        self.tasks = self._load()
    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        try:
            with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
                data = json.load(f)
                print(f"TASK_MODEL: Carregadas {len(data)} tarefas do arquivo")
                return [Task.from_dict(item) for item in data]
        except Exception as e:
            print(f"TASK_MODEL ERRO ao carregar: {e}")
            return []
    def _save(self):
        try:
            with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
                json.dump([t.to_dict() for t in self.tasks], f, indent=4, ensure_ascii=False)
            print(f"TASK_MODEL: Salvas {len(self.tasks)} tarefas")
        except Exception as e:
            print(f"TASK_MODEL ERRO ao salvar: {e}")
    def get_all(self):
        return self.tasks
    def get_by_id(self, task_id):
        return next((t for t in self.tasks if t.id == task_id), None)
    def add_task(self, task):
        self.tasks.append(task)
        self._save()
    def update_task(self, updated_task):
        for i, task in enumerate(self.tasks):
            if task.id == updated_task.id:
                self.tasks[i] = updated_task
                self._save()
                break
    def delete_task(self, task_id):
        self.tasks = [t for t in self.tasks if t.id != task_id]
        self._save()