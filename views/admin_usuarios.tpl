%rebase('layout', title='Gerenciar Usuários - Admin')

<style>
.admin-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee;
}

.btn-admin {
    background: #28a745;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
}

.btn-edit {
    background: #007bff;
    color: white;
    padding: 5px 10px;
    text-decoration: none;
    border-radius: 3px;
    font-size: 0.8em;
    margin-right: 5px;
}

.btn-danger {
    background: #dc3545;
    color: white;
    padding: 5px 10px;
    border: none;
    border-radius: 3px;
    font-size: 0.8em;
    cursor: pointer;
}

.btn-toggle {
    background: #ffc107;
    color: #212529;
    padding: 5px 10px;
    border: none;
    border-radius: 3px;
    font-size: 0.8em;
    cursor: pointer;
    margin-right: 5px;
}

.user-table {
    width: 100%;
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.user-table th,
.user-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.user-table th {
    background: #f8f9fa;
    font-weight: bold;
    color: #333;
}

.badge-admin {
    background: #fff3cd;
    color: #856404;
    padding: 3px 8px;
    border-radius: 12px;
    font-size: 0.8em;
    font-weight: bold;
}

.badge-user {
    background: #d1ecf1;
    color: #0c5460;
    padding: 3px 8px;
    border-radius: 12px;
    font-size: 0.8em;
    font-weight: bold;
}

.alert-error {
    background: #f8d7da;
    color: #721c24;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 20px;
}
</style>

<div class="admin-container">
    <div class="page-header">
        <h1>👥 Gerenciar Usuários</h1>
        <a href="/admin/usuarios/add" class="btn-admin">➕ Novo Usuário</a>
    </div>

    % if defined('erro'):
    <div class="alert-error">
        {{erro}}
    </div>
    % end

    <table class="user-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Tipo</th>
                <th>Data Nasc.</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            % for user in users:
            <tr>
                <td>{{user.id}}</td>
                <td>{{user.nome if hasattr(user, 'nome') else user.name}}</td>
                <td>{{user.email}}</td>
                <td>
                    <span class="{{'badge-admin' if user.tipo == 'admin' else 'badge-user'}}">
                        {{'Admin' if user.tipo == 'admin' else '👤 Usuário'}}
                    </span>
                </td>
                <td>{{user.birthdate}}</td>
                <td>
                    <form action="/admin/usuarios/toggle-admin/{{user.id}}" method="post" style="display: inline;">
                        <button type="submit" class="btn-toggle">
                            {{'Tornar Usuário' if user.tipo == 'admin' else 'Tornar Admin'}}
                        </button>
                    </form>
                    
                    <a href="/admin/usuarios/edit/{{user.id}}" class="btn-edit">Editar</a>
                    
                    <form action="/admin/usuarios/delete/{{user.id}}" method="post" 
                          onsubmit="return confirm('Tem certeza que deseja excluir este usuário?')" style="display: inline;">
                        <button type="submit" class="btn-danger">🗑️ Excluir</button>
                    </form>
                </td>
            </tr>
            % end
        </tbody>
    </table>

    % if not users:
    <div style="text-align: center; padding: 40px; color: #666;">
        <p>Nenhum usuário cadastrado no sistema.</p>
        <a href="/admin/usuarios/add" class="btn-admin">Criar Primeiro Usuário</a>
    </div>
    % end
</div>
