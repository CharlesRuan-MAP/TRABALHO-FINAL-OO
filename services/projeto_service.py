from bottle import request
from models.projeto import ProjetoModel, Projeto
class ProjetoService:
    def __init__(self):
        self.projeto_model = ProjetoModel()
    def get_all(self):
        return self.projeto_model.get_all()
    def get_by_usuario(self, usuario_id):
     #buscar projetos do usuario
        return self.projeto_model.get_by_usuario(usuario_id)
    def save(self):
        last_id = max([p.id for p in self.projeto_model.get_all()], default=0)
        new_id = last_id + 1
        nome = request.forms.get('nome')
        descricao = request.forms.get('descricao')
        usuario_email = request.get_cookie('usuario_logado')
        if usuario_email:
            from services.user_service import UserService
            user_service = UserService()
            usuario = user_service.get_by_email(usuario_email)
            
            if usuario:
                projeto = Projeto(id=new_id, nome=nome, descricao=descricao, usuario_id=usuario.id)
                self.projeto_model.add_projeto(projeto)
                return
        projeto = Projeto(id=new_id, nome=nome, descricao=descricao, usuario_id=1)
        self.projeto_model.add_projeto(projeto)

    def get_by_id(self, projeto_id):
        return self.projeto_model.get_by_id(projeto_id)

    def edit_projeto(self, projeto):
        nome = request.forms.get('nome')
        descricao = request.forms.get('descricao')

        projeto.nome = nome
        projeto.descricao = descricao

        self.projeto_model.update_projeto(projeto)

    def delete_projeto(self, projeto_id):
        # ANTES de excluir o projeto, excluir todas as tarefas associadas
        from services.task_service import TaskService
        task_service = TaskService()
    
        todas_tasks = task_service.get_all()
        tasks_do_projeto = [t for t in todas_tasks if getattr(t, 'projeto_id', None) == projeto_id]
    
        for task in tasks_do_projeto:
            task_service.delete_task(task.id)
            print(f"PROJETO_SERVICE: Excluída tarefa {task.id} do projeto {projeto_id}")
    
        self.projeto_model.delete_projeto(projeto_id)
        print(f"PROJETO_SERVICE: Projeto {projeto_id} excluído com {len(tasks_do_projeto)} tarefas")