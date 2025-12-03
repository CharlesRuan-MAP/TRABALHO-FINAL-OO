from bottle import Bottle, request
from .base_controller import BaseController
from services.task_service import TaskService

class TaskController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.setup_routes()
        self.task_service = TaskService()
    def setup_routes(self):
        self.app.route('/tasks', method='GET', callback=self.list_tasks)
        self.app.route('/tasks/add', method=['GET', 'POST'], callback=self.add_task)
        self.app.route('/tasks/edit/<task_id:int>', method=['GET', 'POST'], callback=self.edit_task)
        self.app.route('/tasks/delete/<task_id:int>', method='POST', callback=self.delete_task)
        self.app.route('/tasks/toggle/<task_id:int>', method='POST', callback=self.toggle_task)
    def list_tasks(self):
        if not self.usuario_logado():
            return self.redirect('/login')
        usuario = self.get_usuario_atual()
        if usuario and hasattr(usuario, 'tipo') and usuario.tipo == 'admin':
            tasks = self.task_service.get_all()
            print(f"ADMIN: Vendo TODAS as {len(tasks)} tarefas do sistema")
        else:
            tasks = self.task_service.get_by_usuario(usuario.id)
            print(f"USUÁRIO: Vendo {len(tasks)} tarefas próprias")
        return self.render('tasks', tasks=tasks)
    def add_task(self):
        if not self.usuario_logado():
            return self.redirect('/login')
        if request.method == 'GET':
            from services.projeto_service import ProjetoService
            projeto_service = ProjetoService()
            usuario = self.get_usuario_atual()
            if usuario:
                projetos = projeto_service.get_by_usuario(usuario.id)
            else:
                projetos = []
            return self.render('task_form', task=None, action="/tasks/add", projetos=projetos)
        else:
            self.task_service.save()
            self.redirect('/tasks')
    def edit_task(self, task_id):
        if not self.usuario_logado():
            return self.redirect('/login')
        task = self.task_service.get_by_id(task_id)
        if not task:
            return "Tarefa não encontrada"
        if request.method == 'GET':
            from services.projeto_service import ProjetoService
            projeto_service = ProjetoService()
            usuario = self.get_usuario_atual()
            if usuario:
                projetos = projeto_service.get_by_usuario(usuario.id)
            else:
                projetos = []
            return self.render('task_form', task=task, action=f"/tasks/edit/{task_id}", projetos=projetos)
        else:
            self.task_service.edit_task(task)
            self.redirect('/tasks')
    def delete_task(self, task_id):
        if not self.usuario_logado():
            return self.redirect('/login')
        self.task_service.delete_task(task_id)
        self.redirect('/tasks')
    def toggle_task(self, task_id):
        if not self.usuario_logado():
            return self.redirect('/login')
        from bottle import request
        referer = request.environ.get('HTTP_REFERER', '/')
        self.task_service.toggle_complete(task_id)
        return self.redirect(referer)

task_routes = Bottle()
task_controller = TaskController(task_routes)