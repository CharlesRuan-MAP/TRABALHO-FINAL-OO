%rebase('layout', title='Tarefas')

<style>
.tasks-section {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee;
}

.section-title {
    margin: 0;
    color: #333;
    font-size: 1.8em;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    border: none;
    cursor: pointer;
    text-align: center;
    margin-left: 10px;
}

.btn-primary {
    background: #007bff;
    color: white;
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-home {
    background: #28a745;
    color: white;
}

.btn-sm {
    padding: 6px 12px;
    font-size: 0.8em;
}

.btn-edit {
    background: #ffc107;
    color: #212529;
}

.btn-danger {
    background: #dc3545;
    color: white;
}

.btn-toggle {
    background: #17a2b8;
    color: white;
}

.table-container {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
}

.styled-table th,
.styled-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.styled-table th {
    background: #f8f9fa;
    font-weight: bold;
    color: #333;
}

.styled-table tr:hover {
    background: #f8f9fa;
}

.actions {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.task-completed {
    opacity: 0.7;
    background: #e8f5e8;
}

.status-completed {
    color: #28a745;
    font-weight: bold;
}

.status-pending {
    color: #ffc107;
    font-weight: bold;
}

.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: #666;
}

.empty-state p {
    margin-bottom: 20px;
    font-size: 1.1em;
}

.header-actions {
    display: flex;
    gap: 10px;
    align-items: center;
}
</style>

<section class="tasks-section">
    <div class="section-header">
        <h1 class="section-title">Minhas Tarefas</h1>
        <div class="header-actions">
            <a href="/" class="btn btn-home">Home</a>
            <a href="/tasks/add" class="btn btn-primary">➕ Nova Tarefa</a>
        </div>
    </div>

    <div class="table-container">
        % if tasks:
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Status</th>
                    <th>Título</th>
                    <th>Descrição</th>
                    <th>Data</th>
                    <th>Ações</th>
                </tr>
            </thead>

            <tbody>
                % for task in tasks:
                <tr class="{{'task-completed' if task.completed else ''}}">
                    <td>
                        % if task.completed:
                        <span class="status-completed">✅ Concluída</span>
                        % else:
                        <span class="status-pending">⏳ Pendente</span>
                        % end
                    </td>
                    <td>{{task.title}}</td>
                    <td>{{task.description}}</td>
                    <td>{{task.created_at.split(' ')[0] if task.created_at else ''}}</td>
                    
                    <td class="actions">
                        <form action="/tasks/toggle/{{task.id}}" method="post">
                            <button type="submit" class="btn btn-sm btn-toggle">
                                {{'❌ Marcar' if not task.completed else '✅ Desmarcar'}}
                            </button>
                        </form>
                        
                        <a href="/tasks/edit/{{task.id}}" class="btn btn-sm btn-edit"> Editar</a>
                        
                        <form action="/tasks/delete/{{task.id}}" method="post" 
                              onsubmit="return confirm('Tem certeza que deseja excluir esta tarefa?')">
                            <button type="submit" class="btn btn-sm btn-danger">Excluir</button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
        % else:
        <div class="empty-state">
            <p>Nenhuma tarefa encontrada</p>
            <a href="/tasks/add" class="btn btn-primary">Criar Primeira Tarefa</a>
        </div>
        % end
    </div>
</section>