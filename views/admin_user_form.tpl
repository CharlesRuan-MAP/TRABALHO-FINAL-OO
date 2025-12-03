%rebase('layout', title='Editar Usuário' if user else 'Novo Usuário - Admin')

<style>
.admin-form-container {
    max-width: 600px;
    margin: 0 auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.form-header {
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
}

.form-actions {
    display: flex;
    gap: 10px;
    margin-top: 30px;
}

.btn-save {
    background: #28a745;
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.btn-cancel {
    background: #6c757d;
    color: white;
    padding: 12px 25px;
    text-decoration: none;
    border-radius: 5px;
    text-align: center;
}

.alert-error {
    background: #f8d7da;
    color: #721c24;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 20px;
}
</style>

<div class="admin-form-container">
    <div class="form-header">
        <h1>{{'Editar Usuário' if user else 'Novo Usuário'}}</h1>
    </div>

    % if defined('erro'):
    <div class="alert-error">
        {{erro}}
    </div>
    % end

    <form action="{{action}}" method="post">
        <div class="form-group">
            <label for="nome">Nome Completo:</label>
            <input type="text" id="nome" name="nome" 
                   value="{{user.nome if user else ''}}" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" 
                   value="{{user.email if user else ''}}" required>
        </div>

        <div class="form-group">
            <label for="senha">{{'Nova Senha (deixe em branco para manter atual):' if user else 'Senha:'}}</label>
            <input type="password" id="senha" name="senha" 
                   {{'' if user else 'required'}}>
        </div>

        <div class="form-group">
            <label for="birthdate">Data de Nascimento:</label>
            <input type="date" id="birthdate" name="birthdate" 
                   value="{{user.birthdate if user else ''}}" required>
        </div>

        % if not user:
        <div class="form-group">
            <label for="tipo">Tipo de Usuário:</label>
            <select id="tipo" name="tipo">
                <option value="comum">Usuário Comum</option>
                <option value="admin">Administrador</option>
            </select>
        </div>
        % end

        <div class="form-actions">
            <button type="submit" class="btn-save">
                {{'Salvar Alterações' if user else 'Criar Usuário'}}
            </button>
            <a href="/admin/usuarios" class="btn-cancel">↩Cancelar</a>
        </div>
    </form>
</div>