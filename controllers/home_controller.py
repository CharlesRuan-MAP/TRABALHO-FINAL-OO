from bottle import Bottle
from .base_controller import BaseController
from services.task_service import TaskService
from services.user_service import UserService
from services.projeto_service import ProjetoService

class HomeController(BaseController):
    def __init__(self, app):
        super().__init__(app)
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/', method='GET', callback=self.home_page)
#verificar na home
    def home_page(self):
        try:
            print("HOME_CONTROLLER: Iniciando verificação de sessão...")
            
            usuario_logado = self.usuario_logado()
            usuario_obj = self.get_usuario_atual()
            print(f"HOME_CONTROLLER: usuario_logado = '{usuario_logado}'")
            print(f"HOME_CONTROLLER: usuario_obj = {usuario_obj}")
            if usuario_obj:
                print(f"HOME_CONTROLLER: Tipo de usuario_obj = {type(usuario_obj)}")
                print(f"HOME_CONTROLLER: Atributos do usuario_obj: {[attr for attr in dir(usuario_obj) if not attr.startswith('_')]}")
            
            if usuario_logado and usuario_obj:
                print(f"HOME_CONTROLLER: USUÁRIO LOGADO - {usuario_obj.nome if hasattr(usuario_obj, 'nome') else 'Sem nome'}")
                return self._home_logada(usuario_obj)
            else:
                print("HOME_CONTROLLER: USUÁRIO NÃO LOGADO - Mostrando home pública")
                return self._home_publica()
                          
        except Exception as e:
            print(f"HOME_CONTROLLER ERRO: {e}")
            import traceback
            traceback.print_exc()
            return self._home_publica()

    def _home_logada(self, usuario):
        try:
            print(f"HOME_LOGADA: Iniciando para {usuario.nome}")
            print(f"HOME_LOGADA: Atributos do usuário: {[attr for attr in dir(usuario) if not attr.startswith('_')]}")
            
            task_service = TaskService()
            projeto_service = ProjetoService()
            
            print(f"HOME_LOGADA: Serviços carregados")
            #ver o tipo de usuario
            if not hasattr(usuario, 'tipo'):
                print("HOME_LOGADA: Usuário não tem atributo 'tipo'")
                usuario_tipo = 'comum'
            else:
                usuario_tipo = usuario.tipo
                print(f"HOME_LOGADA: Tipo de usuário confirmado: {usuario_tipo}")
            
#usuario comum
            if usuario_tipo == 'admin':
                print("HOME_LOGADA: Modo ADMIN - carregando todos os dados")
                #adimin
                todas_tasks = task_service.get_all()
                todos_projetos = projeto_service.get_all()
                print(f"ADMIN: Carregadas {len(todas_tasks)} tarefas e {len(todos_projetos)} projetos")
                
                tasks_para_exibir = todas_tasks
                projetos_para_exibir = todos_projetos
                
            else:
                print("HOME_LOGADA: Modo USUÁRIO COMUM - carregando dados próprios")
    #usuario comum
                todas_tasks = task_service.get_all()
                minhas_tasks = [t for t in todas_tasks if getattr(t, 'usuario_id', None) == usuario.id]
                todos_projetos = projeto_service.get_all()
                meus_projetos = [p for p in todos_projetos if getattr(p, 'usuario_id', None) == usuario.id]
                print(f"USUÁRIO: Carregadas {len(minhas_tasks)} tarefas e {len(meus_projetos)} projetos")
                
                tasks_para_exibir = minhas_tasks
                projetos_para_exibir = meus_projetos
            #estatísticas
            total_minhas_tasks = len(tasks_para_exibir)
            total_tasks_concluidas = len([t for t in tasks_para_exibir if getattr(t, 'completed', False)])
            total_meus_projetos = len(projetos_para_exibir)
            
            print(f"HOME_LOGADA: Estatísticas - {total_minhas_tasks} tarefas, {total_tasks_concluidas} concluídas, {total_meus_projetos} projetos")
            #calcular percentual de conclusão
            percentual_concluidas = 0
            if total_minhas_tasks > 0:
                percentual_concluidas = int((total_tasks_concluidas / total_minhas_tasks) * 100)
            #dados
            minhas_tasks_recentes = tasks_para_exibir[:5]
            meus_projetos_recentes = projetos_para_exibir[:3]
            
            print(f"HOME_LOGADA: Renderizando template home_logada")
            return self.render('home_logada',
                              usuario=usuario,
                              minhas_tasks=total_minhas_tasks,
                              tasks_concluidas=total_tasks_concluidas,
                              percentual_concluidas=percentual_concluidas,
                              meus_projetos=total_meus_projetos,
                              minhas_tasks_recentes=minhas_tasks_recentes,
                              meus_projetos_recentes=meus_projetos_recentes)
                              
        except Exception as e:
            print(f"HOME_LOGADA ERRO: {e}")
            import traceback
            traceback.print_exc()
            return self.render('home_simple', 
                             usuario=usuario,
                             mensagem=f"Olá {usuario.nome}! Você está logado como {getattr(usuario, 'tipo', 'usuário')}")

    def _home_publica(self):
        try:
            print("HOME_PÚBLICA: Renderizando home pública")
            
            task_service = TaskService()
            user_service = UserService()
            projeto_service = ProjetoService()
            
            tasks = task_service.get_all()
            users = user_service.get_all()
            projetos = projeto_service.get_all()
            
            return self.render('home_publica', 
                              total_tasks=len(tasks),
                              total_users=len(users),
                              total_projetos=len(projetos))
        except Exception as e:
            print(f"HOME_PÚBLICA ERRO: {e}")
            return "<h1>Sistema de Tarefas</h1><p>Home pública</p><a href='/login'>Login</a>"

home_routes = Bottle()
home_controller = HomeController(home_routes)