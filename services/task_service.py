from bottle import request
from models.task import TaskModel, Task

class TaskService:
    def __init__(self):
        self.task_model = TaskModel()
    def get_all(self):
        tasks = self.task_model.get_all()
        return tasks
    def get_by_usuario(self, usuario_id):
       #buscar projetos do usuario
        todas_tasks = self.task_model.get_all()
        return [t for t in todas_tasks if getattr(t, 'usuario_id', None) == usuario_id]
    def save(self):
        last_id = max([t.id for t in self.task_model.get_all()], default=0)
        new_id = last_id + 1
        title = request.forms.get('title')
        description = request.forms.get('description')
        projeto_id = request.forms.get('projeto_id')  #pegar projeto 
        print(f"TASK_SERVICE: Criando tarefa - '{title}' (Projeto: {projeto_id})")
        #pegar user logado
        usuario_email = request.get_cookie('usuario_logado')
        usuario_id = 1  # Fallback
        
        if usuario_email:
            from services.user_service import UserService
            user_service = UserService()
            usuario = user_service.get_by_email(usuario_email)
            if usuario:
                usuario_id = usuario.id
                print(f"TASK_SERVICE: Associando tarefa ao usuário ID {usuario_id}")
        projeto_id_int = None
        if projeto_id and projeto_id != 'None':
            try:
                projeto_id_int = int(projeto_id)
            except ValueError:
                projeto_id_int = None
        #criar tarefa com usuário e projeto associados
        task = Task(
            id=new_id, 
            title=title, 
            description=description, 
            usuario_id=usuario_id,  
            projeto_id=projeto_id_int 
        )
        self.task_model.add_task(task)
        print(f"TASK_SERVICE: Tarefa criada - ID {new_id}, Projeto {projeto_id_int}")

    def get_by_id(self, task_id):
        return self.task_model.get_by_id(task_id)

    def edit_task(self, task):
        title = request.forms.get('title')
        description = request.forms.get('description')
        projeto_id = request.forms.get('projeto_id')  #atualizar projeto 

        task.title = title
        task.description = description
        if projeto_id and projeto_id != 'None':
            try:
                task.projeto_id = int(projeto_id)
            except ValueError:
                task.projeto_id = None
        else:
            task.projeto_id = None

        self.task_model.update_task(task)
    def delete_task(self, task_id):
        self.task_model.delete_task(task_id)

    def toggle_complete(self, task_id):
        task = self.task_model.get_by_id(task_id)
        if task:
            print(f"TASK_SERVICE: Alternando tarefa {task_id} de {task.completed} para {not task.completed}")
            task.completed = not task.completed
            self.task_model.update_task(task)
            print(f"TASK_SERVICE: Tarefa {task_id} agora está {task.completed}")