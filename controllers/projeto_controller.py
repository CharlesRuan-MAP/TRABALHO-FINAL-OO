from bottle import Bottle, request
from .base_controller import BaseController
from services.projeto_service import ProjetoService

class ProjetoController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.projeto_service = ProjetoService()
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/projetos', method='GET', callback=self.list_projetos)
        self.app.route('/projetos/add', method=['GET', 'POST'], callback=self.add_projeto)
        self.app.route('/projetos/edit/<projeto_id:int>', method=['GET', 'POST'], callback=self.edit_projeto)
        self.app.route('/projetos/delete/<projeto_id:int>', method='POST', callback=self.delete_projeto)
        self.app.route('/projetos/<projeto_id:int>', method='GET', callback=self.detalhes_projeto)

    def list_projetos(self):
        #Proteger rota, só usuários logados
        if not self.usuario_logado():
            return self.redirect('/login')
        
        usuario = self.get_usuario_atual()

        if usuario and hasattr(usuario, 'tipo') and usuario.tipo == 'admin':
            #ADMIN: VER TODOS OS PROJETOS
            projetos = self.projeto_service.get_all()
            print(f"ADMIN: Vendo TODOS os {len(projetos)} projetos do sistema")
        else:
            #VER APENAS SEUS PROJETOS
            projetos = self.projeto_service.get_by_usuario(usuario.id)
            print(f"USUÁRIO: Vendo {len(projetos)} projetos próprios")

        return self.render('projetos', projetos=projetos)
        
    def add_projeto(self):
        if not self.usuario_logado():
            return self.redirect('/login')
        if request.method == 'GET':
            return self.render('projeto_form', projeto=None, action="/projetos/add")
        else:
            self.projeto_service.save()
            self.redirect('/projetos')

    def edit_projeto(self, projeto_id):
        if not self.usuario_logado():
            return self.redirect('/login')
        projeto = self.projeto_service.get_by_id(projeto_id)
        if not projeto:
            return "Projeto não encontrado"

        if request.method == 'GET':
            return self.render('projeto_form', projeto=projeto, action=f"/projetos/edit/{projeto_id}")
        else:
            self.projeto_service.edit_projeto(projeto)
            self.redirect('/projetos')

    def delete_projeto(self, projeto_id):
        if not self.usuario_logado():
            return self.redirect('/login')
        self.projeto_service.delete_projeto(projeto_id)
        self.redirect('/projetos')

    #detalhes das tarefas
    def detalhes_projeto(self, projeto_id):
        if not self.usuario_logado():
            return self.redirect('/login')
    
        projeto = self.projeto_service.get_by_id(projeto_id)
        if not projeto:
            return "Projeto não encontrado"
    #VER SE O PROJETO PERTENCE AO USUÁRIO LOGADO
        usuario = self.get_usuario_atual()
        if projeto.usuario_id != usuario.id:
            return self.redirect('/projetos?erro=Acesso negado')
    #BUSCAR TAREFAS DESTE PROJETO
        from services.task_service import TaskService
        task_service = TaskService()
        todas_tasks = task_service.get_all()
        tarefas_do_projeto = [t for t in todas_tasks if getattr(t, 'projeto_id', None) == projeto_id]
    
        return self.render('projeto_detalhes', 
                      projeto=projeto, 
                      tarefas=tarefas_do_projeto,
                      total_tarefas=len(tarefas_do_projeto),
                      tarefas_concluidas=len([t for t in tarefas_do_projeto if t.completed]))
#criar rotas
projeto_routes = Bottle()
projeto_controller = ProjetoController(projeto_routes)