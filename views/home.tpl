%rebase('layout', title='Sistema de Tarefas - Home')

<section class="dashboard">
    <div class="welcome-section">
        <h1>📋 Sistema de Gestão de Tarefas</h1>
        <p class="subtitle">Organize suas tarefas de forma simples e eficiente</p>
    </div>

    <div class="stats-cards">
        <div class="stat-card">
            <div class="stat-number">{{total_tasks}}</div>
            <div class="stat-label">Tarefas no Sistema</div>
            <a href="/tasks" class="btn btn-primary">Ver Todas</a>
        </div>
        
        <div class="stat-card">
            <div class="stat-number">{{total_users}}</div>
            <div class="stat-label">Usuários Cadastrados</div>
            <a href="/users" class="btn btn-secondary">Ver Usuários</a>
        </div>

        <div class="stat-card">
            <div class="stat-number">{{total_projetos}}</div>
            <div class="stat-label">Projetos Criados</div>
            <a href="/projetos" class="btn btn-primary">Ver Projetos</a>
        </div>
    </div>

    <div class="recent-sections">
        <div class="recent-tasks">
            <h2>📝 Tarefas Recentes</h2>
            % if tasks:
                <div class="task-list">
                % for task in tasks:
                    <div class="task-item {{'completed' if task.completed else 'pending'}}">
                        <span class="task-status">
                            {{'✅' if task.completed else '❌'}}
                        </span>
                        <span class="task-title">{{task.title}}</span>
                        <span class="task-date">{{task.created_at.split(' ')[0] if task.created_at else ''}}</span>
                    </div>
                % end
                </div>
            % else:
                <p class="no-data">Nenhuma tarefa cadastrada ainda.</p>
            % end
            <a href="/tasks/add" class="btn btn-primary">➕ Nova Tarefa</a>
        </div>

        <div class="recent-users">
            <h2>👥 Usuários Recentes</h2>
            % if users:
                <div class="user-list">
                % for user in users:
                    <div class="user-item">
                        <span class="user-name">
                            {{user.nome if hasattr(user, 'nome') else user.name if hasattr(user, 'name') else 'Usuário'}}
                        </span>
                        <span class="user-email">{{user.email}}</span>
                    </div>
                % end
                </div>
            % else:
                <p class="no-data">Nenhum usuário cadastrado.</p>
            % end
            <a href="/users/add" class="btn btn-secondary">➕ Novo Usuário</a>
        </div>
    </div>
</section>