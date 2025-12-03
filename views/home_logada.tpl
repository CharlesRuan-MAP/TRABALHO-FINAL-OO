%rebase('layout', title='Dashboard')

<style>
.dashboard-logada {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.dashboard-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
}

.welcome-user h1 {
    margin: 0;
    color: #333;
    font-size: 1.8em;
}

.welcome-user p {
    margin: 5px 0 0 0;
    color: #666;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 15px;
}

.user-badge {
    padding: 8px 15px;
    border-radius: 20px;
    font-size: 0.9em;
    font-weight: bold;
}

.user-badge.admin {
    background: #fff3cd;
    color: #856404;
    border: 1px solid #ffeaa7;
}

.user-badge.comum {
    background: #d1ecf1;
    color: #0c5460;
    border: 1px solid #bee5eb;
}

.btn-logout {
    background: #dc3545;
    color: white;
    padding: 8px 15px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 0.9em;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    text-align: center;
    border-left: 4px solid #007bff;
}

.stat-icon {
    font-size: 2.5em;
    margin-bottom: 10px;
}

.stat-number {
    font-size: 2.2em;
    font-weight: bold;
    color: #007bff;
    display: block;
}

.stat-label {
    color: #666;
    font-size: 0.9em;
}

.dashboard-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
}

.content-card {
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.card-header h2 {
    margin: 0;
    color: #333;
}

.btn-sm {
    padding: 6px 12px;
    background: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-size: 0.8em;
}

.task-item, .projeto-item {
    display: flex;
    align-items: center;
    padding: 12px;
    margin-bottom: 8px;
    background: #f8f9fa;
    border-radius: 6px;
}

.task-checkbox {
    margin-right: 10px;
}

.checkbox {
    background: none;
    border: none;
    font-size: 1.2em;
    cursor: pointer;
}

.task-content {
    flex-grow: 1;
}

.task-title {
    font-weight: bold;
    margin-bottom: 3px;
}

.task-project {
    font-size: 0.8em;
    color: #666;
}

.projeto-icon {
    font-size: 1.5em;
    margin-right: 10px;
}

.projeto-info {
    flex-grow: 1;
}

.projeto-name {
    font-weight: bold;
    margin-bottom: 3px;
}

.projeto-meta {
    font-size: 0.8em;
    color: #666;
}

.empty-state {
    text-align: center;
    padding: 30px;
    color: #666;
}

.empty-state p {
    margin-bottom: 15px;
}

.admin-section {
    background: #f8f9fa;
    padding: 25px;
    border-radius: 10px;
    margin-top: 25px;
}

.quick-actions {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 15px;
    margin-top: 15px;
}

.quick-action {
    background: white;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
    text-decoration: none;
    color: #333;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    transition: transform 0.2s;
}

.quick-action:hover {
    transform: translateY(-2px);
    text-decoration: none;
    color: #333;
}

.action-icon {
    font-size: 2em;
    margin-bottom: 8px;
}
</style>

<div class="dashboard-logada">
    <!-- Cabeçalho -->
    <div class="dashboard-header">
        <div class="welcome-user">
            <h1>Olá, {{usuario.nome}}!</h1>
            <p>Bem-vindo(a) de volta ao seu workspace</p>
        </div>
        <div class="user-info">
            <span class="user-badge {{usuario.tipo}}">
                {{'Administrador' if usuario.tipo == 'admin' else 'Usuário Comum'}}
            </span>
            <a href="/tasks" class="btn-sm" style="background: #28a745; color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; margin-right: 10px;">
          Ver Todas Tarefas
    </a>
    <a href="/projetos" class="btn-sm" style="background: #17a2b8; color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; margin-right: 10px;">
          Ver Projetos
    </a>
            <a href="/logout" class="btn-logout">Sair</a>
        </div>
    </div>

    <!-- Estatísticas -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon"></div>
            <div class="stat-number">{{minhas_tasks}}</div>
            <div class="stat-label">Minhas Tarefas</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon"></div>
            <div class="stat-number">{{tasks_concluidas}}</div>
            <div class="stat-label">Concluídas</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon"></div>
            <div class="stat-number">{{meus_projetos}}</div>
            <div class="stat-label">Meus Projetos</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon"></div>
            <div class="stat-number">{{percentual_concluidas}}%</div>
            <div class="stat-label">Taxa de Conclusão</div>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="dashboard-content">
        <!-- Tarefas Recentes -->
        <div class="content-card">
            <div class="card-header">
                <h2>Minhas Tarefas Recentes</h2>
                <a href="/tasks/add" class="btn-sm">+ Nova</a>
            </div>
            
            % if minhas_tasks_recentes:
                % for task in minhas_tasks_recentes:
                <div class="task-item {{'completed' if task.completed else ''}}">
                    <div class="task-checkbox">
                        <form action="/tasks/toggle/{{task.id}}" method="post" style="display: inline;">
                            <button type="submit" class="checkbox">
                                {{'✅' if task.completed else '❌'}}
                            </button>
                        </form>
                    </div>
                    <div class="task-content">
                        <div class="task-title">{{task.title}}</div>
                        % if hasattr(task, 'projeto_id') and task.projeto_id:
<div class="task-project">
    % for projeto in meus_projetos_recentes:
        % if projeto.id == task.projeto_id:
             {{projeto.nome}} 
        % end
    % end
</div>
% end
                    </div>
                </div>
                % end
            % else:
                <div class="empty-state">
                    <p> Nenhuma tarefa encontrada</p>
                    <a href="/tasks/add" class="btn-sm">Criar primeira tarefa</a>
                </div>
            % end
        </div>

        <!-- Projetos Recentes -->
        <div class="content-card">
            <div class="card-header">
                <h2> Meus Projetos</h2>
                <a href="/projetos/add" class="btn-sm">+ Novo</a>
            </div>
            
            % if meus_projetos_recentes:
                % for projeto in meus_projetos_recentes:
                <div class="projeto-item">
                    <div class="projeto-icon"></div>
                    <div class="projeto-info">
                        <div class="projeto-name">{{projeto.nome}}</div>
                        <div class="projeto-meta">Criado em: {{projeto.data_criacao.split(' ')[0] if projeto.data_criacao else 'N/A'}}</div>
                    </div>
                    <a href="/projetos" class="projeto-link">→</a>
                </div>
                % end
            % else:
                <div class="empty-state">
                    <p>Nenhum projeto criado</p>
                    <a href="/projetos/add" class="btn-sm">Criar primeiro projeto</a>
                </div>
            % end
        </div>
    </div>

    <!-- Seção Admin -->
    % if usuario.tipo == 'admin':
    <div class="admin-section">
        <h3>Ações de Administrador</h3>
        <div class="quick-actions">
            <a href="/admin/usuarios" class="quick-action">
                <div class="action-icon"></div>
                <span>Gerenciar Usuários</span>
            </a>
            <a href="/tasks" class="quick-action">
                <div class="action-icon"></div>
                <span>Ver Todas Tarefas</span>
            </a>
            <a href="/projetos" class="quick-action">
                <div class="action-icon"></div>
                <span>Ver Todos Projetos</span>
            </a>
        </div>
    </div>
    % end
</div>