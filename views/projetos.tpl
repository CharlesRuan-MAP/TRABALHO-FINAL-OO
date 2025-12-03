%rebase('layout', title='Projetos')

<style>
.projetos-section {
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
}

.btn-primary {
    background: #007bff;
    color: white;
}

.btn-secondary {
    background: #6c757d;
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

.btn-view {
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

.projeto-link {
    text-decoration: none;
    color: #007bff;
    font-weight: bold;
}

.projeto-link:hover {
    text-decoration: underline;
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
</style>

<section class="projetos-section">
    <div class="section-header">
        <div>
            <h1 class="section-title">Meus Projetos</h1>
            <a href="/" class="btn btn-secondary" style="margin-right: 10px;">Home</a>
        </div>
        <a href="/projetos/add" class="btn btn-primary">➕ Novo Projeto</a>
    </div>

    <div class="table-container">
        % if projetos:
        <table class="styled-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Descrição</th>
                    <th>Data Criação</th>
                    <th>Ações</th>
                </tr>
            </thead>

            <tbody>
                % for projeto in projetos:
                <tr>
                    <td>{{projeto.id}}</td>
                    <td>
                        <a href="/projetos/{{projeto.id}}" class="projeto-link">
                            {{projeto.nome}}
                        </a>
                    </td>
                    <td>{{projeto.descricao}}</td>
                    <td>{{projeto.data_criacao}}</td>
                    
                    <td class="actions">
                        <a href="/projetos/{{projeto.id}}" class="btn btn-sm btn-view">👁️ Ver</a>
                        <a href="/projetos/edit/{{projeto.id}}" class="btn btn-sm btn-edit">Editar</a>
                        
                        <form action="/projetos/delete/{{projeto.id}}" method="post" 
                              onsubmit="return confirm('Tem certeza que deseja excluir este projeto e todas as suas tarefas?')">
                            <button type="submit" class="btn btn-sm btn-danger">🗑️ Excluir</button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
        % else:
        <div class="empty-state">
            <p>Nenhum projeto criado ainda</p>
            <a href="/projetos/add" class="btn btn-primary">Criar Primeiro Projeto</a>
        </div>
        % end
    </div>
</section>