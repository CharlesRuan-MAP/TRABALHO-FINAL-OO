%rebase('layout', title=projeto.nome)

<style>
.projeto-detalhes {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
}

.projeto-header {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 30px;
}

.projeto-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 20px;
    margin: 25px 0;
}

.stat-card {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
}

.stat-number {
    font-size: 2em;
    font-weight: bold;
    color: #007bff;
    display: block;
}

.stat-label {
    color: #666;
    font-size: 0.9em;
}

.tarefas-section {
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.btn-sm {
    padding: 8px 15px;
    background: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 0.9em;
}

.tarefa-item {
    display: flex;
    align-items: center;
    padding: 15px;
    margin-bottom: 10px;
    background: #f8f9fa;
    border-radius: 8px;
    border-left: 4px solid #007bff;
}

.tarefa-item.completed {
    opacity: 0.7;
    background: #e8f5e8;
    border-left-color: #28a745;
}

.tarefa-checkbox {
    margin-right: 15px;
}

.tarefa-content {
    flex-grow: 1;
}

.tarefa-title {
    font-weight: bold;
    margin-bottom: 5px;
}

.tarefa-description {
    color: #666;
    font-size: 0.9em;
}

.tarefa-actions {
    display: flex;
    gap: 10px;
}

.empty-state {
    text-align: center;
    padding: 40px;
    color: #666;
}
</style>

<div class="projeto-detalhes">
    <!-- Cabeçalho do Projeto -->
    <div class="projeto-header">
        <div style="display: flex; justify-content: space-between; align-items: start;">
            <div>
                <h1> {{projeto.nome}}</h1>
                <p style="color: #666; margin-top: 10px;">{{projeto.descricao}}</p>
                <p style="color: #999; font-size: 0.9em; margin-top: 5px;">
                    Criado em: {{projeto.data_criacao}}
                </p>
            </div>
            <div style="text-align: right;">
                 <a href="/projetos/edit/{{projeto.id}}" class="btn-sm">Editar</a>
            <a href="/projetos" class="btn-sm" style="background: #6c757d;">← Projetos</a>
            <a href="/" class="btn-sm" style="background: #28a745;">Home</a>
    </div>
        
        <!-- Estatísticas -->
        <div class="projeto-stats">
            <div class="stat-card">
                <span class="stat-number">{{total_tarefas}}</span>
                <span class="stat-label">Total de Tarefas</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">{{tarefas_concluidas}}</span>
                <span class="stat-label">Concluídas</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">
                    % if total_tarefas > 0:
                        {{int((tarefas_concluidas / total_tarefas) * 100)}}
                    % else:
                        0
                    % end
                    %
                </span>
                <span class="stat-label">Progresso</span>
            </div>
        </div>
    </div>

    <!-- Lista de Tarefas -->
    <div class="tarefas-section">
        <div class="section-header">
            <h2>Tarefas deste Projeto</h2>
            <a href="/tasks/add?projeto_id={{projeto.id}}" class="btn-sm">➕ Nova Tarefa</a>
        </div>
        
        % if tarefas:
            % for tarefa in tarefas:
            <div class="tarefa-item {{'completed' if tarefa.completed else ''}}">
                <div class="tarefa-checkbox">
                    <form action="/tasks/toggle/{{tarefa.id}}" method="post" style="display: inline;">
                        <button type="submit" class="checkbox" style="background: none; border: none; font-size: 1.2em; cursor: pointer;">
                            {{'✅' if tarefa.completed else '❌'}}
                        </button>
                    </form>
                </div>
                <div class="tarefa-content">
                    <div class="tarefa-title">{{tarefa.title}}</div>
                    <div class="tarefa-description">{{tarefa.description}}</div>
                </div>
                <div class="tarefa-actions">
                    <a href="/tasks/edit/{{tarefa.id}}" class="btn-sm" style="background: #ffc107; color: #000;"></a>
                    <form action="/tasks/delete/{{tarefa.id}}" method="post" 
                          onsubmit="return confirm('Excluir esta tarefa?')" style="display: inline;">
                        <button type="submit" class="btn-sm" style="background: #dc3545;"></button>
                    </form>
                </div>
            </div>
            % end
        % else:
            <div class="empty-state">
                <p>Nenhuma tarefa neste projeto</p>
                <a href="/tasks/add?projeto_id={{projeto.id}}" class="btn-sm">Criar primeira tarefa</a>
            </div>
        % end
    </div>
</div>
